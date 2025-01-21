import 'package:hive/hive.dart';
import '../../../../core/data/models/training_exercise_model.dart';

part 'training_plan_card_model.g.dart';

@HiveType(typeId: 6)
class TrainingPlanCardModel {
  @HiveField(0)
  List<TrainingExerciseModel> exercises;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final DateTime createdAt;

  @HiveField(3)
  final String type;

  TrainingPlanCardModel({
    required this.exercises,
    required this.name,
    required this.createdAt,
    required this.type,
  });

  TrainingPlanCardModel.empty()
      : exercises = [],
        name = '',
        createdAt = DateTime.now(),
        type = 'own';

  Map<String, dynamic> toMap() {
    return {
      'exercises': exercises.map((e) => e.toMap()).toList(),
      'name': name,
      'createdAt': createdAt.toIso8601String(),
      'type': type,
    };
  }

  factory TrainingPlanCardModel.fromMap(Map<String, dynamic> map) {
    return TrainingPlanCardModel(
      exercises: (map['exercises'] as List<dynamic>)
          .map((e) => TrainingExerciseModel.fromMap(e))
          .toList(),
      name: map['name'],
      createdAt: DateTime.parse(map['createdAt']),
      type: map['type'],
    );
  }

  TrainingPlanCardModel copyWith({
    List<TrainingExerciseModel>? exercises,
    String? name,
    DateTime? createdAt,
    String? type,
  }) {
    return TrainingPlanCardModel(
      exercises: exercises ?? this.exercises,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      type: type ?? this.type,
    );
  }
}
