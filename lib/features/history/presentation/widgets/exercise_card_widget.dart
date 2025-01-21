import 'package:flutter/material.dart';

class ExerciseCardWidget extends StatelessWidget {
  final String title;
  final String details;
  final List<Map<String, String>> exercises;

  const ExerciseCardWidget({
    Key? key,
    required this.title,
    required this.details,
    required this.exercises,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              details,
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            const SizedBox(height: 16),
            ...exercises.map((exercise) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Obciążenie: ${exercise['obciazenie']}', style: const TextStyle(fontSize: 14)),
                    Text('Powtórzenia: ${exercise['powtorzenia']}', style: const TextStyle(fontSize: 14)),
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
