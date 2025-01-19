import 'package:hive/hive.dart';

import '../../models/exercise_model.dart';

Future<void> addExercises() async {
  var exerciseBox = await Hive.openBox<Exercise>('exercises');

  // Sprawdź, czy box jest pusty
  if (exerciseBox.isEmpty) {
    await exerciseBox.addAll([
      // Klatka piersiowa
      Exercise(
        name: 'Wyciskanie na ławce',
        primaryMuscles: ['Klatka piersiowa'],
        secondaryMuscles: ['Triceps', 'Barki'],
        level: 'Średni',
        description: 'Klasyczne wyciskanie na ławce w celu rozwoju klatki piersiowej.',
        youtubeLink: 'https://www.youtube.com/watch?v=gRVjAtPip0Y',
      ),
      Exercise(
        name: 'Rozpiętki z hantlami',
        primaryMuscles: ['Klatka piersiowa'],
        secondaryMuscles: ['Barki'],
        level: 'Początkujący',
        description: 'Ćwiczenie rozwijające wewnętrzną część klatki piersiowej.',
        youtubeLink: 'https://www.youtube.com/watch?v=eozdVDA78K0',
      ),
      // Plecy
      Exercise(
        name: 'Podciąganie na drążku',
        primaryMuscles: ['Plecy'],
        secondaryMuscles: ['Biceps'],
        level: 'Średni',
        description: 'Podciąganie w celu wzmocnienia pleców i ramion.',
        youtubeLink: 'https://www.youtube.com/watch?v=eGo4IYlbE5g',
      ),
      Exercise(
        name: 'Martwy ciąg',
        primaryMuscles: ['Plecy'],
        secondaryMuscles: ['Nogi', 'Pośladki'],
        level: 'Zaawansowany',
        description: 'Ćwiczenie na rozwój siły całego ciała i mięśni pleców.',
        youtubeLink: 'https://www.youtube.com/watch?v=ytGaGIn3SjE',
      ),
      // Dodaj pozostałe ćwiczenia zgodnie z wcześniejszym kodem...
    ]);

    print('Ćwiczenia zostały pomyślnie dodane.');
  } else {
    print('Box exercises już zawiera dane.');
  }
}
