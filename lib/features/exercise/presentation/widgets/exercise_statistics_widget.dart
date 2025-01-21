import 'package:flutter/material.dart';
import '../widgets/exercise_chart_widget.dart';
import '../widgets/exercise_weights_list_widget.dart';

class ExerciseStatisticsWidget extends StatelessWidget {
  final Future<List<Map<String, dynamic>>> weightsFuture;

  const ExerciseStatisticsWidget({Key? key, required this.weightsFuture})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: weightsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          final weights = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ExerciseChartWidget(weights: weights),
                const SizedBox(height: 16),
                ExerciseWeightsListWidget(weights: weights),
              ],
            ),
          );
        } else {
          return const Center(child: Text('Brak danych.'));
        }
      },
    );
  }
}
