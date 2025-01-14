import 'package:flutter/material.dart';
import '../../widgets/exercise_grid_widget.dart';

class ExerciseScreen extends StatelessWidget {
  ExerciseScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Atlas ćwiczeń'),
        backgroundColor: const Color(0xFFF5F5F5),
        elevation: 0,
      ),
      body: ExerciseGridWidget(isTrainingScreen: false,), // Używamy naszego widgetu tutaj
    );
  }
}
