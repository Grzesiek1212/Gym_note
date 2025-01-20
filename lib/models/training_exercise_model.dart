import 'package:hive/hive.dart';
import 'exercise_model.dart';
import 'set_model.dart';

part 'training_exercise_model.g.dart';

@HiveType(typeId: 4)
class TrainingExerciseModel {
  @HiveField(0)
  final Exercise exercise;

  @HiveField(1)
  final List<ExerciseSet> sets;

  TrainingExerciseModel({
    required this.exercise,
    required this.sets,
  });

  factory TrainingExerciseModel.fromMap(Map<String, dynamic> map) {
    var setsFromMap = (map['sets'] as List<dynamic>?)
        ?.map((setMap) => ExerciseSet.fromMap(setMap as Map<String, dynamic>))
        .toList() ??
        [];

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
      sets: sets ?? this.sets.map((set) => set.copyWith()).toList(),
    );
  }
}
