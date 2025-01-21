import 'package:flutter/material.dart';

class MeasurementListWidget extends StatelessWidget {
  final List<Map<String, dynamic>> measurements;

  const MeasurementListWidget({Key? key, required this.measurements}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: measurements.length,
        itemBuilder: (context, index) {
          final measurement = measurements[index];
          return Card(
            child: ListTile(
              title: Text('${measurement['value']} ${measurement['type']}'),
              subtitle: Text('Data: ${measurement['date']}'),
            ),
          );
        },
      ),
    );
  }
}
