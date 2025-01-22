import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/models/training_card_model.dart';
import '../../../plan/data/models/training_plan_card_model.dart';
import '../../data/services/training_service.dart';
import '../widgets/add_exercise_button_widget.dart';
import '../widgets/exercise_list_widget.dart';
import '../widgets/finish_training_dialog_widget.dart';
import '../widgets/training_header_widget.dart';
import 'choose_training_option_screen.dart';
import 'exercise_training_screen.dart';
import 'training_summary_screen.dart';

class TrainingScreen extends StatefulWidget {
  final bool flag;
  final TrainingPlanCardModel trainingPlanCard;

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
  TextEditingController _planNameController = TextEditingController();
  TextEditingController _planDescriptionController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  bool isNew = false;

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
        if (!trainingService.isTrainingStarted) {
          trainingService.isTrainingStarted = true;
          trainingService.startTrainingTime();
          trainingService.setTrainingFromPlan(widget.trainingPlanCard);
          if (widget.trainingPlanCard.exercises.isEmpty) {
            setState(() {
              isNew = true;
            });
          }
        }
      });
    } else {
      trainingService.trainingExercisesList.clear();
      trainingService.isTrainingStarted = false;
    }
  }

  void _showEditTimeDialog(BuildContext context, TrainingService trainingService) {
    _timeController.text = trainingService.breakSeconds.toString();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edytuj Czas Stopera'),
          content: TextField(
            controller: _timeController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Nowy czas w sekundach'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                final newTime = int.tryParse(_timeController.text);
                if (newTime != null) {
                  trainingService.editTime(newTime);
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<bool> _showFinishDialog(BuildContext context) async {
    _planNameController.clear();
    _planDescriptionController.clear();
    if (!isNew) {
      _planNameController.text = widget.trainingPlanCard.name;
    }

    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return FinishTrainingDialogWidget(
          isNew: isNew,
          nameController: _planNameController,
          descriptionController: _planDescriptionController,
        );
      },
    );
    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final trainingService = Provider.of<TrainingService>(context);
    final trainingExercisesList = trainingService.trainingExercisesList;

    if (!widget.flag) { // if training is not started
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
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChooseTrainingOptionScreen(),
                    ),
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
                    constraints: const BoxConstraints(
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

    return Scaffold( // if training is started
      appBar: AppBar(
        title: const Text('Trening'),
        backgroundColor: const Color(0xFFF5F5F5),
        elevation: 0,
      ),
      body: Column(
        children: [
          TrainingHeaderWidget(
            onFinishTraining: () async {

              if(trainingService.trainingExercisesList.isEmpty){
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('musisz dodać chociaż 1 ćwiczenie aby zakończyć trening'),
                  backgroundColor: Colors.red),
                );
                return;
              }
              bool confirmed = await _showFinishDialog(context);
              if (!confirmed) return;

              final planName = _planNameController.text.trim();
              final trainingDesc = _planDescriptionController.text.trim();

              final exercisesCopy = trainingExercisesList
                  .map((exercise) => exercise.copyWith(
                sets: exercise.sets.map((set) => set.copyWith()).toList(),
              ))
                  .toList();

              final completedTraining = TrainingCard(
                date: DateTime.now(),
                duration: trainingService.trainingTime,
                exercises: exercisesCopy,
                description: trainingDesc,
              );

              await trainingService.finishAndResetTraining(isNew, planName, trainingDesc);
              trainingService.isTrainingStarted = false;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TrainingSummaryScreen(training: completedTraining),
                ),
              );
            },
            onStartStop: () {
              trainingService.startStopwatch();
            },
            onEditTime: () {
              _showEditTimeDialog(context, trainingService);
            },
          ),
          const SizedBox(height: 16),
          Expanded(
            child: trainingExercisesList.isEmpty
                ? const Center(child: Text("Brak ćwiczeń w treningu"))
                : ExerciseListWidget(
              exercises: trainingExercisesList,
              currentPage: _currentPage,
              pageController: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
            ),
          ),
          AddExerciseButtonWidget(
            onAddExercise: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ExerciseTrainingScreen()),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
