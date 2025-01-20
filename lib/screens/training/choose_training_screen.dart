import 'package:flutter/material.dart';
import 'package:gym_note/services/plan_service.dart';

import '../../models/training_plan_card_model.dart';
import '../../widgets/plan_card.dart';

class ChooseTrainingScreen extends StatelessWidget {
  final String planType;

  ChooseTrainingScreen({required this.planType});

  @override
  Widget build(BuildContext context) {
    final PlanService planService = PlanService();

    return Scaffold(
      appBar: AppBar(
        title: Text(planType), // Wyświetlamy typ planu w nagłówku
        backgroundColor: const Color(0xFFF5F5F5),
        elevation: 0,
      ),
      body: FutureBuilder<List<TrainingPlanCardModel>>(
        future: planService.getPlans(planType == 'Własne plany treningowe'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Błąd: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Brak planów.'));
          }

          final plans = snapshot.data!;

          return ListView.builder(
            itemCount: plans.length,
            itemBuilder: (context, index) {
              return PlanCard(
                plan: plans[index],
                planName: plans[index].name,
                exercises: plans[index].exercises.map((e) => {
                  'name': e.exercise.name,
                  'sets': e.sets.map((set) => 'Powtórzenia: ${set.repetitions}').join(', ')
                }).toList(),
              );
            },
          );
        },
      ),
    );
  }
}
