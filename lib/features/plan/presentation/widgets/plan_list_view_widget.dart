import 'package:flutter/material.dart';
import '../../data/models/training_plan_card_model.dart';
import '../widgets/plan_card_widget.dart';

class PlanListViewWidget extends StatelessWidget {
  final List<TrainingPlanCardModel> plans;

  const PlanListViewWidget({Key? key, required this.plans}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: plans.length,
      itemBuilder: (context, index) {
        return PlanCardWidget(
          plan: plans[index],
          planName: plans[index].name,
          exercises: plans[index]
              .exercises
              .map((e) => {
                    'name': e.exercise.name,
                    'sets': e.sets
                        .map((set) => 'Powtórzenia: ${set.repetitions}')
                        .join(', ')
                  })
              .toList(),
        );
      },
    );
  }
}
