import 'package:hive/hive.dart';
import '../../models/exercise_model.dart';

class ExerciseService {
  Future<List<Exercise>> fetchExercisesByCategory(String category) async {
    // Otwórz box exercises
    var box = await Hive.openBox<Exercise>('exercises');

    // Pobierz ćwiczenia z bazy danych, filtrując po kategorii (primaryMuscles)
    final exercises = box.values.where((exercise) {
      return exercise.primaryMuscles.contains(category);
    }).toList();

    return exercises;
  }

  Future<List<Map<String, dynamic>>> fetchWeights(Exercise exercise) async {
    // TODO: Tutaj musimy założyć, że dane dotyczące ciężarów są przechowywane w innej tabeli
    // Otwórz box o nazwie "weights" (przykładowo)
    var box = await Hive.openBox<Map>('weights');

    // Pobierz dane z bazy, które pasują do ćwiczenia
    final weights = box.values.where((weightEntry) {
      return weightEntry['exerciseName'] == exercise.name;
    }).toList();

    // Mapuj wyniki na listę map
    return weights.map((entry) {
      return {
        'date': entry['date'],
        'value': entry['value'],
      };
    }).toList();
  }
}
