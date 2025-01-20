import 'package:flutter/material.dart';
import '../../main.dart';
import '../../models/training_plan_card_model.dart';
import '../../widgets/training_option_card.dart';
import 'choose_training_screen.dart';

class ChooseTrainingOptionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trening'),
        backgroundColor: const Color(0xFFF5F5F5),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TrainingOptionCard(
              title: 'Aktywny plan treningowy',
              subtitle: 'Korzystaj z gotowego planu treningowego',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChooseTrainingScreen(
                      planType: 'Gotowe plany treningowe', // Przekazujemy odpowiedni typ
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 16),

            TrainingOptionCard(
              title: 'Własne plany treningowe',
              subtitle: 'Korzystaj już z planu przez siebie ułożonego',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChooseTrainingScreen(
                      planType: 'Własne plany treningowe', // Przekazujemy odpowiedni typ
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 16),

            TrainingOptionCard(
              title: 'Trening bez planu',
              subtitle: 'Dodawaj ćwiczenia na bieżąco',
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MainNavigationBar(
                      flag: true,
                      trainingPlanCard: TrainingPlanCardModel.empty(),
                    ),
                  ),
                      (route) => false, // Usuwanie wszystkich poprzednich ekranów z historii
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
