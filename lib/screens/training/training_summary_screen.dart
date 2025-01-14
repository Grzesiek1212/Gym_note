import 'package:flutter/material.dart';
import '../../models/training_card_model.dart';
import '../../widgets/training_deatils_widget.dart';

class TrainingSummaryScreen extends StatelessWidget {
  final TrainingCard training;


  const TrainingSummaryScreen({Key? key, required this.training}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Podsumowanie treningu'),
      ),
      body: TrainingDetailsWidget(
        training: training,
        isSummary: true, // Flaga określająca, że to ekran podsumowania
      ),
    );
  }
}
