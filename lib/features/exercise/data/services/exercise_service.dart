import 'package:hive/hive.dart';
import '../models/exercise_model.dart';
import '../../../training/data/models/training_card_model.dart';

class ExerciseService {
  Future<List<Exercise>> fetchExercisesByCategory(String category) async {
    var box = await Hive.openBox<Exercise>('exercises');
    final exercises = box.values.where((exercise) {
      return exercise.primaryMuscles.contains(category);
    }).toList();
    return exercises;
  }

  Future<List<Map<String, dynamic>>> fetchExerciseExecutions(
      Exercise exercise) async {
    var box = await Hive.openBox<TrainingCard>('trainingCards');
    List<Map<String, dynamic>> exerciseExecutions = [];
    for (var training in box.values) {
      for (var trainingExercise in training.exercises) {
        if (trainingExercise.exercise.name == exercise.name) {
          for (var set in trainingExercise.sets) {
            exerciseExecutions.add({
              'date': training.date.toIso8601String(),
              'repetitions': set.repetitions,
              'weight': set.weight,
            });
          }
        }
      }
    }
    return exerciseExecutions;
  }
}
