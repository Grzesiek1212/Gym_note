import 'package:flutter/material.dart';
import '../../data/services/profile_service.dart';
import '../widgets/line_chart_widget.dart';
import '../widgets/measurement_list_widget.dart';

class SectionDetailScreen extends StatefulWidget {
  final String section;

  const SectionDetailScreen({Key? key, required this.section}) : super(key: key);

  @override
  _SectionDetailScreenState createState() => _SectionDetailScreenState();
}

class _SectionDetailScreenState extends State<SectionDetailScreen> {
  final ProfileService _profileService = ProfileService();
  late Future<List<Map<String, dynamic>>> _measurementsFuture;

  @override
  void initState() {
    super.initState();
    _measurementsFuture = _profileService.fetchMeasurementsByType(widget.section);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.section),
        backgroundColor: const Color(0xFFF5F5F5),
        elevation: 0,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _measurementsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            final measurements = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LineChartWidget(measurements: measurements),
                  const SizedBox(height: 16),
                  MeasurementListWidget(measurements: measurements),
                ],
              ),
            );
          } else {
            return const Center(child: Text('Brak danych.'));
          }
        },
      ),
    );
  }
}
