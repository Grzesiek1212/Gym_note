import 'package:flutter/material.dart';
import '../../../../main.dart';
import '../../data/models/training_plan_card_model.dart';

class StartTrainingButtonWidget extends StatelessWidget {
  final TrainingPlanCardModel plan;

  const StartTrainingButtonWidget({Key? key, required this.plan})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => MainNavigationBar(
              flag: true,
              trainingPlanCard: plan,
              panelNumber: 2,
            ),
          ),
          (route) => false,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Rozpoczęcie treningu...')),
        );
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.green,
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      child: Container(
        alignment: Alignment.center,
        constraints: const BoxConstraints(
          maxWidth: 300,
          minHeight: 25,
        ),
        child: const Text(
          'Rozpocznij trening',
          style: TextStyle(color: Colors.black87, fontSize: 18),
        ),
      ),
    );
  }
}
