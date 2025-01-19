import 'package:hive/hive.dart';

part 'exercise_model.g.dart';

@HiveType(typeId: 1)
class Exercise {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final List<String> primaryMuscles;

  @HiveField(2)
  final List<String> secondaryMuscles;

  @HiveField(3)
  final String level;

  @HiveField(4)
  final String description;

  @HiveField(5)
  final String youtubeLink;

  Exercise({
    required this.name,
    required this.primaryMuscles,
    required this.secondaryMuscles,
    required this.level,
    required this.description,
    required this.youtubeLink,
  });

  factory Exercise.fromMap(Map<String, dynamic> map) {
    return Exercise(
      name: map['name'] as String,
      primaryMuscles: List<String>.from(map['primaryMuscles'] ?? []),
      secondaryMuscles: List<String>.from(map['secondaryMuscles'] ?? []),
      level: map['level'] as String? ?? 'Unknown',
      description: map['description'] as String? ?? 'No description available.',
      youtubeLink: map['youtubeLink'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'primaryMuscles': primaryMuscles,
      'secondaryMuscles': secondaryMuscles,
      'level': level,
      'description': description,
      'youtubeLink': youtubeLink,
    };
  }
}
