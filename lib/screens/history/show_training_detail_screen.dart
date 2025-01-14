import 'package:flutter/material.dart';
import '../../models/training_card_model.dart';
import '../../services/history_service.dart';
import '../../widgets/training_deatils_widget.dart';

class TrainingDetailScreen extends StatelessWidget {
  final HistoryService historyService = HistoryService();

  Future<TrainingCard> getTrainingDetails() async {
    // Fetch training history
    List<TrainingCard> history = await historyService.getTrainingHistory();
    // Return the first training card as a simulated detail
    return history.first;
  }

  void updateDescription(String newDescription, TrainingCard trainingCard) async {
    final updatedTraining = trainingCard.copyWith(description: newDescription);
    await historyService.updateTrainingDescription(updatedTraining);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Raport z treningu'),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('w produkcji :('),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'delete') {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('w produkcji :('),
                    duration: const Duration(seconds: 2),
                  ),
                );
                print('Usuń trening');
              } else if (value == 'repeat') {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('w produkcji :('),
                    duration: const Duration(seconds: 2),
                  ),
                );
                print('Powtórz trening');
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'delete',
                child: Text('Usuń trening'),
              ),
              PopupMenuItem(
                value: 'repeat',
                child: Text('Powtórz trening'),
              ),
            ],
          ),
        ],
      ),
      body: FutureBuilder<TrainingCard>(
        future: getTrainingDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Wystąpił błąd podczas ładowania danych.'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('Brak danych do wyświetlenia.'));
          }

          final training = snapshot.data!;

          // Użycie TrainingDetailsWidget
          return TrainingDetailsWidget(
            training: training,
            isSummary: false, // To jest widok szczegółowy
            onDescriptionChanged: (newDescription) {
              updateDescription(newDescription, training);
            },
          );
        },
      ),
    );
  }
}
