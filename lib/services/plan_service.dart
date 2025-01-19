import 'dart:async';
import '../models/exercise_model.dart';
import '../models/set_model.dart';
import '../models/training_exercise_model.dart';
import '../models/training_plan_card.dart';

class PlanService {
  List<TrainingPlanCard> plans = [];

  Future<List<TrainingPlanCard>> getPlans(bool isOwnPlans) async {

    plans = isOwnPlans
        ? [
      TrainingPlanCard(
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
        ],
        name: 'Plan Treningowy 1',
        createdAt: DateTime.now(),
        type: 'own',
      ),
    ]
        : [
      TrainingPlanCard(
        exercises: [
          TrainingExerciseModel(
            exercise: Exercise(
              name: 'Prostowanie nóg na maszynie',
              primaryMuscles: ['Nogi'],
              secondaryMuscles: ['Brzuch'],
              level: 'Średnio zaawansowany',
              description: 'Opis ćwiczenia...',
              youtubeLink: 'https://www.youtube.com',
            ),
            sets: [
              ExerciseSet(repetitions: 15, weight: 40.0),
              ExerciseSet(repetitions: 12, weight: 50.0),
            ],
          ),
          TrainingExerciseModel(
            exercise: Exercise(
              name: 'Wyciśnięcie w siadzie na maszynie',
              primaryMuscles: ['Klatka piersiowa'],
              secondaryMuscles: ['Barki'],
              level: 'Zaawansowany',
              description: 'Opis ćwiczenia...',
              youtubeLink: 'https://www.youtube.com',
            ),
            sets: [
              ExerciseSet(repetitions: 12, weight: 50.0),
              ExerciseSet(repetitions: 10, weight: 60.0),
            ],
          ),
        ],
        name: 'Gotowy Plan 1',
        createdAt: DateTime.now(),
        type: 'ready',
      ),
    ];

    return plans;
  }

  void deletePlan(String planName) {
    plans.removeWhere((plan) => plan.name == planName);
  }
}
