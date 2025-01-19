class ExerciseSet {
  final int repetitions;
  final double weight;
  ExerciseSet({
    required this.repetitions,
    required this.weight,
  });

  factory ExerciseSet.fromMap(Map<String, dynamic> map) {
    return ExerciseSet(
      repetitions: map['repetitions'] as int,
      weight: map['weight'] as double,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'repetitions': repetitions,
      'weight': weight,
    };
  }

  ExerciseSet copyWith({double? weight, int? repetitions}) {
    return ExerciseSet(
      weight: weight ?? this.weight,
      repetitions: repetitions ?? this.repetitions,
    );
  }
}
