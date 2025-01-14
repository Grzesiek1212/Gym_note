import 'package:flutter/material.dart';
import '../../widgets/exercise_grid_widget.dart';

class ExerciseTrainingScreen extends StatelessWidget {
  ExerciseTrainingScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Atlas ćwiczeń'),
        backgroundColor: const Color(0xFFF5F5F5),
        elevation: 0,
      ),
      body: ExerciseGridWidget(isTrainingScreen: true,), // Używamy naszego widgetu tutaj
    );
  }
}
