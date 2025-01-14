import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/exercise_model.dart';
import '../screens/exercise/exercise_detail_screen.dart';
import '../services/training/training_service.dart';

class ExerciseGridListWidget extends StatelessWidget {
  final List<Exercise> exercises;
  final bool isTrainingScreen;

  const ExerciseGridListWidget({
    Key? key,
    required this.exercises,
    required this.isTrainingScreen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
      ),
      itemCount: exercises.length,
      itemBuilder: (context, index) {
        final exercise = exercises[index];

        return GestureDetector(
          onTap: () {
          if (isTrainingScreen) {
            // Dodajemy ćwiczenie do listy w TrainingService
            Provider.of<TrainingService>(context, listen: false)
                .addExerciseToTraining(exercise);

            // Wyświetlamy komunikat SnackBar
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Dodano ćwiczenie: ${exercise.name}'),
                duration: const Duration(seconds: 2),
              ),
            );

            // Cofnij użytkownika aż do TrainingScreen
            Navigator.popUntil(context, (route) => route.isFirst);
          }
          else {
              // Przechodzimy do ekranu szczegółów ćwiczenia
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ExerciseDetailScreen(exercise: exercise),
                ),
              );
            }
          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.fitness_center, size: 48.0, color: Colors.blueGrey),
                const SizedBox(height: 8),
                Text(
                  exercise.name,
                  style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
