import 'package:flutter/material.dart';

class AddExerciseButtonWidget extends StatelessWidget {
  final VoidCallback onAddExercise;

  const AddExerciseButtonWidget({
    Key? key,
    required this.onAddExercise,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: onAddExercise,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFB8D8D8),
          padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 16),
          textStyle: const TextStyle(fontSize: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          'DODAJ ĆWICZENIE',
          style: TextStyle(fontSize: 18, color: Colors.black87),
        ),
      ),
    );
  }
}
