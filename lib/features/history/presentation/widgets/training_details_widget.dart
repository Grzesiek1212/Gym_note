import 'package:flutter/material.dart';
import '../../../training/data/models/training_card_model.dart';
import 'exercise_card_widget.dart';
import 'training_info_row_widget.dart';
import 'training_notes_widget.dart';
import 'training_summary_button_widget.dart';

class TrainingDetailsWidget extends StatelessWidget {
  final TrainingCard training;
  final bool isSummary;
  final Function(String)? onDescriptionChanged;

  const TrainingDetailsWidget({
    Key? key,
    required this.training,
    this.isSummary = false,
    this.onDescriptionChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Trening ${training.date.toLocal().toString().split(' ')[0]}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      ' ${training.date.toLocal().hour}:${training.date.toLocal().minute.toString().padLeft(2, '0')} '
                      '- ${(training.date.toLocal().add(Duration(minutes: training.duration))).hour}:'
                      '${(training.date.toLocal().add(Duration(minutes: training.duration))).minute.toString().padLeft(2, '0')}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 16),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            TrainingInfoRowWidget(
                              icon: Icons.timer,
                              label: 'CZAS TRWANIA',
                              value:
                                  '${(training.duration ~/ 60)}h ${(training.duration % 60)}m',
                            ),
                            TrainingInfoRowWidget(
                                icon: Icons.fitness_center,
                                label: 'ĆWICZENIA',
                                value: '${training.exercises.length}'),
                          ],
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            TrainingInfoRowWidget(
                                icon: Icons.repeat,
                                label: 'SERIE',
                                value:
                                    '${training.exercises.map((e) => e.sets.length).reduce((a, b) => a + b)}'),
                            TrainingInfoRowWidget(
                                icon: Icons.bar_chart,
                                label: 'CIĘŻAR',
                                value:
                                    '${training.exercises.fold(0, (sum, e) => sum + e.sets.fold(0, (s, set) => s + set.weight.toInt()))} kg'),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            if (!isSummary)
              TrainingNotesWidget(
                initialText: training.description,
                onTextChanged: onDescriptionChanged,
              ),
            SizedBox(height: 16),
            Text(
              'Lista ćwiczeń',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            ...training.exercises.map((exercise) => ExerciseCardWidget(
                  title: exercise.exercise.name,
                  details:
                      'Partia ciała: ${exercise.exercise.primaryMuscles.join(', ')}',
                  exercises: exercise.sets
                      .map((set) => {
                            'obciazenie': '${set.weight} kg',
                            'powtorzenia': '${set.repetitions}',
                          })
                      .toList(),
                )),
            if (isSummary) SizedBox(height: 32),
            if (isSummary) TrainingSummaryButtonWidget(),
          ],
        ),
      ),
    );
  }
}
