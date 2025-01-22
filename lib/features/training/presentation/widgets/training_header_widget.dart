import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/services/training_service.dart';

class TrainingHeaderWidget extends StatelessWidget {
  final VoidCallback onFinishTraining;
  final VoidCallback onStartStop;
  final VoidCallback onEditTime;

  const TrainingHeaderWidget({
    Key? key,
    required this.onFinishTraining,
    required this.onStartStop,
    required this.onEditTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
            onPressed: onFinishTraining,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFC75361),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            ),
            child: const Text('ZAKOŃCZ',
                style: TextStyle(fontSize: 14, color: Colors.white70)),
          ),
          Column(
            children: [
              const Text('Czas trwania treningu',
                  style: TextStyle(color: Colors.black)),
              Consumer<TrainingService>(
                builder: (context, trainingService, child) {
                  final trainingTime = trainingService.trainingTime;
                  final hours = trainingTime ~/ 60;
                  final minutes = trainingTime % 60;
                  return Text(
                    '$hours:${minutes.toString().padLeft(2, '0')}',
                    style: const TextStyle(color: Colors.black, fontSize: 24),
                  );
                },
              ),
            ],
          ),
          GestureDetector(
            onTap: onEditTime,
            child: Column(
              children: [
                Consumer<TrainingService>(
                  builder: (context, trainingService, child) {
                    return Text(
                      trainingService.breakSeconds.toString(),
                      style: const TextStyle(color: Colors.black, fontSize: 24),
                    );
                  },
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.timer),
            onPressed: onStartStop,
          ),
        ],
      ),
    );
  }
}
