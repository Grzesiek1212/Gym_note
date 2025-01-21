import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../data/services/profile_service.dart';
import 'add_general_measurement_screen.dart';
import 'add_measurement_screen.dart';
import 'edit_general_measurements_screen.dart';
import 'edit_measurement_screen.dart';
import 'section_detail_screen.dart';
import 'user_photos_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileService _profileService = ProfileService();
  late Future<Map<String, dynamic>> _latestMeasurementsFuture;
  File? _image;

  Future<void> _requestPermissions() async {
    final status = await Permission.camera.request();
    if (status.isGranted) {
      debugPrint('Camera permission granted');
    } else if (status.isDenied) {
      debugPrint('Camera permission denied');
    } else if (status.isPermanentlyDenied) {
      debugPrint(
          'Camera permission permanently denied. Please enable it from settings.');
    }
  }

  @override
  void initState() {
    super.initState();
    _latestMeasurementsFuture = _profileService.fetchLatestMeasurements();
    _requestPermissions();
  }

  Future<void> _takePicture() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedImage = await picker.pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.front,
    );

    if (pickedImage != null) {
      try {
        await _profileService.uploadImage(File(pickedImage.path));
        debugPrint('Zdjęcie zostało wysłane do bazy.');
      } catch (e) {
        debugPrint('Błąd przy wysyłaniu zdjęcia: $e');
      }
    } else {
      debugPrint('Nie wybrano zdjęcia.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
        backgroundColor: const Color(0xFFF5F5F5),
        elevation: 0,
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _latestMeasurementsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final data = snapshot.data!;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Dane ogólne',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blue),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const EditGeneralMeasurementsScreen(),
                                  ),
                                );
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.add, color: Colors.green),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const AddGeneralMeasurementsScreen(),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    _buildGeneralDataRow(context, 'Waga',
                        '${data['weight']} kg', Icons.arrow_forward),
                    _buildGeneralDataRow(context, 'Wzrost',
                        '${data['height']} cm', Icons.arrow_forward),
                    _buildGeneralDataRow(
                        context, 'BMI', '${data['BMI']}', Icons.arrow_forward),
                    _buildGeneralDataRow(context, 'Tłuszcz', '${data['fat']} %',
                        Icons.arrow_forward),
                    _buildGeneralDataRow(context, 'Mięśnie',
                        '${data['muscles']} %', Icons.arrow_forward),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Pomiary ciała',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blue),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const EditMeasurementsScreen(),
                                  ),
                                );
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.add, color: Colors.green),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const AddMeasurementScreen(),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    _buildBodyMeasurementRow(
                        context, 'Klatka piersiowa', '${data['chest']} cm'),
                    _buildBodyMeasurementRow(
                        context, 'Lewy biceps', '${data['leftBiceps']} cm'),
                    _buildBodyMeasurementRow(
                        context, 'Prawy biceps', '${data['rightBiceps']} cm'),
                    _buildBodyMeasurementRow(
                        context, 'Lewe przedramie', '${data['leftForearm']} cm'),
                    _buildBodyMeasurementRow(
                        context, 'Prawe przedramie', '${data['rightForearm']} cm'),
                    _buildBodyMeasurementRow(
                        context, 'Talia', '${data['waist']} cm'),
                    _buildBodyMeasurementRow(
                        context, 'Biodra', '${data['hips']} cm'),
                    _buildBodyMeasurementRow(
                        context, 'Udo', '${data['thigh']} cm'),
                    _buildBodyMeasurementRow(
                        context, 'Łydka', '${data['calf']} cm'),
                    const SizedBox(height: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Zdjęcie sylwetki',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        if (_image != null)
                          Image.file(
                            _image!,
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        const SizedBox(height: 8),
                        ElevatedButton.icon(
                          icon: const Icon(
                            Icons.camera_alt,
                            color: Colors.green,
                          ),
                          label: const Text(
                            'Zrób zdjęcie',
                            style: TextStyle(color: Colors.black54),
                          ),
                          onPressed: _takePicture,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton.icon(
                          icon: const Icon(
                            Icons.photo_album,
                            color: Colors.green,
                          ),
                          label: const Text(
                            'Zobacz zdjęcia użytkownika',
                            style: TextStyle(color: Colors.black54),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const UserPhotosScreen(), // Nowy ekran
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Center(child: Text('Brak danych.'));
          }
        },
      ),
    );
  }

  Widget _buildGeneralDataRow(
      BuildContext context, String label, String value, IconData? icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16),
          ),
          Row(
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (icon != null) ...[
                const SizedBox(width: 4),
                IconButton(
                  icon: Icon(
                    icon,
                    color: Colors.grey,
                    size: 18,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            SectionDetailScreen(section: label),
                      ),
                    );
                  },
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBodyMeasurementRow(
      BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(
            Icons.fitness_center,
            size: 24,
            color: Colors.grey,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.arrow_forward,
              color: Colors.grey,
              size: 18,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SectionDetailScreen(section: label),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
