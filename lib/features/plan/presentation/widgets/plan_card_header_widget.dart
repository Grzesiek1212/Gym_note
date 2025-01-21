import 'package:flutter/material.dart';

class PlanCardHeaderWidget extends StatelessWidget {
  final String planName;
  final int exerciseCount;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const PlanCardHeaderWidget({
    Key? key,
    required this.planName,
    required this.exerciseCount,
    required this.onTap,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                planName,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Liczba ćwiczeń: $exerciseCount',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'delete') {
                onDelete();
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem<String>(
                value: 'delete',
                child: Text('Usuń'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
