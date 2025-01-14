import 'package:flutter/material.dart';
import '../../services/profile/profile_service.dart';

class UserPhotosScreen extends StatefulWidget {
  const UserPhotosScreen({Key? key}) : super(key: key);

  @override
  _UserPhotosScreenState createState() => _UserPhotosScreenState();
}

class _UserPhotosScreenState extends State<UserPhotosScreen> {
  final ProfileService _profileService = ProfileService();
  late Future<List<Map<String, String>>> _photosFuture;
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _photosFuture = _profileService.fetchUserPhotosWithDates();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Zdjęcia użytkownika'),
      ),
      body: FutureBuilder<List<Map<String, String>>>(
        future: _photosFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Błąd: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final photos = snapshot.data!;
            if (photos.isEmpty) {
              return const Center(child: Text('Brak zdjęć do wyświetlenia.'));
            }

            return Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    itemCount: photos.length,
                    itemBuilder: (context, index) {
                      final photo = photos[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Image.network(
                              photo['url']!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Data: ${photo['date']}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Text(
                  'Zdjęcie ${_currentPage + 1} z ${photos.length}',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            );
          } else {
            return const Center(child: Text('Nie znaleziono zdjęć.'));
          }
        },
      ),
    );
  }
}

