import 'package:flutter/material.dart';
import '../../../training/data/models/training_card_model.dart';
import '../../data/services/history_service.dart';
import '../../../training/data/services/training_service.dart';
import '../widgets/training_deatils_widget.dart';

class TrainingDetailScreen extends StatelessWidget {
  final TrainingService historyService = TrainingService();
  final TrainingCard training;

  TrainingDetailScreen({
    Key? key,
    required this.training,
  }) : super(key: key);

  void updateDescription(String newDescription) async {
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
              // TODO: dodac sharownie
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('w produkcji :(')),
              );
            },
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'delete') {
                // TODO: usuwanie treingu
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('w produkcji :(')),
                );
                print('Usuń trening');
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'delete',
                child: Text('Usuń trening'),
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
