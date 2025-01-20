import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

import '../../models/measurement_model.dart';

class ProfileService {

  Future<Map<String, dynamic>> fetchLatestMeasurements() async {
    var box = await Hive.openBox<Measurement>('measurements');

    for (var key in box.keys) {
      final measurement = box.get(key);
      if (measurement != null) {
        print('Key: $key, Type: ${measurement.type}, Value: ${measurement.value}');
      } else {
        print('Key: $key has a null value in the box.');
      }
    }

    List<String> types = [
      'weight',
      'height',
      'fat',
      'muscles',
      'chest',
      'leftBiceps',
      'rightBiceps',
      'BMI',
      'leftForearm',
      'rightForearm',
      'waist',
      'hips',
      'thigh',
      'calf',
    ];
    Map<String, dynamic> latestMeasurements = {
      for (var type in types) type: '-',
    };

    for (var measurement in box.values) {
      if (types.contains(measurement.type)) {
        if (measurement.value != null) {
          latestMeasurements[measurement.type] = measurement.value.toString();
        } else {
          latestMeasurements[measurement.type] = '-';
        }
      }
    }

    return latestMeasurements;
  }

  Future<List<Map<String, dynamic>>> fetchMeasurementsByType(String type) async {
    var box = await Hive.openBox<Measurement>('measurements');
    final measurementType = await getNameOfSection(type);
    final unit = await getMeasurementUnit(measurementType);

    final filteredMeasurements = box.values
        .where((measurement) => measurement.type == measurementType)
        .map((measurement) => {
      'value': measurement.value,
      'date': measurement.date.toString().split(' ')[0],
      'type': unit,
    })
        .toList();

    return filteredMeasurements;
  }

  Future<String> getMeasurementUnit(String type) async {
    const units = {
      'weight': 'kg',
      'height': 'cm',
      'fat': '%',
      'muscles': '%',
      'chest': 'cm',
      'leftBiceps': 'cm',
      'rightBiceps': 'cm',
      'leftForearm': 'cm',
      'rightForearm': 'cm',
      'waist': 'cm',
      'hips': 'cm',
      'thigh': 'cm',
      'calf': 'cm',
      'BMI': '',
    };

    return units[type] ?? '';
  }

  Future<void> uploadImage(File image) async {
    // TODO: implementuj logikę przesyłania zdjęcia do bazy
    debugPrint('Zdjęcie wysyłane: ${image.path}');
    // Dodaj API POST/PUT do przesyłania pliku
  }

  Future<List<Map<String, String>>> fetchUserPhotosWithDates() async {
    return Future.delayed(
      const Duration(seconds: 2),
          () => [
        {'url': 'https://i.wpimg.pl/730x0/m.fitness.wp.pl/gettyimages-1139452970-e02e5eb40.jpg', 'date': '2025-01-01'},
        {'url': 'https://th.bing.com/th/id/OIP.GftZBLQFEMuoi3QdwfA_cwHaE7?rs=1&pid=ImgDetMain', 'date': '2025-01-02'},
        {'url': 'https://gomez.pl/orbitvu/481/SD212W000020002/sd212w000020002000s/images2d/sd212w000020002000s_4.jpg', 'date': '2025-01-03'},
      ],
    );
  }

  Future<String> getNameOfSection(String type) async {
    const sectionNames = {
      'Waga': 'weight',
      'Wzrost': 'height',
      'Tłuszcz': 'fat',
      'Mięśnie': 'muscles',
      'Klatka piersiowa': 'chest',
      'Lewy biceps': 'leftBiceps',
      'Prawy biceps': 'rightBiceps',
      'Lewe przedramie': 'leftForearm',
      'Prawe przedramie': 'rightForearm',
      'Talia': 'waist',
      'Biodra': 'hips',
      'Udo': 'thigh',
      'Łydka': 'calf',
      'BMI': 'BMI',
    };
    return sectionNames[type] ?? '';
  }


}
