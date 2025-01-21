import 'package:flutter/material.dart';
import '../../data/models/training_plan_card_model.dart';
import '../../data/services/plan_service.dart';
import 'plan_list_view_widget.dart';

class PlansTabViewWidget extends StatelessWidget {
  final TabController tabController;

  const PlansTabViewWidget({Key? key, required this.tabController})
      : super(key: key);

  Widget _buildTabContent(String message, bool isOwnPlans) {
    final PlanService planService = PlanService();

    return FutureBuilder<List<TrainingPlanCardModel>>(
      future: planService.getPlans(isOwnPlans),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Błąd: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Text(
              message,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
          );
        }

        final plans = snapshot.data!;

        return PlanListViewWidget(plans: plans);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: tabController,
      children: [
        _buildTabContent("Brak własnych planów treningowych", true),
        _buildTabContent("Brak gotowych planów treningowych", false),
      ],
    );
  }
}
