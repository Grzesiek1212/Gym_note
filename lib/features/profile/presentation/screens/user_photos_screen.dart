import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../data/services/profile_service.dart';
import '../widgets/photo/photo_display_widget.dart';
import '../widgets/photo/photo_navigation_widget.dart';

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

  final DateFormat _dateFormatter = DateFormat('yyyy-MM-dd HH:mm:ss');

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
        backgroundColor: Colors.white70,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white70, Colors.green],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: FutureBuilder<List<Map<String, String>>>(
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
                        final date = photo['date'];
                        final formattedDate = date != null
                            ? _dateFormatter.format(DateTime.parse(date))
                            : 'Nieznana data';

                        return PhotoDisplayWidget(
                          filePath: photo['url']!,
                          date: formattedDate,
                        );
                      },
                    ),
                  ),
                  PhotoNavigationWidget(
                    currentPage: _currentPage,
                    totalPhotos: photos.length,
                  ),
                ],
              );
            } else {
              return const Center(child: Text('Nie znaleziono zdjęć.'));
            }
          },
        ),
      ),
    );
  }
}
