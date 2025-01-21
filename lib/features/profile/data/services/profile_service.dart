import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:gym_note/features/profile/data/models/photo_model.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import '../models/measurement_model.dart';

class ProfileService {
  Future<Map<String, dynamic>> fetchLatestMeasurements() async {
    var box = await Hive.openBox<Measurement>('measurements');

    for (var key in box.keys) {
      final measurement = box.get(key);
      if (measurement != null) {
        print(
            'Key: $key, Type: ${measurement.type}, Value: ${measurement.value}');
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

  Future<List<Map<String, dynamic>>> fetchMeasurementsByType(
      String type) async {
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

  Future<List<Map<String, String>>> fetchUserPhotosWithDates() async {
    var box = await Hive.openBox<PhotoModel>('PhotoModels');

    List<Map<String, String>> photosWithDates = box.values.map((photoModel) {
      return {
        'url': photoModel.photoURL,
        'date': photoModel.dateAT.toIso8601String(),
      };
    }).toList();

    return photosWithDates;
  }

  Future<void> uploadImage(File image) async {
    var box = await Hive.openBox<PhotoModel>('PhotoModels');

    final appDir = await getApplicationDocumentsDirectory();
    final fileName = DateTime.now().toIso8601String() + '.jpg';
    final savedImage = await File(image.path).copy('${appDir.path}/$fileName');

    final photoModel = PhotoModel(
      photoURL: savedImage.path,
      dateAT: DateTime.now(),
    );

    await box.add(photoModel);

    debugPrint('Zdjęcie zapisane lokalnie: ${savedImage.path}');
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
