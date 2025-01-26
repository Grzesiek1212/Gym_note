import 'package:hive/hive.dart';
import '../models/measurement_model.dart';

Future<void> addSampleProfileData() async {
  var measurementsBox = await Hive.openBox<Measurement>('measurements');

  final measurementDates = [
    DateTime.now().subtract(Duration(days: 30)),
    DateTime.now().subtract(Duration(days: 20)),
    DateTime.now().subtract(Duration(days: 10)),
    DateTime.now().subtract(Duration(days: 5)),
    DateTime.now(),
  ];

  final generalMeasurementsList = [
    {
      'weight': 70.5,
      'height': 175.0,
      'fat': 15.2,
      'muscles': 40.3,
      'BMI': double.parse(
          (70.5 / ((175.0 / 100) * (175.0 / 100))).toStringAsFixed(2))
    },
    {
      'weight': 71.0,
      'height': 175.0,
      'fat': 15.0,
      'muscles': 40.5,
      'BMI': double.parse(
          (71.0 / ((175.0 / 100) * (175.0 / 100))).toStringAsFixed(2))
    },
    {
      'weight': 71.2,
      'height': 175.0,
      'fat': 14.8,
      'muscles': 40.7,
      'BMI': double.parse(
          (71.2 / ((175.0 / 100) * (175.0 / 100))).toStringAsFixed(2))
    },
    {
      'weight': 71.5,
      'height': 175.0,
      'fat': 14.5,
      'muscles': 41.0,
      'BMI': double.parse(
          (71.5 / ((175.0 / 100) * (175.0 / 100))).toStringAsFixed(2))
    },
    {
      'weight': 72.0,
      'height': 175.0,
      'fat': 14.2,
      'muscles': 41.3,
      'BMI': double.parse(
          (72.0 / ((175.0 / 100) * (175.0 / 100))).toStringAsFixed(2))
    },
  ];

  final bodyMeasurementsList = [
    {
      'chest': 95.0,
      'leftBiceps': 32.0,
      'rightBiceps': 33.0,
      'leftForearm': 25.0,
      'rightForearm': 26.0,
      'waist': 80.0,
      'hips': 90.0,
      'thigh': 55.0,
      'calf': 38.0,
    },
    {
      'chest': 95.0,
      'leftBiceps': 32.5,
      'rightBiceps': 33.5,
      'leftForearm': 25.5,
      'rightForearm': 26.5,
      'waist': 79.5,
      'hips': 90.5,
      'thigh': 55.5,
      'calf': 38.5,
    },
    {
      'chest': 96.0,
      'leftBiceps': 33.0,
      'rightBiceps': 34.0,
      'leftForearm': 26.0,
      'rightForearm': 27.0,
      'waist': 79.0,
      'hips': 91.0,
      'thigh': 56.0,
      'calf': 39.0,
    },
    {
      'chest': 98.0,
      'leftBiceps': 33.5,
      'rightBiceps': 34.5,
      'leftForearm': 26.5,
      'rightForearm': 27.5,
      'waist': 78.5,
      'hips': 91.5,
      'thigh': 56.5,
      'calf': 39.5,
    },
    {
      'chest': 99.0,
      'leftBiceps': 34.0,
      'rightBiceps': 35.0,
      'leftForearm': 27.0,
      'rightForearm': 28.0,
      'waist': 78.0,
      'hips': 92.0,
      'thigh': 57.0,
      'calf': 40.0,
    },
  ];

  for (var i = 0; i < measurementDates.length; i++) {
    final date = measurementDates[i];

    // Add general measurements
    generalMeasurementsList[i].forEach((type, value) {
      final measurement = Measurement(
        id: measurementsBox.length + 1,
        type: type,
        value: value,
        date: date,
      );
      measurementsBox.add(measurement);
    });

    // Add body measurements
    bodyMeasurementsList[i].forEach((type, value) {
      final measurement = Measurement(
        id: measurementsBox.length + 1,
        type: type,
        value: value,
        date: date,
      );
      measurementsBox.add(measurement);
    });

    print("Dodano pomiary z dnia: $date");
  }
}
