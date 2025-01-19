import 'dart:async';
import '../models/training_card_model.dart';
import '../models/training_exercise_model.dart';
import '../models/exercise_model.dart';
import '../models/set_model.dart';

class HistoryService {
  Future<List<TrainingCard>> getTrainingHistory() async {

    List<TrainingCard> history = [
      TrainingCard(
        exercises: [
          TrainingExerciseModel(
            exercise: Exercise(
              name: 'Wyciśnięcie sztangi na płaskiej ławce',
              primaryMuscles: ['Klatka piersiowa'],
              secondaryMuscles: ['Triceps', 'Barki'],
              level: 'Zaawansowany',
              description: 'Opis ćwiczenia...',
              youtubeLink: 'https://www.youtube.com',
            ),
            sets: [
              ExerciseSet(repetitions: 12, weight: 60.0),
              ExerciseSet(repetitions: 10, weight: 70.0),
            ],
          ),
          TrainingExerciseModel(
            exercise: Exercise(
              name: 'Wiosłowanie na maszynie',
              primaryMuscles: ['Plecy'],
              secondaryMuscles: ['Biceps'],
              level: 'Średnio zaawansowany',
              description: 'Opis ćwiczenia...',
              youtubeLink: 'https://www.youtube.com',
            ),
            sets: [
              ExerciseSet(repetitions: 12, weight: 40.0),
              ExerciseSet(repetitions: 10, weight: 50.0),
            ],
          ),
          TrainingExerciseModel(
            exercise: Exercise(
              name: ' Podciąganie ',
              primaryMuscles: ['Plecy'],
              secondaryMuscles: ['Biceps'],
              level: 'Średnio zaawansowany',
              description: 'Opis ćwiczenia...',
              youtubeLink: 'https://www.youtube.com',
            ),
            sets: [
              ExerciseSet(repetitions: 12, weight: 40.0),
              ExerciseSet(repetitions: 10, weight: 50.0),
              ExerciseSet(repetitions: 10, weight: 60.0),
            ],
          ),
        ],
        date: DateTime(2024, 11, 7,12,12,12),
        duration: 123,
        description: "Bardzo fajny trening"
      ),
      // Dodaj inne przykłady historii treningów
    ];

    return history;
  }

  Future<void> updateTrainingDescription(TrainingCard trainingCard) async {
    await Future.delayed(const Duration(milliseconds: 500)); // Symulacja opóźnienia
    print("Opis treningu został zaktualizowany na: ${trainingCard.description}");
  }
}
