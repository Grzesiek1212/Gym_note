import 'package:flutter/material.dart';
import '../../../../core/data/models/training_exercise_model.dart';
import '../widgets/training_exercise_panel_widget.dart';

class ExerciseListWidget extends StatelessWidget {
  final List<TrainingExerciseModel> exercises;
  final int currentPage;
  final PageController pageController;
  final ValueChanged<int> onPageChanged;

  const ExerciseListWidget({
    Key? key,
    required this.exercises,
    required this.currentPage,
    required this.pageController,
    required this.onPageChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView.builder(
            controller: pageController,
            onPageChanged: onPageChanged,
            itemCount: exercises.length,
            itemBuilder: (context, index) {
              final exercise = exercises[index];
              return ExercisePanelWidget(exercise: exercise);
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            exercises.length,
                (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: currentPage == index ? 12 : 8,
              height: 8,
              decoration: BoxDecoration(
                color: currentPage == index ? Colors.blue : Colors.grey,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
