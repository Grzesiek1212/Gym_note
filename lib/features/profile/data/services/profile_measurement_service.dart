import 'package:hive/hive.dart';
import '../models/measurement_model.dart';


class ProfileMeasurementService {
  Future<void> saveMeasurements(Map<String, String> Measurements) async {
    var box = await Hive.openBox<Measurement>('measurements');

    for (var entry in Measurements.entries) {
      final type = entry.key;
      final value = entry.value;

      final parsedValue = double.tryParse(value) ?? 0.0;

      final measurement = Measurement(
        id: box.length + 1,
        type: type,
        value: parsedValue,
        date: DateTime.now(),
      );

      await box.add(measurement);
    }

    print('Zapisano dane : $Measurements');
  }
  Future<Map<String, String>> fetchMeasurementsByDate(String date) async {
    var box = await Hive.openBox<Measurement>('measurements');

    final filteredMeasurements = box.values
        .where((measurement) =>
    measurement.date.toIso8601String().split('T')[0] == date)
        .where((measurement) =>
        ['chest', 'leftBiceps', 'rightBiceps', 'BMI', 'leftForearm',
          'rightForearm', 'waist', 'hips', 'thigh', 'calf',].contains(measurement.type))
        .toList();

    final result = {
      for (var measurement in filteredMeasurements)
        measurement.type: measurement.value.toString(),
    };

    return result;
  }


  Future<void> updateMeasurements({
    required String date,
    required Map<String, String> measurements,
  }) async {
    var box = await Hive.openBox<Measurement>('measurements');

    final existingMeasurements = box.values
        .where((measurement) =>
    measurement.date.toIso8601String().split('T')[0] == date)
        .where((measurement) =>
        measurements.keys.contains(measurement.type))
        .toList();

    for (var measurement in existingMeasurements) {
      final newValue = measurements[measurement.type];
      if (newValue != null) {
        final parsedValue = double.tryParse(newValue) ?? 0.0;
        final updatedMeasurement = Measurement(
          id: measurement.id,
          type: measurement.type,
          value: parsedValue,
          date: measurement.date,
        );
        await box.put(measurement.key, updatedMeasurement);
      }
    }

    print('Zaktualizowano dane : $measurements dla daty: $date');
  }
  Future<List<String>> fetchAvailableDates() async {
    var box = await Hive.openBox<Measurement>('measurements');
    String type = 'chest';
    final datesWithType = box.values
        .where((measurement) => measurement.type == type)
        .map((measurement) => measurement.date.toIso8601String().split('T')[0])
        .toSet()
        .toList();

    print('Dates with type "$type": $datesWithType');
    return datesWithType;
  }

}
