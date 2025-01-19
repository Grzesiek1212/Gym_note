import 'exercise_model.dart';
import 'set_model.dart';

class TrainingExerciseModel {
  final Exercise exercise;
  List<ExerciseSet> sets;

  // Konstruktor
  TrainingExerciseModel({
    required this.exercise,
    required this.sets,
  });

  factory TrainingExerciseModel.fromMap(Map<String, dynamic> map) {
    var setsFromMap = (map['sets'] as List<dynamic>?)
        ?.map((setMap) => ExerciseSet.fromMap(setMap as Map<String, dynamic>))
        .toList() ?? [];

    return TrainingExerciseModel(
      exercise: Exercise.fromMap(map['exercise'] as Map<String, dynamic>),
      sets: setsFromMap,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'exercise': exercise.toMap(),
      'sets': sets.map((set) => set.toMap()).toList(),
    };
  }
  TrainingExerciseModel copyWith({
    Exercise? exercise,
    List<ExerciseSet>? sets,
  }) {
    return TrainingExerciseModel(
      exercise: exercise ?? this.exercise,
      sets: sets != null
          ? sets.map((set) => set.copyWith()).toList()
          : this.sets.map((set) => set.copyWith()).toList(),
    );
  }
}
