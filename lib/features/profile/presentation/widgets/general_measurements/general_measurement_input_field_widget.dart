import 'package:flutter/material.dart';
import '../../../data/repositories/measurement_labels.dart';

class GeneralMeasurementInputFieldWidget extends StatelessWidget {
  final String keyName;
  final TextEditingController controller;
  final bool usePolishLabels;

  const GeneralMeasurementInputFieldWidget({
    Key? key,
    required this.keyName,
    required this.controller,
    this.usePolishLabels = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: usePolishLabels
              ? generalMeasurementLabels[keyName] ?? keyName
              : keyName,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
