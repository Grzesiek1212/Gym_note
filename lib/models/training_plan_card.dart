import 'training_exercise_model.dart';

class TrainingPlanCard {
  List<TrainingExerciseModel> exercises;
  final String name;
  final DateTime createdAt;
  final String type;

  TrainingPlanCard({
    required this.exercises,
    required this.name,
    required this.createdAt,
    required this.type,
  });

  TrainingPlanCard.empty()
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

  factory TrainingPlanCard.fromMap(Map<String, dynamic> map) {
    return TrainingPlanCard(
      exercises: (map['exercises'] as List<dynamic>)
          .map((e) => TrainingExerciseModel.fromMap(e))
          .toList(),
      name: map['name'],
      createdAt: DateTime.parse(map['createdAt']),
      type: map['type'],
    );
  }
}
