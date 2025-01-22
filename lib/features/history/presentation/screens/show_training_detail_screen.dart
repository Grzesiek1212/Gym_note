import 'package:flutter/material.dart';
import '../../../../main.dart';
import '../../../plan/data/models/training_plan_card_model.dart';
import '../../../training/data/models/training_card_model.dart';
import '../../data/services/history_service.dart';
import '../../../training/data/services/training_service.dart';
import '../widgets/training_details_widget.dart';

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

  void shareTrainingReport() {
    // Use the share_plus package to share the training details
    //Share.share('Training Report: ${training.description}');
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
              shareTrainingReport();
            },
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'delete') {
                HistoryService().deleteTraining(training);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Trening został pomyślnie usunięty'),
                  backgroundColor: Colors.green,),
                );
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MainNavigationBar(
                      flag: false,
                      trainingPlanCard: TrainingPlanCardModel.empty(),
                      panelNumber: 0,
                    ),
                  ),
                      (route) => false,
                );
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
