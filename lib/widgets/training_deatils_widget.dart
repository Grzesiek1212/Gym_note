import 'package:flutter/material.dart';
import '../../models/training_card_model.dart';
import '../main.dart';
import '../models/training_plan_card.dart';

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
                            _buildInfoColumn(Icons.timer, 'CZAS TRWANIA', '${(training.duration ~/ 60)}h ${(training.duration % 60)}m'),
                            _buildInfoColumn(Icons.fitness_center, 'ĆWICZENIA', '${training.exercises.length}'),
                          ],
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildInfoColumn(Icons.repeat, 'SERIE', '${training.exercises.map((e) => e.sets.length).reduce((a, b) => a + b)}'),
                            _buildInfoColumn(Icons.bar_chart, 'CIĘŻAR', '${training.exercises.fold(0, (sum, e) => sum + e.sets.fold(0, (s, set) => s + set.weight.toInt()))} kg'),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            if (!isSummary) ...[
              SizedBox(height: 16),
              Text(
                'Notatki',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              TextField(
                maxLines: 3,
                controller: TextEditingController(text: training.description),
                decoration: InputDecoration(
                  hintText: 'Jak się udał trening?',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onChanged: onDescriptionChanged,
              ),
            ],
            SizedBox(height: 16),
            Text(
              'Lista ćwiczeń',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            ...training.exercises.map((exercise) => _buildExerciseCard(
              title: exercise.exercise.name,
              details:
              'Partia ciała: ${exercise.exercise.primaryMuscles.join(', ')}\nCzas przerwy: Domyślny',
              exercises: exercise.sets
                  .map((set) => {
                'obciazenie': '${set.weight} kg',
                'powtorzenia': '${set.repetitions}',
              })
                  .toList(),
            )),
            if (isSummary)
              SizedBox(height: 32),
            if (isSummary)
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MainNavigationBar(
                          flag: false,
                          trainingPlanCard: TrainingPlanCard.empty(),
                        ),
                      ),
                          (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 16),
                    textStyle: const TextStyle(fontSize: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'PRZJEDŹ DALEJ',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoColumn(IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(icon, size: 32, color: Colors.blueGrey),
        SizedBox(height: 8),
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[700])),
        SizedBox(height: 4),
        Text(value, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      ],
    );
  }

  Widget _buildExerciseCard({
    required String title,
    required String details,
    required List<Map<String, String>> exercises,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              details,
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            SizedBox(height: 16),
            ...exercises.map((exercise) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Obciążenie: ${exercise['obciazenie']}', style: TextStyle(fontSize: 14)),
                    Text('Powtórzenia: ${exercise['powtorzenia']}', style: TextStyle(fontSize: 14)),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
