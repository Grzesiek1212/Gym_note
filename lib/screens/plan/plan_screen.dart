import 'package:flutter/material.dart';
import '../../models/training_plan_card_model.dart';
import '../../services/plan_service.dart';
import '../../widgets/plan_card.dart';

class PlanScreen extends StatefulWidget {
  @override
  _PlanScreenState createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final PlanService _planService = PlanService();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F5F5),
        title: const Text(
          'Plany treningowe',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.black),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Dodawanie nowego planu w budowie...')) ,
              );
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: "WŁASNE"),
            Tab(text: "GOTOWE"),
          ],
          indicatorColor: Colors.green,
          labelColor: Colors.green,
          unselectedLabelColor: Colors.black,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildTabContent("Brak własnych planów treningowych", isOwnPlans: true),
          _buildTabContent("Brak gotowych planów treningowych", isOwnPlans: false),
        ],
      ),
    );
  }

  Widget _buildTabContent(String message, {required bool isOwnPlans}) {
    return FutureBuilder<List<TrainingPlanCardModel>>(
      future: _planService.getPlans(isOwnPlans),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Błąd: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text(message, style: const TextStyle(fontSize: 16, color: Colors.grey)));
        }

        final plans = snapshot.data!;

        return ListView.builder(
          itemCount: plans.length,
          itemBuilder: (context, index) {
            return PlanCard(
              plan: plans[index],
              planName: plans[index].name,
              exercises: plans[index].exercises.map((e) => {
                'name': e.exercise.name,
                'sets': e.sets.map((set) => 'Powtórzenia: ${set.repetitions}').join(', ')
              }).toList(),
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
