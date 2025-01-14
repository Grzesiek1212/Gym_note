import '../../models/exercise_model.dart';

class ExerciseService {
  Future<List<Exercise>> fetchExercisesByCategory(String category) async {
    // Simulate fetching data
    await Future.delayed(const Duration(milliseconds: 500));

    // Replace this Map with your actual data source (e.g., API response or database)
    final data = [
      {
        'name': 'Wyciskanie sztangi na ławce poziomej',
        'primaryMuscles': ['Klata piersiowa'],
        'secondaryMuscles': ['Triceps', 'Barki'],
        'level': 'Intermediate',
        'description': 'Ćwiczenie siłowe angażujące klatkę piersiową, tricepsy i barki.',
        'youtubeLink': 'https://www.youtube.com/watch?v=example1',
      },
      {
        'name': 'Rozpiętki na ławce skośnej',
        'primaryMuscles': ['Klata piersiowa'],
        'secondaryMuscles': ['Barki'],
        'level': 'Beginner',
        'description': 'Ćwiczenie rozciągające klatkę piersiową na ławce skośnej.',
        'youtubeLink': 'https://www.youtube.com/watch?v=example2',
      },
      {
        'name': 'Pompki klasyczne',
        'primaryMuscles': ['Klata piersiowa', 'Triceps'],
        'secondaryMuscles': ['Barki'],
        'level': 'Beginner',
        'description': 'Ćwiczenie kalisteniczne angażujące klatkę piersiową, tricepsy i barki.',
        'youtubeLink': 'https://www.youtube.com/watch?v=example3',
      },
    ];

    // Map the raw data to a list of Exercise objects
    return data.map((map) => Exercise.fromMap(map)).toList();
  }

  Future<List<Map<String, dynamic>>> fetchWeights(Exercise exercise) async {
    // Przykładowe dane - zastąp je własnym zapytaniem do źródła danych.
    await Future.delayed(const Duration(seconds: 1)); // Symulacja opóźnienia
    return [
      {'date': '2023-01-01', 'value': 50},
      {'date': '2023-01-01', 'value': 55},
      {'date': '2023-03-01', 'value': 60},
      {'date': '2023-04-01', 'value': 62},
    ];
  }
}
