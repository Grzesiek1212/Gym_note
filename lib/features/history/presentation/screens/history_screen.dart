import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../training/data/models/training_card_model.dart';
import '../../data/services/history_service.dart';
import '../widgets/history_card_widget.dart';
import 'show_training_detail_screen.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late Future<List<TrainingCard>> _trainingHistoryFuture;

  @override
  void initState() {
    super.initState();
    _trainingHistoryFuture = HistoryService().getTrainingHistory();
  }

  String formatDuration(int durationInSeconds) {
    final duration = Duration(seconds: durationInSeconds);
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  String formatDate(DateTime date) {
    final dateFormatter = DateFormat('yyyy-MM-dd');
    return dateFormatter.format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historia'),
        backgroundColor: const Color(0xFFF5F5F5),
        elevation: 0,
      ),
      body: FutureBuilder<List<TrainingCard>>(
        future: _trainingHistoryFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Błąd: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Brak historii treningów.'));
          }
          final trainingHistory = snapshot.data!;
          return ListView.builder(
            itemCount: trainingHistory.length,
            itemBuilder: (context, index) {
              final training = trainingHistory[index];
              final formattedDuration = formatDuration(training.duration);
              final formattedDate = formatDate(training.date);

              final totalWeight = training.exercises.fold<double>(
                0.0,
                    (sum, exercise) =>
                sum +
                    exercise.sets.fold<double>(
                      0.0,
                          (subSum, set) => subSum + (set.weight * set.repetitions),
                    ),
              );

              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => TrainingDetailScreen(training: training),
                    ),
                  );
                },
                child: HistoryCardWidget(
                  date: formattedDate,
                  duration: formattedDuration,
                  exercises: training.exercises.length.toString(),
                  weight: '${(totalWeight / 1000).toStringAsFixed(2)}t',
                ),
              );
            },
          );
        },
      ),
    );
  }
}
