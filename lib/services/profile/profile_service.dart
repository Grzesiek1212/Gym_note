import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

import '../../models/measurement_model.dart';

class ProfileService {

  Future<Map<String, dynamic>> fetchLatestMeasurements() async {
    var box = await Hive.openBox<Measurement>('measurements');

    List<String> types = [
      'waga',
      'wzrost',
      'tluszcz',
      'miesnie',
      'klatka_piersiowa',
      'biceps',
      'BMI',
      'przedramię',
      'brzuch',
      'biodra',
      'uda',
      'łydka',
    ];

    // Inicjalizacja mapy z domyślną wartością '-'
    Map<String, dynamic> latestMeasurements = {
      for (var type in types) type: '-',
    };

    // Iteracja po danych w boxie Hive
    for (var measurement in box.values) {
      if (types.contains(measurement.type)) {
        latestMeasurements[measurement.type] =
        measurement.value != null ? measurement.value.toString() : '-';
      }
    }

    return latestMeasurements;
  }

  Future<List<Map<String, dynamic>>> fetchMeasurementsByType(String type) async {
    var box = await Hive.openBox<Measurement>('measurements');

    final unit = await getTypeOfMeasurement(type);

    final filteredMeasurements = box.values
        .where((measurement) => measurement.type == type)
        .map((measurement) => {
      'value': measurement.value,
      'date': measurement.date.toString().split(' ')[0],
      'type': unit,
    })
        .toList();

    return filteredMeasurements;
  }

  Future<String> getTypeOfMeasurement(String type) async {
    switch (type) {
      case 'waga':
        return 'kg';
      case 'wzrost':
        return 'cm';
      case 'tluszcz':
        return '%';
      case 'miesnie':
        return '%';
      case 'klatka_piersiowa':
        return 'cm';
      case 'biceps':
        return 'cm';
      case 'przedramię':
        return 'cm';
      case 'brzuch':
        return 'cm';
      case 'biodra':
        return 'cm';
      case 'uda':
        return 'cm';
      case 'łydka':
        return 'cm';
      case 'BMI':
        return ''; // BMI jest jednostką bezwymiarową, więc brak jednostki
      default:
        return ''; // Zwróć pusty ciąg, jeśli typ nie jest rozpoznany
    }
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
