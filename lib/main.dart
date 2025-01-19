import 'package:flutter/material.dart';
import 'package:gym_note/screens/exercise/exercise_data.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'models/exercise_model.dart';
import 'models/measurement_model.dart';
import 'models/training_plan_card.dart';
import 'screens/training/training_screen.dart';
import 'screens/exercise/exercise_screen.dart';
import 'screens/history/history_screen.dart';
import 'screens/plan_screen.dart';
import 'screens/profile/profile_screen.dart';
import 'services/training/training_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(MeasurementAdapter());
  Hive.registerAdapter(ExerciseAdapter());

  // Otwórz boxy
  await Hive.openBox<Measurement>('measurements');

  // Dodaj ćwiczenia
  await addExercises();

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
        trainingPlanCard: TrainingPlanCard.empty(),
      ),
    );
  }
}

class MainNavigationBar extends StatefulWidget {
  final bool flag;
  final TrainingPlanCard trainingPlanCard;
  const MainNavigationBar({
    super.key,
    required this.flag,
    required this.trainingPlanCard,
  });

  @override
  State<MainNavigationBar> createState() => _MainNavigationBarState();
}

class _MainNavigationBarState extends State<MainNavigationBar> {
  int _currentIndex = 2;

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
