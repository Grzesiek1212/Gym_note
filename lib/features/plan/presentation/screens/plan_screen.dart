import 'package:flutter/material.dart';
import '../widgets/plans_tab_view_widget.dart';

class PlanScreen extends StatefulWidget {
  @override
  _PlanScreenState createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

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
      body: TabBarView(controller: _tabController, children: [
        PlansTabViewWidget(tabController: _tabController),
        PlansTabViewWidget(tabController: _tabController),
      ]),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
