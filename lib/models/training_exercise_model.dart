import 'exercise_model.dart';
import 'set_model.dart';

class TrainingExerciseModel {
  final Exercise exercise; // Ćwiczenie
  List<ExerciseSet> sets;  // Lista serii (z powtórzeniami i ciężarem)

  // Konstruktor
  TrainingExerciseModel({
    required this.exercise,
    required this.sets,
  });

  // Zmiana mapowania z mapy do obiektu
  factory TrainingExerciseModel.fromMap(Map<String, dynamic> map) {
    var setsFromMap = (map['sets'] as List<dynamic>?)
        ?.map((setMap) => ExerciseSet.fromMap(setMap as Map<String, dynamic>))
        .toList() ?? [];

    return TrainingExerciseModel(
      exercise: Exercise.fromMap(map['exercise'] as Map<String, dynamic>), // Mapowanie ćwiczenia
      sets: setsFromMap,  // Mapowanie listy serii
    );
  }

  // Zmiana obiektu na mapę
  Map<String, dynamic> toMap() {
    return {
      'exercise': exercise.toMap(), // Mapowanie ćwiczenia
      'sets': sets.map((set) => set.toMap()).toList(),  // Mapowanie listy serii
    };
  }
  TrainingExerciseModel copyWith({
    Exercise? exercise,
    List<ExerciseSet>? sets,
  }) {
    return TrainingExerciseModel(
      exercise: exercise ?? this.exercise,
      sets: sets != null
          ? sets.map((set) => set.copyWith()).toList() // Głębokie kopiowanie serii
          : this.sets.map((set) => set.copyWith()).toList(), // Głębokie kopiowanie obecnych serii
    );
  }
}
