import 'package:flutter/material.dart';
import '../../../exercise/data/services/exercise_service.dart';
import '../../../exercise/data/models/exercise_model.dart';
import '../../../exercise/presentation/widgets/exercise_grid_list_widget.dart';

class ExerciseTrainingListScreen extends StatefulWidget {
  final String name;

  const ExerciseTrainingListScreen({Key? key, required this.name}) : super(key: key);

  @override
  _ExerciseTrainingListScreenState createState() => _ExerciseTrainingListScreenState();
}

class _ExerciseTrainingListScreenState extends State<ExerciseTrainingListScreen> {
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
            return ExerciseGridListWidget(exercises: exercises, isTrainingScreen: true); // Używamy naszego widgetu
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
