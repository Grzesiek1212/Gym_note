import 'package:flutter/material.dart';

class TrainingNotesWidget extends StatelessWidget {
  final String? initialText;
  final Function(String)? onTextChanged;

  const TrainingNotesWidget({
    Key? key,
    this.initialText,
    this.onTextChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Notatki',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          maxLines: 3,
          controller: TextEditingController(text: initialText),
          decoration: InputDecoration(
            hintText: 'Jak się udał trening?',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onChanged: onTextChanged,
        ),
      ],
    );
  }
}
