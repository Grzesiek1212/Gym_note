import 'package:flutter/material.dart';
import 'package:gym_note/features/exercise/data/services/exercise_service.dart';
import '../../data/models/exercise_model.dart';
import '../widgets/exercise_descritpion_widget.dart';
import '../widgets/exercise_statistics_widget.dart';

class ExerciseDetailScreen extends StatefulWidget {
  final Exercise exercise;
  const ExerciseDetailScreen({Key? key, required this.exercise})
      : super(key: key);

  @override
  _ExerciseDetailScreenState createState() => _ExerciseDetailScreenState();
}

class _ExerciseDetailScreenState extends State<ExerciseDetailScreen> {
  late Future<List<Map<String, dynamic>>> _weightsFuture;
  final exerciseService = ExerciseService();

  @override
  void initState() {
    super.initState();
    _weightsFuture = exerciseService.fetchExerciseExecutions(widget.exercise);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.exercise.name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: const Color(0xFFF5F5F5),
          bottom: const TabBar(
            labelColor: Colors.black,
            indicatorColor: Colors.blue,
            tabs: [
              Tab(text: 'O ćwiczeniu'),
              Tab(text: 'Statystyki'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Zakładka "O ćwiczeniu"
            ExerciseDescriptionWidget(exercise: widget.exercise),
            // Zakładka "Statystyki"
            ExerciseStatisticsWidget(weightsFuture: _weightsFuture),
          ],
        ),
      ),
    );
  }
}
