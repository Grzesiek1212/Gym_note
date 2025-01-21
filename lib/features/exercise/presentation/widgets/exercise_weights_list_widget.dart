import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExerciseWeightsListWidget extends StatelessWidget {
  final List<Map<String, dynamic>> weights;

  const ExerciseWeightsListWidget({Key? key, required this.weights})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: weights.length,
        itemBuilder: (context, index) {
          final weight = weights[index];
          final dateString = weight['date'] as String;
          final dateTime = DateTime.parse(dateString);
          final formatted = DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
          return Card(
            child: ListTile(
              title: Text(
                  'Ciężar: ${weight['weight']} kg \nPowtórzenia: ${weight['repetitions']}'),
              subtitle: Text('Data: $formatted'),
            ),
          );
        },
      ),
    );
  }
}
