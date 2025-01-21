import 'package:flutter/material.dart';

class ExerciseListWidget extends StatelessWidget {
  final List<Map<String, String>> exercises;

  const ExerciseListWidget({Key? key, required this.exercises})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: exercises.length,
      itemBuilder: (context, index) {
        final repetitions = exercises[index]['sets']!
            .split(',')
            .map((set) => set.trim().split(':')[1].trim())
            .join(', ');

        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: ListTile(
            leading: const Icon(Icons.fitness_center, color: Colors.green),
            title: Text(
              exercises[index]['name']!,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            subtitle: Text('Powtórzenia: $repetitions'),
          ),
        );
      },
    );
  }
}
