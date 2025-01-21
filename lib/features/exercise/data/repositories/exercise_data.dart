import 'package:hive/hive.dart';
import '../models/exercise_model.dart';

Future<void> addExercises() async {
  var exerciseBox = await Hive.openBox<Exercise>('exercises');

  if (exerciseBox.isEmpty) {
    await exerciseBox.addAll([
      // Klatka piersiowa
      Exercise(
        name: 'Wyciskanie na ławce',
        primaryMuscles: ['Klatka piersiowa'],
        secondaryMuscles: ['Triceps', 'Barki'],
        level: 'Średni',
        description:
            'Klasyczne wyciskanie na ławce w celu rozwoju klatki piersiowej.',
        youtubeLink: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
      ),
      Exercise(
        name: 'Rozpiętki z hantlami',
        primaryMuscles: ['Klatka piersiowa'],
        secondaryMuscles: ['Barki'],
        level: 'Początkujący',
        description:
            'Ćwiczenie rozwijające wewnętrzną część klatki piersiowej.',
        youtubeLink: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
      ),
      Exercise(
        name: 'Pompki klasyczne',
        primaryMuscles: ['Klatka piersiowa'],
        secondaryMuscles: ['Triceps', 'Barki'],
        level: 'Początkujący',
        description: 'Ćwiczenie na masę i siłę klatki piersiowej.',
        youtubeLink: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
      ),
      Exercise(
        name: 'Wyciskanie hantli na skosie',
        primaryMuscles: ['Klatka piersiowa'],
        secondaryMuscles: ['Triceps', 'Barki'],
        level: 'Średni',
        description: 'Ćwiczenie na górną część klatki piersiowej.',
        youtubeLink: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
      ),

      // Plecy
      Exercise(
        name: 'Podciąganie na drążku',
        primaryMuscles: ['Plecy'],
        secondaryMuscles: ['Biceps'],
        level: 'Średni',
        description: 'Podciąganie w celu wzmocnienia pleców i ramion.',
        youtubeLink: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
      ),
      Exercise(
        name: 'Martwy ciąg',
        primaryMuscles: ['Plecy'],
        secondaryMuscles: ['Nogi', 'Pośladki'],
        level: 'Zaawansowany',
        description: 'Ćwiczenie na rozwój siły całego ciała i mięśni pleców.',
        youtubeLink: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
      ),
      Exercise(
        name: 'Wiosłowanie sztangą',
        primaryMuscles: ['Plecy'],
        secondaryMuscles: ['Biceps'],
        level: 'Średni',
        description: 'Ćwiczenie na rozwój szerokości i grubości pleców.',
        youtubeLink: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
      ),
      Exercise(
        name: 'Wiosłowanie hantlą',
        primaryMuscles: ['Plecy'],
        secondaryMuscles: ['Biceps'],
        level: 'Początkujący',
        description: 'Ćwiczenie na rozwój mięśni grzbietu.',
        youtubeLink: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
      ),

      // Barki
      Exercise(
        name: 'Wyciskanie sztangi nad głowę',
        primaryMuscles: ['Barki'],
        secondaryMuscles: ['Triceps'],
        level: 'Średni',
        description: 'Ćwiczenie na rozwój siły i masy barków.',
        youtubeLink: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
      ),
      Exercise(
        name: 'Unoszenie hantli bokiem',
        primaryMuscles: ['Barki'],
        secondaryMuscles: [],
        level: 'Początkujący',
        description: 'Ćwiczenie na rozwój bocznej części barków.',
        youtubeLink: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
      ),
      Exercise(
        name: 'Arnoldki',
        primaryMuscles: ['Barki'],
        secondaryMuscles: ['Triceps'],
        level: 'Średni',
        description: 'Ćwiczenie na pełny rozwój barków.',
        youtubeLink: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
      ),
      Exercise(
        name: 'Unoszenie hantli w opadzie',
        primaryMuscles: ['Barki'],
        secondaryMuscles: ['Plecy'],
        level: 'Początkujący',
        description: 'Ćwiczenie na tylne aktony barków.',
        youtubeLink: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
      ),

      // Triceps
      Exercise(
        name: 'Pompki na poręczach',
        primaryMuscles: ['Triceps'],
        secondaryMuscles: ['Klatka piersiowa', 'Barki'],
        level: 'Średni',
        description: 'Ćwiczenie na rozwój masy i siły tricepsa.',
        youtubeLink: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
      ),
      Exercise(
        name: 'Prostowanie ramion z hantlem',
        primaryMuscles: ['Triceps'],
        secondaryMuscles: [],
        level: 'Początkujący',
        description: 'Ćwiczenie izolujące triceps.',
        youtubeLink: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
      ),
      Exercise(
        name: 'Francuskie wyciskanie',
        primaryMuscles: ['Triceps'],
        secondaryMuscles: [],
        level: 'Średni',
        description: 'Ćwiczenie na rozwój tylnej części ramion.',
        youtubeLink: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
      ),
      Exercise(
        name: 'Wyciskanie wąskim chwytem',
        primaryMuscles: ['Triceps'],
        secondaryMuscles: ['Klatka piersiowa'],
        level: 'Średni',
        description: 'Ćwiczenie na siłę i masę tricepsa.',
        youtubeLink: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
      ),

      // Biceps
      Exercise(
        name: 'Uginanie ramion ze sztangą',
        primaryMuscles: ['Biceps'],
        secondaryMuscles: [],
        level: 'Średni',
        description: 'Klasyczne ćwiczenie na masę bicepsa.',
        youtubeLink: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
      ),
      Exercise(
        name: 'Uginanie ramion z hantlami',
        primaryMuscles: ['Biceps'],
        secondaryMuscles: [],
        level: 'Początkujący',
        description: 'Ćwiczenie na izolację bicepsa.',
        youtubeLink: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
      ),
      Exercise(
        name: 'Młotkowe uginanie ramion',
        primaryMuscles: ['Biceps'],
        secondaryMuscles: ['Przedramiona'],
        level: 'Średni',
        description: 'Ćwiczenie na rozwój mięśni ramienno-promieniowych.',
        youtubeLink: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
      ),
      Exercise(
        name: 'Uginanie ramion na modlitewniku',
        primaryMuscles: ['Biceps'],
        secondaryMuscles: [],
        level: 'Zaawansowany',
        description: 'Ćwiczenie na izolację i rozciągnięcie bicepsa.',
        youtubeLink: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
      ),

      // Przedramiona
      Exercise(
        name: 'Zginanie nadgarstków ze sztangą',
        primaryMuscles: ['Przedramiona'],
        secondaryMuscles: [],
        level: 'Początkujący',
        description: 'Ćwiczenie na siłę i masę przedramion.',
        youtubeLink: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
      ),
      Exercise(
        name: 'Prostowanie nadgarstków ze sztangą',
        primaryMuscles: ['Przedramiona'],
        secondaryMuscles: [],
        level: 'Początkujący',
        description: 'Ćwiczenie na rozwój tylnej części przedramion.',
        youtubeLink: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
      ),
      Exercise(
        name: 'Uginanie nadgarstków z hantlami',
        primaryMuscles: ['Przedramiona'],
        secondaryMuscles: [],
        level: 'Średni',
        description: 'Ćwiczenie izolujące mięśnie przedramion.',
        youtubeLink: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
      ),
      Exercise(
        name: 'Trzymanie ciężaru w opuszczonych dłoniach',
        primaryMuscles: ['Przedramiona'],
        secondaryMuscles: [],
        level: 'Zaawansowany',
        description: 'Statyczne ćwiczenie na wytrzymałość przedramion.',
        youtubeLink: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
      ),

      // Uda tylnie i pośladki
      Exercise(
        name: 'Martwy ciąg na prostych nogach',
        primaryMuscles: ['Uda tylnie i pośladki'],
        secondaryMuscles: ['Plecy'],
        level: 'Średni',
        description: 'Ćwiczenie na rozwój mięśni dwugłowych uda i pośladków.',
        youtubeLink: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
      ),
      Exercise(
        name: 'Glute Bridge',
        primaryMuscles: ['Uda tylnie i pośladki'],
        secondaryMuscles: [],
        level: 'Początkujący',
        description: 'Ćwiczenie na siłę i rozciągnięcie pośladków.',
        youtubeLink: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
      ),
      Exercise(
        name: 'Przysiad bułgarski',
        primaryMuscles: ['Uda tylnie i pośladki'],
        secondaryMuscles: ['Plecy'],
        level: 'Zaawansowany',
        description: 'Jednostronne ćwiczenie na nogi i pośladki.',
        youtubeLink: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
      ),
      Exercise(
        name: 'Hip Thrust',
        primaryMuscles: ['Uda tylnie i pośladki'],
        secondaryMuscles: [],
        level: 'Średni',
        description: 'Ćwiczenie na wzmocnienie pośladków.',
        youtubeLink: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
      ),

      // Brzuch
      Exercise(
        name: 'Plank',
        primaryMuscles: ['Brzuch'],
        secondaryMuscles: ['Plecy'],
        level: 'Początkujący',
        description: 'Statyczne ćwiczenie na siłę core.',
        youtubeLink: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
      ),
      Exercise(
        name: 'Skręty tułowia z piłką',
        primaryMuscles: ['Brzuch'],
        secondaryMuscles: [],
        level: 'Średni',
        description: 'Ćwiczenie na mięśnie skośne brzucha.',
        youtubeLink: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
      ),
      Exercise(
        name: 'Unoszenie nóg w zwisie',
        primaryMuscles: ['Brzuch'],
        secondaryMuscles: [],
        level: 'Zaawansowany',
        description: 'Ćwiczenie na dolne partie brzucha.',
        youtubeLink: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
      ),
      Exercise(
        name: 'Rowerek',
        primaryMuscles: ['Brzuch'],
        secondaryMuscles: ['Nogi'],
        level: 'Początkujący',
        description: 'Ćwiczenie na wszystkie partie brzucha.',
        youtubeLink: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
      ),

      // Łydki
      Exercise(
        name: 'Wspięcia na palce',
        primaryMuscles: ['Łydki'],
        secondaryMuscles: [],
        level: 'Początkujący',
        description: 'Ćwiczenie na rozwój łydek.',
        youtubeLink: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
      ),
      Exercise(
        name: 'Wspięcia na palce na maszynie',
        primaryMuscles: ['Łydki'],
        secondaryMuscles: [],
        level: 'Średni',
        description: 'Ćwiczenie z obciążeniem na łydki.',
        youtubeLink: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
      ),
      Exercise(
        name: 'Donkey Calf Raise',
        primaryMuscles: ['Łydki'],
        secondaryMuscles: [],
        level: 'Zaawansowany',
        description: 'Ćwiczenie na siłę i masę łydek.',
        youtubeLink: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
      ),
      Exercise(
        name: 'Wspięcia na jednej nodze',
        primaryMuscles: ['Łydki'],
        secondaryMuscles: [],
        level: 'Średni',
        description: 'Izolowane ćwiczenie na łydki.',
        youtubeLink: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
      ),

      // Uda przednie
      Exercise(
        name: 'Przysiady ze sztangą',
        primaryMuscles: ['Uda przednie'],
        secondaryMuscles: ['Pośladki'],
        level: 'Średni',
        description: 'Ćwiczenie na siłę i masę nóg.',
        youtubeLink: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
      ),
      Exercise(
        name: 'Przysiady z hantlami',
        primaryMuscles: ['Uda przednie'],
        secondaryMuscles: ['Pośladki'],
        level: 'Początkujący',
        description: 'Ćwiczenie na siłę nóg.',
        youtubeLink: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
      ),
      Exercise(
        name: 'Wykroki z hantlami',
        primaryMuscles: ['Uda przednie'],
        secondaryMuscles: ['Pośladki'],
        level: 'Średni',
        description: 'Ćwiczenie na równowagę i siłę nóg.',
        youtubeLink: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
      ),
      Exercise(
        name: 'Hack Squat',
        primaryMuscles: ['Uda przednie'],
        secondaryMuscles: [],
        level: 'Zaawansowany',
        description: 'Ćwiczenie na izolację mięśni czworogłowych.',
        youtubeLink: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
      ),

      // Całe ciało
      Exercise(
        name: 'Burpees',
        primaryMuscles: ['Całe ciało'],
        secondaryMuscles: [],
        level: 'Średni',
        description: 'Ćwiczenie kondycyjne i siłowe na całe ciało.',
        youtubeLink: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
      ),
      Exercise(
        name: 'Mountain Climbers',
        primaryMuscles: ['Całe ciało'],
        secondaryMuscles: [],
        level: 'Początkujący',
        description: 'Ćwiczenie na siłę i wytrzymałość.',
        youtubeLink: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
      ),
      Exercise(
        name: 'Thrusters',
        primaryMuscles: ['Całe ciało'],
        secondaryMuscles: ['Barki', 'Nogi'],
        level: 'Średni',
        description: 'Ćwiczenie na siłę i kondycję.',
        youtubeLink: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
      ),
      Exercise(
        name: 'Clean and Press',
        primaryMuscles: ['Całe ciało'],
        secondaryMuscles: ['Barki', 'Nogi'],
        level: 'Zaawansowany',
        description: 'Ćwiczenie wielostawowe na rozwój siły całego ciała.',
        youtubeLink: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
      ),

      // Kardio
      Exercise(
        name: 'Bieganie',
        primaryMuscles: ['Kardio'],
        secondaryMuscles: [],
        level: 'Początkujący',
        description: 'Ćwiczenie kondycyjne na świeżym powietrzu.',
        youtubeLink: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
      ),
      Exercise(
        name: 'Skakanie na skakance',
        primaryMuscles: ['Kardio'],
        secondaryMuscles: [],
        level: 'Średni',
        description: 'Ćwiczenie na poprawę wytrzymałości i koordynacji.',
        youtubeLink: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
      ),
      Exercise(
        name: 'Jazda na rowerze',
        primaryMuscles: ['Kardio'],
        secondaryMuscles: ['Nogi'],
        level: 'Początkujący',
        description: 'Ćwiczenie na poprawę kondycji i wytrzymałości.',
        youtubeLink: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
      ),
      Exercise(
        name: 'Orbitrek',
        primaryMuscles: ['Kardio'],
        secondaryMuscles: ['Całe ciało'],
        level: 'Średni',
        description:
            'Ćwiczenie na poprawę kondycji i wzmocnienie całego ciała.',
        youtubeLink: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
      ),
    ]);

    print('Ćwiczenia zostały pomyślnie dodane.');
  } else {
    print('Box exercises już zawiera dane.');
  }
}
