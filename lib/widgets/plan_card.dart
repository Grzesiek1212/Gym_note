import 'package:flutter/material.dart';
import 'package:gym_note/main.dart';
import 'package:gym_note/services/plan_service.dart';
import 'package:provider/provider.dart';
import '../models/exercise_model.dart';
import '../models/set_model.dart';
import '../models/training_exercise_model.dart';
import '../models/training_plan_card.dart';
import '../screens/training/training_screen.dart';
import '../services/training/training_service.dart'; // Dodanie importu dla PlanService

class PlanCard extends StatefulWidget {
  final String planName;
  final List<Map<String, String>> exercises;
  final TrainingPlanCard plan;

  const PlanCard({
    Key? key,
    required this.planName,
    required this.exercises,
    required this.plan
  }) : super(key: key);

  @override
  _TrainingPlanCardState createState() => _TrainingPlanCardState();
}

class _TrainingPlanCardState extends State<PlanCard> {
  bool _isExpanded = false;
  final PlanService _planService = PlanService();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade50, Colors.green.shade50],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              spreadRadius: 2,
              blurRadius: 6,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.planName,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Liczba ćwiczeń: ${widget.exercises.length}',
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
                        // Usuwanie planu
                        _planService.deletePlan(widget.planName);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Usunięcie planu...')),
                        );
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
            ),
            const SizedBox(height: 16),
            AnimatedCrossFade(
              firstChild: Container(),
              secondChild: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget.exercises.length,
                    itemBuilder: (context, index) {
                      String repetitions = widget.exercises[index]['sets']!
                          .split(',')
                          .map((set) => set.trim().split(':')[1].trim())
                          .join(', ');

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: ListTile(
                          leading: const Icon(Icons.fitness_center, color: Colors.green),
                          title: Text(
                            widget.exercises[index]['name']!,
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                          subtitle: Text('Powtórzenia: $repetitions'),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {


                      // Przechodzimy do MainNavigationBar z odpowiednimi parametrami
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MainNavigationBar(
                            flag: true,
                            trainingPlanCard: widget.plan,
                          ),
                        ),
                            (route) => false, // Usuwanie wszystkich poprzednich ekranów z historii
                      );

                      // Informacja zwrotna dla użytkownika
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Rozpoczęcie treningu...')),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      constraints: BoxConstraints(
                        maxWidth: 300,
                        minHeight: 25,
                      ),
                      child: const Text(
                        'Rozpocznij trening',
                        style: TextStyle(color: Colors.black87, fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
              crossFadeState: _isExpanded
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 300),
            ),
          ],
        ),
      ),
    );
  }
}
