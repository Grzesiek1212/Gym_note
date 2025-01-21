import 'package:flutter/material.dart';
import 'package:gym_note/features/plan/data/services/plan_service.dart';
import '../../data/models/training_plan_card_model.dart';
import 'exercise_list_widget.dart';
import 'plan_card_header_widget.dart';
import 'start_training_button_widget.dart';

class PlanCardWidget extends StatefulWidget {
  final String planName;
  final List<Map<String, String>> exercises;
  final TrainingPlanCardModel plan;

  const PlanCardWidget({
    Key? key,
    required this.planName,
    required this.exercises,
    required this.plan,
  }) : super(key: key);

  @override
  _TrainingPlanCardState createState() => _TrainingPlanCardState();
}

class _TrainingPlanCardState extends State<PlanCardWidget> {
  bool _isExpanded = false;
  final PlanService _planService = PlanService();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade50, Colors.green.shade50],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(15),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                spreadRadius: 2,
                blurRadius: 6,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PlanCardHeaderWidget(
                planName: widget.planName,
                exerciseCount: widget.exercises.length,
                onTap: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
                onDelete: () {
                  _planService.deletePlan(widget.planName);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Usunięcie planu...')),
                  );
                },
              ),
              const SizedBox(height: 16),
              AnimatedCrossFade(
                firstChild: Container(),
                secondChild: Column(
                  children: [
                    ExerciseListWidget(exercises: widget.exercises),
                    const SizedBox(height: 16),
                    StartTrainingButtonWidget(plan: widget.plan),
                  ],
                ),
                crossFadeState: _isExpanded
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 300),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
