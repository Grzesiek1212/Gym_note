import 'package:flutter/material.dart';
import '../screens/exercise/exercise_list_screen.dart';
import '../screens/training/exercise_training_list_screen.dart'; // Dodajemy ekran do treningów

class ExerciseGridWidget extends StatelessWidget {
  final bool isTrainingScreen; // Parametr do określenia, z jakiego ekranu przechodzimy
  final List<Map<String, dynamic>> exercises = [
    {'name': 'Klatka piersiowa', 'image': 'assets/chest.png'},
    {'name': 'Plecy', 'image': 'assets/back.png'},
    {'name': 'Barki', 'image': 'assets/shoulders.png'},
    {'name': 'Triceps', 'image': 'assets/triceps.png'},
    {'name': 'Biceps', 'image': 'assets/biceps.png'},
    {'name': 'Przedramiona', 'image': 'assets/forearm.png'},
    {'name': 'Uda tylnie i pośladki', 'image': 'assets/legs.png'},
    {'name': 'Brzuch', 'image': 'assets/abs.png'},
    {'name': 'Łydki', 'image': 'assets/calf.png'},
    {'name': 'Uda przednie', 'image': 'assets/frontlegs.png'},
    {'name': 'Całe ciało', 'image': 'assets/full_body.png'},
    {'name': 'Kardio', 'image': 'assets/cardio.png'},
  ];

  // Konstruktor przyjmujący parametr isTrainingScreen
  ExerciseGridWidget({Key? key, required this.isTrainingScreen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // 3 elementy w rzędzie
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.8, // Proporcje obrazów
      ),
      itemCount: exercises.length,
      itemBuilder: (context, index) {
        final exercise = exercises[index];
        return GestureDetector(
          onTap: () {
            // Na podstawie wartości isTrainingScreen, przechodzimy do odpowiedniego ekranu
            if (isTrainingScreen) {
              // Przejście do ExerciseTrainingListScreen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ExerciseTrainingListScreen(name: exercise['name']),
                ),
              );
            } else {
              // Przejście do ExerciseListScreen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ExerciseListScreen(name: exercise['name']),
                ),
              );
            }
          },
          child: Column(
            children: [
              Expanded(
                child: Image.asset(
                  exercise['image'],
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                exercise['name'],
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black38,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );
  }
}
