import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../../models/exercise_model.dart';
import '../../models/set_model.dart';
import '../../models/training_card_model.dart';
import '../../models/training_exercise_model.dart';
import '../../models/training_plan_card_model.dart';

class TrainingService with ChangeNotifier {
  List<TrainingExerciseModel> _trainingExercisesList = [];
  DateTime? trainingStartDate;
  bool isTrainingStarted = false;

  List<TrainingExerciseModel> get trainingExercisesList => _trainingExercisesList;

  int get trainingTime {
    if (trainingStartDate == null) {
      return 0;
    }
    return DateTime.now().difference(trainingStartDate!).inMinutes;
  }

  void setTrainingFromPlan(TrainingPlanCardModel trainingPlanCard) {
    _trainingExercisesList = List<TrainingExerciseModel>.from(trainingPlanCard.exercises);
    notifyListeners();
  }

  void startTrainingTime() {
    trainingStartDate = DateTime.now();
    notifyListeners();
  }

  void addExerciseToTraining(Exercise exercise) {
    var newTrainingExercise = TrainingExerciseModel(
      exercise: exercise,
      sets: [],
    );
    _trainingExercisesList.add(newTrainingExercise);
    notifyListeners();
  }

  void addTrainingExercise(TrainingExerciseModel trainingExercise) {
    _trainingExercisesList.add(trainingExercise);
    notifyListeners();
  }

  void removeExerciseFromTraining(TrainingExerciseModel trainingExercise) {
    _trainingExercisesList.remove(trainingExercise);
    notifyListeners();
  }

  void addSetToExercise(TrainingExerciseModel exercise, int repetitions, double weight) {
    exercise.sets.add(ExerciseSet(repetitions: repetitions, weight: weight));
    notifyListeners();
  }

  void removeSetFromExercise(TrainingExerciseModel exercise, int index) {
    exercise.sets.removeAt(index);
    notifyListeners();
  }

  Future<void> finishAndResetTraining(bool isNew, String planName, String descrition) async {
    await saveTrainingData(descrition);
    if (isNew) {
      await savePlanTrainingData(planName);
    } else {
      await updatePlanSets(planName);
    }

    trainingStartDate = null;
    _trainingExercisesList.clear();
    notifyListeners();
  }

  Future<void> saveTrainingData(String descrition) async{
    final training = TrainingCard(
      exercises: List<TrainingExerciseModel>.from(_trainingExercisesList),
      date: DateTime.now(),
      duration: trainingTime,
      description: descrition,
    );
    var trainingBox = await Hive.openBox<TrainingCard>('trainingCards');
    // Save the training card to the database
    await trainingBox.add(training);
    print("Zapisano trening: ${training.toMap()}");
  }

  Future<void> savePlanTrainingData(String planName) async {
    var trainingPlanBox = await Hive.openBox<TrainingPlanCardModel>('trainingPlanCards ');

    final trainingPlan = TrainingPlanCardModel(
      exercises: List<TrainingExerciseModel>.from(_trainingExercisesList),
      name:  planName,
      createdAt: DateTime.now(),
      type: 'own',
    );

    await trainingPlanBox.add(trainingPlan);

    print("Zapisano trening-plan w bazie: ${trainingPlan.toMap()}");
  }

  List<TrainingExerciseModel> getTrainingExercises() {
    return _trainingExercisesList;
  }

  void updateSetInExercise(
      TrainingExerciseModel exercise,
      int setIndex,
      int repetitions,
      double weight,
      ) {
    exercise.sets[setIndex] = exercise.sets[setIndex].copyWith(
      repetitions: repetitions,
      weight: weight,
    );
    notifyListeners();
  }

  Future<void> updatePlanSets(String planName) async {
    var trainingPlanBox = await Hive.openBox<TrainingPlanCardModel>('trainingPlanCards');

    // Znalezienie planu treningowego o podanej nazwie
    final planIndex = trainingPlanBox.values
        .toList()
        .indexWhere((plan) => plan.name == planName);

    if (planIndex == -1) {
      print("Plan treningowy o nazwie '$planName' nie istnieje.");
      return;
    }

    // Pobranie i zaktualizowanie planu
    final plan = trainingPlanBox.getAt(planIndex);

    if (plan == null) {
      print("Nie można pobrać planu o nazwie '$planName'.");
      return;
    }
    for (int i = 0; i < plan.exercises.length; i++) {
      final exercise = plan.exercises[i];
      final updatedExercise = exercise.copyWith(sets: trainingExercisesList[i].sets);
      plan.exercises[i] = updatedExercise;
    }

    await trainingPlanBox.putAt(
      planIndex,
      plan.copyWith(exercises: List<TrainingExerciseModel>.from(plan.exercises)),
    );

    print("Zaktualizowano dane w planie treningowym '$planName'.");
  }

}
