import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/data/models/training_exercise_model.dart';
import '../../data/services/training_service.dart';

class ExercisePanelWidget extends StatelessWidget {
  final TrainingExerciseModel exercise;

  ExercisePanelWidget({required this.exercise});

  @override
  Widget build(BuildContext context) {
    final trainingService = Provider.of<TrainingService>(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  trainingService.removeExerciseFromTraining(exercise);
                },
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Icon(
                    Icons.delete,
                    color: Colors.red.shade600,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  exercise.exercise.name,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: exercise.sets.length,
              itemBuilder: (context, index) {
                final set = exercise.sets[index];
                return Card(
                  margin: EdgeInsets.only(bottom: 8),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16),
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue.shade50,
                      child: Text(
                        'S${index + 1}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    title: Text(
                      'Powtórzenia: ${set.repetitions},\nCiężar: ${set.weight} kg',
                      style: TextStyle(fontSize: 16),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        // Usuwanie serii po naciśnięciu
                        trainingService.removeSetFromExercise(exercise, index);
                      },
                    ),
                    onTap: () {
                      _showEditSetDialog(context, trainingService, exercise, index);
                    },
                  ),
                );
              },
            ),
          ),
          InkWell(
            onTap: () {
              _showAddSetDialog(context, trainingService);
            },
            child: Ink(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue.shade100, Colors.green.shade100],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    spreadRadius: 2,
                    blurRadius: 6,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 40),
                alignment: Alignment.center,
                child: Text(
                  'Dodaj serię',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showEditSetDialog(
      BuildContext context,
      TrainingService trainingService,
      TrainingExerciseModel exercise,
      int setIndex,
      ) {
    final set = exercise.sets[setIndex];
    final repetitionsController =
    TextEditingController(text: set.repetitions.toString());
    final weightController = TextEditingController(text: set.weight.toString());

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edytuj serię'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: repetitionsController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Powtórzenia'),
              ),
              TextField(
                controller: weightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Ciężar (kg)'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Anuluj'),
            ),
            TextButton(
              onPressed: () {
                final repetitions =
                    int.tryParse(repetitionsController.text) ?? set.repetitions;
                final weight =
                    double.tryParse(weightController.text) ?? set.weight;

                trainingService.updateSetInExercise(
                    exercise, setIndex, repetitions, weight);
                Navigator.pop(context);
              },
              child: Text('Zapisz'),
            ),
          ],
        );
      },
    );
  }
  void _showAddSetDialog(
      BuildContext context, TrainingService trainingService) {
    final repetitionsController = TextEditingController();
    final weightController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Dodaj serię'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: repetitionsController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Powtórzenia'),
              ),
              TextField(
                controller: weightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Ciężar (kg)'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Anuluj'),
            ),
            TextButton(
              onPressed: () {
                final repetitions =
                    int.tryParse(repetitionsController.text) ?? 0;
                final weight = double.tryParse(weightController.text) ?? 0.0;

                if (repetitions > 0 && weight >= 0) {
                  trainingService.addSetToExercise(
                      exercise, repetitions, weight);
                  Navigator.pop(context);
                }
              },
              child: Text('Dodaj'),
            ),
          ],
        );
      },
    );
  }
}
