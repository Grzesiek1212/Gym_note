class ExerciseSet {
  final int repetitions; // Liczba powtórzeń w serii
  final double weight;   // Ciężar w serii

  ExerciseSet({
    required this.repetitions,
    required this.weight,
  });

  // Tworzenie obiektu z mapy
  factory ExerciseSet.fromMap(Map<String, dynamic> map) {
    return ExerciseSet(
      repetitions: map['repetitions'] as int,
      weight: map['weight'] as double,
    );
  }

  // Konwersja obiektu do mapy
  Map<String, dynamic> toMap() {
    return {
      'repetitions': repetitions,
      'weight': weight,
    };
  }

  // Metoda copyWith poprawiona
  ExerciseSet copyWith({double? weight, int? repetitions}) {
    return ExerciseSet(
      weight: weight ?? this.weight,
      repetitions: repetitions ?? this.repetitions,
    );
  }
}
