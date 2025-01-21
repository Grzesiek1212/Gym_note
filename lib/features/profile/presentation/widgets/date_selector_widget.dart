import 'package:flutter/material.dart';

class DateSelectorWidget extends StatelessWidget {
  final List<String> availableDates;
  final String? selectedDate;
  final Function(String) onDateSelected;

  const DateSelectorWidget({
    Key? key,
    required this.availableDates,
    required this.selectedDate,
    required this.onDateSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Wybierz datę:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: selectedDate,
          items: availableDates.map((date) {
            return DropdownMenuItem(
              value: date,
              child: Text(date),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) onDateSelected(value);
          },
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Data',
          ),
        ),
      ],
    );
  }
}
