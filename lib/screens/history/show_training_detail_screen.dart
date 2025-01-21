import 'package:flutter/material.dart';
import '../../models/training_card_model.dart';
import '../../services/history_service.dart';
import '../../services/training/training_service.dart';
import '../../widgets/training_deatils_widget.dart';

class TrainingDetailScreen extends StatelessWidget {
  final TrainingService historyService = TrainingService(); // jeśli potrzebujesz
  final TrainingCard training;  // <= to jest ważne!

  // Konstruktor przyjmujący training
  TrainingDetailScreen({
    Key? key,
    required this.training,
  }) : super(key: key);

  void updateDescription(String newDescription) async {
    // zaktualizuj opis w Hive
    final updatedTraining = training.copyWith(description: newDescription);
    await HistoryService().updateTrainingDescription(updatedTraining);
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
                SnackBar(content: Text('w produkcji :(')),
              );
            },
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'delete') {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('w produkcji :(')),
                );
                print('Usuń trening');
              } else if (value == 'repeat') {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('w produkcji :(')),
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

      body: TrainingDetailsWidget(
        training: training,
        isSummary: false,
        onDescriptionChanged: (newDescription) {
          updateDescription(newDescription);
        },
      ),
    );
  }
}

