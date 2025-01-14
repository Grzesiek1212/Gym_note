import '../../models/measurement_model.dart';

class ProfileMeasurementService {
  Future<void> saveMeasurements(Map<String, String> measurements) async {
    // TODO: wysłanie nowych pomiarów
    print('Dane zapisane: $measurements');
  }
  Future<Map<String, String>> fetchMeasurementsByDate(String date) async {
    // TODO: pobieranie  danych ciała po dacie
    return {
      'klatka_piersiowa': '102',
      'biceps_lewy': '37',
      'biceps_prawy': '38',
      'przedramie_lewe': '25',
      'przedramie_prawe': '27',
      'brzuch': '74',
      'biodra': '78',
      'uda': '54',
      'lydka': '35',
    };
  }
  Future<void> updateMeasurements({
    required String date,
    required Map<String, String> measurements,
  }) async {
    // TODO: Wyślij datę i pomiary do backendu
    print('Dane zapisane: $measurements dla daty: $date');
  }
  Future<List<String>> fetchAvailableDates() async {
    // TODO: pobierz dostępne daty
    return ['2023-12-01', '2023-12-08', '2023-12-15'];
  }

}
