import 'training_exercise_model.dart';

class TrainingPlanCard {
  List<TrainingExerciseModel> exercises; // Lista ćwiczeń
  final String name; // Nazwa planu treningowego
  final DateTime createdAt; // Data utworzenia
  final String type; // Typ planu: 'own' lub 'ready'

  // Konstruktor z wymaganymi polami
  TrainingPlanCard({
    required this.exercises,
    required this.name,
    required this.createdAt,
    required this.type,
  });

  // Konstruktor bezparametrowy z wartościami domyślnymi
  TrainingPlanCard.empty()
      : exercises = [],
        name = '',
        createdAt = DateTime.now(),
        type = 'own';

  // Metoda do konwersji obiektu na mapę (dla serializacji)
  Map<String, dynamic> toMap() {
    return {
      'exercises': exercises.map((e) => e.toMap()).toList(),
      'name': name,
      'createdAt': createdAt.toIso8601String(),
      'type': type,
    };
  }

  // Fabryczny konstruktor do tworzenia obiektu z mapy (dla deserializacji)
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
