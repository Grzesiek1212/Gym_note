import 'package:gym_note/models/measurement_model.dart';
import 'package:hive/hive.dart';

class ProfileGeneralMeasurementService {

  Future<void> saveGeneralMeasurements(Map<String, String> generalMeasurements) async {
    var box = await Hive.openBox<Measurement>('measurements');

    for (var entry in generalMeasurements.entries) {
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

    print('Zapisano dane ogólne: $generalMeasurements');
  }

  Future<Map<String, String>> fetchGeneralMeasurementsByDate(String date) async {
    // TODO: pobieranie głównych danych po dacie
    return {
      'waga': '86.5',
      'wzrost': '180',
      'tluszcz': '18',
      'miesnie': '40',
    };
  }

  Future<void> updateGeneralMeasurements({
    required String date,
    required Map<String, String> measurements,
  }) async {
    // TODO: Wyślij datę i pomiary do backendu
    print('Dane zapisane: $measurements dla daty: $date');
  }

  Future<List<String>> fetchGeneralAvailableDates() async {
    // TODO: pobierz dostępne daty
    return ['2023-12-01', '2023-12-08', '2023-12-15'];
  }


}
