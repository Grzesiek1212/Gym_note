import 'package:flutter/material.dart';
import '../../screens/section_detail_screen.dart';

class BodyMeasurementRowWidget extends StatelessWidget {
  final String label;
  final String value;

  const BodyMeasurementRowWidget({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(
            Icons.fitness_center,
            size: 24,
            color: Colors.grey,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.arrow_forward,
              color: Colors.grey,
              size: 18,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SectionDetailScreen(section: label),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
