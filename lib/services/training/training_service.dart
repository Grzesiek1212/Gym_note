import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../../models/exercise_model.dart';
import '../../models/set_model.dart';
import '../../models/training_card_model.dart';
import '../../models/training_exercise_model.dart';
import '../../models/training_plan_card.dart';

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

  void setTrainingFromPlan(TrainingPlanCard trainingPlanCard) {
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

  void finishAndResetTraining(bool isNew) {
    trainingStartDate = null;
    saveTrainingData();
    if (isNew) {
      savePlanTrainingData();
    } else {
      // TODO: aktualizowanie w modelu nowych cięzarów jakie wykonał lub zmiana ideii w kontekście pobrania ostatnich wyników
    }
    notifyListeners();
  }

  void saveTrainingData() async{
    final training = TrainingCard(
      exercises: List<TrainingExerciseModel>.from(_trainingExercisesList),
      date: DateTime.now(),
      duration: trainingTime,
      description: "Fajny trening",
    );
    var trainingBox = await Hive.openBox<TrainingCard>('trainingCards');
    // Save the training card to the database
    await trainingBox.add(training);
    print("Zapisano trening: ${training.toMap()}");
  }

  void savePlanTrainingData() {
    final trainingPlan = TrainingPlanCard(
      exercises: List<TrainingExerciseModel>.from(_trainingExercisesList),
      name: "Trening z dnia ${DateTime.now().toIso8601String()}",
      createdAt: DateTime.now(),
      type: 'own',
    );
    // TODO: wysłać to na backend
    print("Zapisano trening: ${trainingPlan.toMap()}");
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
}
