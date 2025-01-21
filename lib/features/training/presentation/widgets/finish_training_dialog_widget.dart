import 'package:flutter/material.dart';

class FinishTrainingDialogWidget extends StatelessWidget {
  final bool isNew;
  final TextEditingController nameController;
  final TextEditingController descriptionController;

  const FinishTrainingDialogWidget({
    Key? key,
    required this.isNew,
    required this.nameController,
    required this.descriptionController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Zakończ trening'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isNew)
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Nazwa planu'),
              ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Opis treningu'),
              maxLines: 2,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: const Text('Anuluj'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
