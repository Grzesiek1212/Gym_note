import 'package:hive/hive.dart';
import '../../../../core/data/models/set_model.dart';
import '../../../../core/data/models/training_exercise_model.dart';
import '../../../exercise/data/models/exercise_model.dart';
import '../../../plan/data/models/training_plan_card_model.dart';
import '../models/training_card_model.dart';


Future<void> addSampleTrainingData() async {

  // Pobierz dostępne ćwiczenia
  var exerciseBox = await Hive.openBox<Exercise>('exercises');
  final exercises = exerciseBox.values.toList();

  // Stwórz przykładowy plan treningowy
  final trainingPlan = TrainingPlanCardModel(
    name: 'Treining ogólny',
    createdAt: DateTime.now(),
    type: 'own',
    exercises: [
      TrainingExerciseModel(
        exercise: exercises.firstWhere((e) => e.name == 'Wyciskanie na ławce'),
        sets: [
          ExerciseSet(repetitions: 10, weight: 50.0),
          ExerciseSet(repetitions: 8, weight: 55.0),
        ],
      ),
      TrainingExerciseModel(
        exercise: exercises.firstWhere((e) => e.name == 'Martwy ciąg'),
        sets: [
          ExerciseSet(repetitions: 8, weight: 70.0),
          ExerciseSet(repetitions: 6, weight: 80.0),
        ],
      ),
      TrainingExerciseModel(
        exercise: exercises.firstWhere((e) => e.name == 'Wyciskanie sztangi nad głowę'),
        sets: [
          ExerciseSet(repetitions: 12, weight: 30.0),
        ],
      ),
      TrainingExerciseModel(
        exercise: exercises.firstWhere((e) => e.name == 'Podciąganie na drążku'),
        sets: [
          ExerciseSet(repetitions: 10, weight: 0.0),
          ExerciseSet(repetitions: 8, weight: 0.0),
        ],
      ),
      TrainingExerciseModel(
        exercise: exercises.firstWhere((e) => e.name == 'Przysiady ze sztangą'),
        sets: [
          ExerciseSet(repetitions: 10, weight: 60.0),
          ExerciseSet(repetitions: 8, weight: 65.0),
        ],
      ),
    ],
  );

  // Zapisz plan treningowy do bazy
  var trainingPlanBox = await Hive.openBox<TrainingPlanCardModel>('trainingPlanCards');
  await trainingPlanBox.add(trainingPlan);
  print("Dodano plan treningowy: ${trainingPlan.name}");

  // Stwórz cztery różne treningi bazujące na tym planie
  final trainingDates = [
    DateTime.now().subtract(Duration(days: 7)),
    DateTime.now().subtract(Duration(days: 5)),
    DateTime.now().subtract(Duration(days: 3)),
    DateTime.now(),
  ];

  for (var i = 0; i < trainingDates.length; i++) {
    final modifiedExercises = trainingPlan.exercises.map((exercise) {
      return TrainingExerciseModel(
        exercise: exercise.exercise,
        sets: exercise.sets.map((set) {
          // Zmieniaj powtórzenia i ciężar dla każdego treningu
          return ExerciseSet(
            repetitions: set.repetitions + (i * 2), // więcej powtórzeń
            weight: set.weight + (i * 2.5), // większy ciężar
          );
        }).toList(),
      );
    }).toList();

    final training = TrainingCard(
      exercises: modifiedExercises,
      date: trainingDates[i],
      duration: 60 + (i * 5),
      description: 'Trening siłowy ${i + 1}',
    );

    var trainingBox = await Hive.openBox<TrainingCard>('trainingCards');
    await trainingBox.add(training);
    print("Dodano trening z dnia: ${training.date}");
  }
}
