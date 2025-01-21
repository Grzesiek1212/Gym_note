import 'package:flutter/material.dart';
import '../../data/services/exercise_service.dart';
import '../../data/models/exercise_model.dart';
import '../widgets/exercise_grid_list_widget.dart';

class ExerciseListScreen extends StatefulWidget {
  final String name;

  const ExerciseListScreen({Key? key, required this.name}) : super(key: key);

  @override
  _ExerciseListScreenState createState() => _ExerciseListScreenState();
}

class _ExerciseListScreenState extends State<ExerciseListScreen> {
  final ExerciseService _exerciseService = ExerciseService();
  late Future<List<Exercise>> _exercisesFuture;

  @override
  void initState() {
    super.initState();
    _exercisesFuture = _exerciseService.fetchExercisesByCategory(widget.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        backgroundColor: const Color(0xFFF5F5F5),
      ),
      body: FutureBuilder<List<Exercise>>(
        future: _exercisesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Błąd: ${snapshot.error}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            final exercises = snapshot.data!;
            return ExerciseGridListWidget(exercises: exercises,isTrainingScreen: false); // Używamy naszego widgetu
          } else {
            return const Center(
              child: Text('Brak ćwiczeń do wyświetlenia.'),
            );
          }
        },
      ),
    );
  }
}
