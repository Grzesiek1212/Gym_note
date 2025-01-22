import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../../../exercise/data/models/exercise_model.dart';
import '../../../../core/data/models/set_model.dart';
import '../models/training_card_model.dart';
import '../../../../core/data/models/training_exercise_model.dart';
import '../../../plan/data/models/training_plan_card_model.dart';

class TrainingService with ChangeNotifier {
  List<TrainingExerciseModel> _trainingExercisesList = [];
  DateTime? trainingStartDate;
  bool isTrainingStarted = false;
  bool _isRunning = false;
  Timer? _timer;
  int _breakSeconds = 60;
  int _initialBreakSeconds = 60;

  // ---------------- get functions -----------------------------
  List<TrainingExerciseModel> get trainingExercisesList => _trainingExercisesList;
  int get trainingTime {
    if (trainingStartDate == null) return 0;
    return DateTime.now().difference(trainingStartDate!).inMinutes;
  }
  int get breakSeconds => _breakSeconds;
  bool get isRunning => _isRunning;


  // ------------ time management --------------------------

  void startBreak() {
    _breakSeconds = _initialBreakSeconds;
    notifyListeners();
  }

  void updateBreakTime(int seconds) {
    _breakSeconds = seconds;
    _initialBreakSeconds = seconds;
    notifyListeners();
  }

  void startTrainingTime() {
    trainingStartDate = DateTime.now();
    notifyListeners();
  }

  void editTime(int newTime) {
    _breakSeconds = newTime;
    _initialBreakSeconds = newTime;
    notifyListeners();
  }

  void startStopwatch() {
    if (_isRunning) {
      _timer?.cancel();
    } else {
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        if (_breakSeconds > 0) {
          _breakSeconds--;
          notifyListeners();
          if (_breakSeconds == 0) {
            _timer?.cancel();
            _isRunning = false;
            _breakSeconds = _initialBreakSeconds;
          }
        }
      });
    }
    _isRunning = !_isRunning;
    notifyListeners();
  }


  // -------------------- training functions -------------------------------

  void setTrainingFromPlan(TrainingPlanCardModel trainingPlanCard) {
    _trainingExercisesList =
    List<TrainingExerciseModel>.from(trainingPlanCard.exercises);
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

  void addSetToExercise(TrainingExerciseModel exercise, int repetitions, double weight) {
    exercise.sets.add(ExerciseSet(repetitions: repetitions, weight: weight));
    notifyListeners();
  }

  void updateSetInExercise(TrainingExerciseModel exercise, int setIndex, int repetitions, double weight,) {
    exercise.sets[setIndex] = exercise.sets[setIndex].copyWith(
      repetitions: repetitions,
      weight: weight,
    );
    notifyListeners();
  }

  void removeExerciseFromTraining(TrainingExerciseModel trainingExercise) {
    _trainingExercisesList.remove(trainingExercise);
    notifyListeners();
  }

  void removeSetFromExercise(TrainingExerciseModel exercise, int index) {
    exercise.sets.removeAt(index);
    notifyListeners();
  }


  // --------------- Finish training functions ------------------------------

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

  Future<void> saveTrainingData(String descrition) async {
    final training = TrainingCard(
      exercises: List<TrainingExerciseModel>.from(_trainingExercisesList),
      date: DateTime.now(),
      duration: trainingTime,
      description: descrition,
    );
    var trainingBox = await Hive.openBox<TrainingCard>('trainingCards');
    await trainingBox.add(training);
    print("Zapisano trening: ${training.toMap()}");
  }

  Future<void> savePlanTrainingData(String planName) async {
    try {
      var trainingPlanBox = await Hive.openBox<TrainingPlanCardModel>(
          'trainingPlanCards');

      final trainingPlan = TrainingPlanCardModel(
        exercises: List<TrainingExerciseModel>.from(_trainingExercisesList),
        name: planName,
        createdAt: DateTime.now(),
        type: 'own',
      );
      await trainingPlanBox.add(trainingPlan);
      print("Zapisano trening-plan w bazie: ${trainingPlan.toMap()}");
    } catch (e, stackTrace) {
      print("Błąd podczas zapisywania planu treningowego: $e");
      print("Szczegóły błędu: $stackTrace");
      rethrow;
    }
  }

  Future<void> updatePlanSets(String planName) async {
    var trainingPlanBox = await Hive.openBox<TrainingPlanCardModel>(
        'trainingPlanCards');
    final planIndex = trainingPlanBox.values
        .toList()
        .indexWhere((plan) => plan.name == planName);

    if (planIndex == -1) {
      print("Plan treningowy o nazwie '$planName' nie istnieje.");
      return;
    }
    final plan = trainingPlanBox.getAt(planIndex);

    if (plan == null) {
      print("Nie można pobrać planu o nazwie '$planName'.");
      return;
    }
    for (int i = 0; i < plan.exercises.length; i++) {
      final exercise = plan.exercises[i];
      final updatedExercise = exercise.copyWith(
          sets: trainingExercisesList[i].sets);
      plan.exercises[i] = updatedExercise;
    }
    await trainingPlanBox.putAt(
      planIndex,
      plan.copyWith(
          exercises: List<TrainingExerciseModel>.from(plan.exercises)),
    );
    print("Zaktualizowano dane w planie treningowym '$planName'.");
  }

}
