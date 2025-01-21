import 'package:hive/hive.dart';
import '../../models/set_model.dart';
import '../../models/training_exercise_model.dart';
import '../../models/training_plan_card_model.dart';
import '../../models/exercise_model.dart';

Future<void> addTrainingPlans() async {
  var trainingPlanBox = await Hive.openBox<TrainingPlanCardModel>('trainingPlanCards');
  var exerciseBox = await Hive.openBox<Exercise>('exercises');

  if (trainingPlanBox.isEmpty) {
    // Pobranie ćwiczeń z bazy
    final exercises = exerciseBox.values.toList();

    if (exercises.isEmpty) {
      print('Brak ćwiczeń w bazie. Najpierw dodaj ćwiczenia.');
      return;
    }

    // Definicja przykładowych planów treningowych
    final plans = [
      TrainingPlanCardModel(
        name: 'Plan na masę - Góra ciała',
        createdAt: DateTime.now(),
        type: 'ready',
        exercises: [
          exercises.firstWhere((e) => e.name == 'Wyciskanie na ławce').toTrainingExercise(),
          exercises.firstWhere((e) => e.name == 'Podciąganie na drążku').toTrainingExercise(),
          exercises.firstWhere((e) => e.name == 'Wyciskanie hantli na skosie').toTrainingExercise(),
          exercises.firstWhere((e) => e.name == 'Arnoldki').toTrainingExercise(),
          exercises.firstWhere((e) => e.name == 'Francuskie wyciskanie').toTrainingExercise(),
        ],
      ),
      TrainingPlanCardModel(
        name: 'Plan na rzeźbę - Całe ciało',
        createdAt: DateTime.now(),
        type: 'ready',
        exercises: [
          exercises.firstWhere((e) => e.name == 'Burpees').toTrainingExercise(),
          exercises.firstWhere((e) => e.name == 'Przysiady ze sztangą').toTrainingExercise(),
          exercises.firstWhere((e) => e.name == 'Mountain Climbers').toTrainingExercise(),
          exercises.firstWhere((e) => e.name == 'Plank').toTrainingExercise(),
          exercises.firstWhere((e) => e.name == 'Martwy ciąg').toTrainingExercise(),
        ],
      ),
      TrainingPlanCardModel(
        name: 'Plan na siłę - Dolne partie',
        createdAt: DateTime.now(),
        type: 'ready',
        exercises: [
          exercises.firstWhere((e) => e.name == 'Przysiady ze sztangą').toTrainingExercise(),
          exercises.firstWhere((e) => e.name == 'Martwy ciąg na prostych nogach').toTrainingExercise(),
          exercises.firstWhere((e) => e.name == 'Hip Thrust').toTrainingExercise(),
          exercises.firstWhere((e) => e.name == 'Wspięcia na palce na maszynie').toTrainingExercise(),
          exercises.firstWhere((e) => e.name == 'Przysiad bułgarski').toTrainingExercise(),
        ],
      ),
    ];

    await trainingPlanBox.addAll(plans);
    print('Plany treningowe zostały pomyślnie dodane.');
  } else {
    print('Box trainingPlanCards już zawiera dane.');
  }
}

extension on Exercise {
  TrainingExerciseModel toTrainingExercise() {
    return TrainingExerciseModel(
      exercise: this,
      sets: [ExerciseSet(
        repetitions: 0, // Liczba powtórzeń
        weight: 0.0, // Waga w kg
      ),], // Puste serie, można je wypełnić później
    );
  }
}
