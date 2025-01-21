import 'package:flutter/material.dart';
import '../../../../main.dart';
import '../../../plan/data/models/training_plan_card_model.dart';

class TrainingSummaryButtonWidget  extends StatelessWidget {
  const TrainingSummaryButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => MainNavigationBar(
                flag: false,
                trainingPlanCard: TrainingPlanCardModel.empty(),
                panelNumber: 2,
              ),
            ),
                (route) => false,
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 16),
          textStyle: const TextStyle(fontSize: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          'PRZJEDŹ DALEJ',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }
}
