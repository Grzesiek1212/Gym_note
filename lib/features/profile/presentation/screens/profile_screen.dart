import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../data/services/profile_service.dart';
import '../widgets/body_measurements/body_measurement_row_widget.dart';
import '../widgets/general_measurements/general_data_row_widget.dart';
import '../widgets/photo/profile_photo_section_widget.dart';
import '../widgets/section_header_widget.dart';
import 'add_general_measurement_screen.dart';
import 'add_measurement_screen.dart';
import 'edit_general_measurements_screen.dart';
import 'edit_measurement_screen.dart';
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
                    SectionHeaderWidget(
                      title: 'Dane ogólne',
                      onEdit: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                            const EditGeneralMeasurementsScreen(),
                          ),
                        );
                      },
                      onAdd: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                            const AddGeneralMeasurementsScreen(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 8),
                    GeneralDataRowWidget(
                      label: 'Waga',
                      value: '${data['weight']} kg',
                      icon: Icons.arrow_forward,
                    ),
                    GeneralDataRowWidget(
                      label: 'Wzrost',
                      value: '${data['height']} cm',
                      icon: Icons.arrow_forward,
                    ),
                    GeneralDataRowWidget(
                      label: 'BMI',
                      value: '${data['BMI']}',
                      icon: Icons.arrow_forward,
                    ),
                    GeneralDataRowWidget(
                      label: 'Tłuszcz',
                      value: '${data['fat']} %',
                      icon: Icons.arrow_forward,
                    ),
                    GeneralDataRowWidget(
                      label: 'Mięśnie',
                      value: '${data['muscles']} %',
                      icon: Icons.arrow_forward,
                    ),
                    const SizedBox(height: 16),
                    SectionHeaderWidget(
                      title: 'Pomiary ciała',
                      onEdit: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                            const EditMeasurementsScreen(),
                          ),
                        );
                      },
                      onAdd: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                            const AddMeasurementScreen(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 8),
                    BodyMeasurementRowWidget(
                      label: 'Klatka piersiowa',
                      value: '${data['chest']} cm',
                    ),
                    BodyMeasurementRowWidget(
                      label: 'Lewy biceps',
                      value: '${data['leftBiceps']} cm',
                    ),
                    BodyMeasurementRowWidget(
                      label: 'Prawy biceps',
                      value: '${data['rightBiceps']} cm',
                    ),
                    BodyMeasurementRowWidget(
                      label: 'Lewe przedramie',
                      value: '${data['leftForearm']} cm',
                    ),
                    BodyMeasurementRowWidget(
                      label: 'Prawe przedramie',
                      value: '${data['rightForearm']} cm',
                    ),
                    BodyMeasurementRowWidget(
                      label: 'Talia',
                      value: '${data['waist']} cm',
                    ),
                    BodyMeasurementRowWidget(
                      label: 'Biodra',
                      value: '${data['hips']} cm',
                    ),
                    BodyMeasurementRowWidget(
                      label: 'Udo',
                      value: '${data['thigh']} cm',
                    ),
                    BodyMeasurementRowWidget(
                      label: 'Łydka',
                      value: '${data['calf']} cm',
                    ),
                    const SizedBox(height: 16),
                    ProfilePhotoSectionWidget(
                      image: _image,
                      onTakePicture: _takePicture,
                      onViewPhotos: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const UserPhotosScreen(),
                          ),
                        );
                      },
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
}
