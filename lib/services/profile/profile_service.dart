import 'dart:io';

import 'package:flutter/cupertino.dart';

import '../../models/measurement_model.dart';

class ProfileService {

  Future<List<Measurement>> fetchUserMeasurements(int userId) async {
    // Simulate network or database call
    await Future.delayed(const Duration(milliseconds: 500));

    return [
      Measurement(
        id: 1,
        userId: userId,
        type: 'waga',
        value: 85.0,
        date: DateTime.now().subtract(const Duration(days: 1)),
      ),
      Measurement(
        id: 2,
        userId: userId,
        type: 'bmi',
        value: 26.53,
        date: DateTime.now().subtract(const Duration(days: 1)),
      ),
      Measurement(
        id: 3,
        userId: userId,
        type: 'klatka_piersiowa',
        value: 100.0,
        date: DateTime.now().subtract(const Duration(days: 1)),
      ),
    ];
  }

  Future<Map<String, dynamic>> fetchLatestMeasurements(int userId) async {
    // TODO: ask backend about info about the last user statistic
    await Future.delayed(const Duration(milliseconds: 500));

    return {
      'waga': 85.0,
      'wzrost': 179,
      'tluszcz': '-',
      'miesni': '-',
      'klatka_piersiowa': 100.0,
      'biceps': 38,
      'przedramię': '-',
      'brzuch': '-',
      'biodra': '-',
      'uda': '-',
      'łydka': '-',
    };
  }

  Future<List<Map<String, dynamic>>> fetchMeasurementsByType(
      String type) async {
    // TODO: ask backend about info about the type
    return [
      {'value': 85, 'date': '2023-12-01', 'type': "kg"},
      {'value': 87.0, 'date': '2023-12-08', 'type': "kg"},
      {'value': 86.5, 'date': '2023-12-15', 'type': "kg"},
      {'value': 88.5, 'date': '2023-12-15', 'type': "kg"},
    ];
    // Return empty list for other types
    return [];
  }

  Future<void> uploadImage(File image) async {
    // Tutaj implementuj logikę przesyłania zdjęcia do bazy
    debugPrint('Zdjęcie wysyłane: ${image.path}');
    // Dodaj API POST/PUT do przesyłania pliku
  }

  Future<List<Map<String, String>>> fetchUserPhotosWithDates() async {
    // Przykładowe dane
    return Future.delayed(
      const Duration(seconds: 2),
          () => [
        {'url': 'https://i.wpimg.pl/730x0/m.fitness.wp.pl/gettyimages-1139452970-e02e5eb40.jpg', 'date': '2025-01-01'},
        {'url': 'https://th.bing.com/th/id/OIP.GftZBLQFEMuoi3QdwfA_cwHaE7?rs=1&pid=ImgDetMain', 'date': '2025-01-02'},
        {'url': 'https://gomez.pl/orbitvu/481/SD212W000020002/sd212w000020002000s/images2d/sd212w000020002000s_4.jpg', 'date': '2025-01-03'},
      ],
    );
  }

}
