import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/training_card_model.dart';
import '../../models/training_plan_card.dart';
import '../../services/training/training_service.dart';
import '../../widgets/training_exercise_panel_widget.dart';
import 'choose_training_option_screen.dart';
import 'exercise_training_screen.dart';
import 'training_summary_screen.dart';

class TrainingScreen extends StatefulWidget {
  final bool flag;
  final TrainingPlanCard trainingPlanCard;

  const TrainingScreen({
    Key? key,
    required this.flag,
    required this.trainingPlanCard,
  }) : super(key: key);


  @override
  _TrainingScreenState createState() => _TrainingScreenState();
}

class _TrainingScreenState extends State<TrainingScreen> {
  int _currentPage = 0;
  final PageController _pageController = PageController();
  int _seconds = 60; // Początkowy czas w sekundach
  Timer? _timer;
  bool _isRunning = false;
  bool isNew = false;
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final trainingService = Provider.of<TrainingService>(context, listen: false);
    if (widget.flag) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!trainingService.isTrainingStarted) { // Zapobiegaj wielokrotnemu nadpisywaniu
          trainingService.isTrainingStarted = true;
          trainingService.startTrainingTime();
          trainingService.setTrainingFromPlan(widget.trainingPlanCard);
          if(widget.trainingPlanCard.exercises.isEmpty){
            isNew = true;
          }
        }else{
        }
      });
    }else{
      trainingService.trainingExercisesList.clear();
      trainingService.isTrainingStarted = false;
    }
  }

  // Funkcja uruchamiająca stoper
  void _startStopwatch() {
    if (_isRunning) {
      _timer?.cancel();
    } else {
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        if (_seconds > 0) {
          setState(() {
            _seconds--;
            if(_seconds == 0){
              _timer?.cancel();
              setState(() {
                _seconds = int.parse(_controller.text);
                _isRunning = false;
              });
            }
          });
        }
      });
    }
    setState(() {
      _isRunning = !_isRunning;
    });
  }

  // Funkcja do edytowania czasu
  void _editTime() {
    showDialog(
      context: context,
      builder: (context) {
        _controller.text = _seconds.toString();
        return AlertDialog(
          title: const Text('Edytuj czas'),
          content: TextField(
            controller: _controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Czas w sekundach'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                setState(() {
                  _seconds = int.parse(_controller.text);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final trainingService = Provider.of<TrainingService>(context);

    // Gdy trening nie jest rozpoczęty, pokaż przycisk "Rozpocznij trening"
    if (!widget.flag) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Trening'),
          backgroundColor: const Color(0xFFF5F5F5),
          elevation: 0,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Dodaj swój trening!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  // Przejście do ChooseTrainingOptionScreen
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChooseTrainingOptionScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  padding:
                  const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  textStyle: const TextStyle(fontSize: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 0,
                ),
                child: Ink(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue.shade50, Colors.green.shade50],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    constraints: BoxConstraints(
                      maxWidth: 300,
                      minHeight: 75,
                    ),
                    child: const Text(
                      'Rozpocznij trening',
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    // Gdy trening jest rozpoczęty, pokaż widok treningu
    final trainingTime = trainingService.trainingTime;
    final trainingExercisesList = trainingService.trainingExercisesList;

    int hours = trainingTime ~/ 3600;
    int minutes = (trainingTime % 3600) ~/ 60;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Trening'),
        backgroundColor: const Color(0xFFF5F5F5),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Górna część ekranu z zegarem
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      // Tworzenie kopii listy ćwiczeń
                      final exercisesCopy = trainingService.trainingExercisesList
                          .map((exercise) => exercise.copyWith(
                        sets: exercise.sets.map((set) => set.copyWith()).toList(),
                      ))
                          .toList();

                      // Utwórz obiekt `completedTraining` z kopią danych
                      final completedTraining = TrainingCard(
                        date: DateTime.now(),
                        duration: trainingService.trainingTime,
                        exercises: exercisesCopy, // Przekazanie kopii danych
                        description: 'Podsumowanie treningu',
                      );

                      print('Completed Training: $completedTraining');

                      // Przejdź do ekranu podsumowania
                      trainingService.finishAndResetTraining(isNew);
                      trainingService.trainingExercisesList.clear();
                      trainingService.isTrainingStarted = false;

                      print(trainingService.trainingExercisesList.length);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TrainingSummaryScreen(training: completedTraining),
                        ),
                      );
                    });
                  },

                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFC75361),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  ),
                  child: const Text(
                    'ZAKOŃCZ',
                    style: TextStyle(fontSize: 14, color: Colors.white70),
                  ),
                ),
                Column(
                  children: [
                    const Text(
                      'Czas trwania treningu',
                      style: TextStyle(color: Colors.black),
                    ),
                    Text(
                      '$hours:${minutes.toString().padLeft(2, '0')}',
                      style: const TextStyle(color: Colors.black, fontSize: 24),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: _editTime,
                  child: Column(
                    children: [
                      Text(
                        _seconds.toString(),
                        style:
                        const TextStyle(color: Colors.black, fontSize: 24),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.timer),
                  onPressed: _startStopwatch,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Wyświetlanie ćwiczeń w treningu
          Expanded(
            child: trainingExercisesList.isEmpty
                ? const Center(child: Text("Brak ćwiczeń w treningu"))
                : Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    itemCount: trainingExercisesList.length,
                    itemBuilder: (context, index) {
                      final exercise = trainingExercisesList[index];
                      return ExercisePanelWidget(exercise: exercise);
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    trainingExercisesList.length,
                        (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: _currentPage == index ? 12 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: _currentPage == index
                            ? Colors.blue
                            : Colors.grey,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Dodawanie ćwiczenia
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ExerciseTrainingScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFB8D8D8),
                padding:
                const EdgeInsets.symmetric(horizontal: 60, vertical: 16),
                textStyle: const TextStyle(fontSize: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'DODAJ ĆWICZENIE',
                style: TextStyle(fontSize: 18, color: Colors.black87),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


