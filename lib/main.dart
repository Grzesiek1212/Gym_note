import 'package:flutter/material.dart';
import 'package:gym_note/features/profile/data/models/photo_model.dart';
import 'package:gym_note/features/exercise/data/repositories/exercise_data.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'features/exercise/presentation/screens/exercise_screen.dart';
import 'features/exercise/data/models/exercise_model.dart';
import 'features/profile/data/models/measurement_model.dart';
import 'core/data/models/set_model.dart';
import 'features/training/data/models/training_card_model.dart';
import 'core/data/models/training_exercise_model.dart';
import 'features/plan/data/models/training_plan_card_model.dart';
import 'features/plan/data/repositories/ready_plan_data.dart';
import 'features/training/presentation/screens/training_screen.dart';
import 'features/history/presentation/screens/history_screen.dart';
import 'features/plan/presentation/screens/plan_screen.dart';
import 'features/profile/presentation/screens/profile_screen.dart';
import 'features/training/data/services/training_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  //await Hive.deleteFromDisk();

  Hive.registerAdapter(MeasurementAdapter());
  Hive.registerAdapter(ExerciseAdapter());
  Hive.registerAdapter(ExerciseSetAdapter());
  Hive.registerAdapter(TrainingExerciseModelAdapter());
  Hive.registerAdapter(TrainingCardAdapter());
  Hive.registerAdapter(TrainingPlanCardModelAdapter());
  Hive.registerAdapter(PhotoModelAdapter());

  await Hive.openBox<Measurement>('measurements');
  await Hive.openBox<Exercise>('exercises');
  await Hive.openBox<TrainingCard>('trainingCards');
  await Hive.openBox<TrainingPlanCardModel>('trainingPlanCards');
  await Hive.openBox<PhotoModel>('PhotoModels');

  await addExercises();
  await addTrainingPlans();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TrainingService()),
      ],
      child: MyApp(),
    ),
  );
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gym Note',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
      ),
      home: MainNavigationBar(
        flag: false,
        trainingPlanCard: TrainingPlanCardModel.empty(),
        panelNumber: 2,
      ),
    );
  }
}

class MainNavigationBar extends StatefulWidget {
  final bool flag;
  final TrainingPlanCardModel trainingPlanCard;
  final int panelNumber;

  const MainNavigationBar({
    super.key,
    required this.flag,
    required this.trainingPlanCard,
    required this.panelNumber,
  });

  @override
  State<MainNavigationBar> createState() => _MainNavigationBarState();
}

class _MainNavigationBarState extends State<MainNavigationBar> {
  int _currentIndex = 2;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.panelNumber;
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }



  @override
  Widget build(BuildContext context) {
    final List<Widget> _screens = [
      HistoryScreen(),
      PlanScreen(),
      TrainingScreen(flag: widget.flag, trainingPlanCard: widget.trainingPlanCard),
      ExerciseScreen(),
      ProfileScreen(),
    ];

    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFFF5F5F5),
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.black54,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Historia',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.note),
            label: 'Plany',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_sharp),
            label: 'Trening',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center_outlined),
            label: 'Ćwiczenia',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}
