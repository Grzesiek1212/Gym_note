import 'training_exercise_model.dart';

class TrainingCard {
  List<TrainingExerciseModel> exercises;
  final DateTime date;
  final int duration;
  final String description;

  TrainingCard({
    required this.exercises,
    required this.date,
    required this.duration,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'exercises': exercises.map((e) => e.toMap()).toList(),
      'date': date.toIso8601String(),
      'duration': duration,
      'description':description,
    };
  }

  factory TrainingCard.fromMap(Map<String, dynamic> map) {
    return TrainingCard(
      exercises: (map['exercises'] as List<dynamic>)
          .map((e) => TrainingExerciseModel.fromMap(e))
          .toList(),
      date: DateTime.parse(map['date']),
      duration: map['duration'],
      description: map['description'],
    );
  }

  TrainingCard copyWith({
    DateTime? date,
    int? duration,
    String? description,
    List<TrainingExerciseModel>? exercises,
  }) {
    return TrainingCard(
      date: date ?? this.date,
      duration: duration ?? this.duration,
      description: description ?? this.description,
      exercises: exercises ?? this.exercises,
    );
  }
}
