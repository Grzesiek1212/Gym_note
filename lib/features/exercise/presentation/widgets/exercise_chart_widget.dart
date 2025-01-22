import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExerciseChartWidget extends StatelessWidget {
  final List<Map<String, dynamic>> weights;

  const ExerciseChartWidget({Key? key, required this.weights})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final spots = weights.asMap().entries.map((entry) {
      final index = entry.key;
      final value = (entry.value['weight'] as num).toDouble();
      return FlSpot(index.toDouble(), value);
    }).toList();

    return SizedBox(
      height: 250,
      child: LineChart(
        LineChartData(
          gridData: FlGridData(
            show: true,
            drawHorizontalLine: true,
            drawVerticalLine: false,
            getDrawingHorizontalLine: (value) {
              return FlLine(color: Colors.grey.shade300, strokeWidth: 1);
            },
          ),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                getTitlesWidget: (value, meta) {
                  return Text(value.toStringAsFixed(1),
                      style:
                          const TextStyle(color: Colors.black, fontSize: 12));
                },
              ),
            ),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 50,
                interval: weights.length > 10 ? 2 : 1,
                getTitlesWidget: (value, meta) {
                  final index = value.toInt();
                  if (index >= 0 && index < weights.length) {
                    final dateString = weights[index]['date'] as String;
                    final dateTime = DateTime.parse(dateString);
                    final formattedDate = DateFormat('dd-MM').format(dateTime);
                    return Text(
                      formattedDate,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                      ),
                      textAlign: TextAlign.center,
                    );
                  }
                  return const Text('');
                },
              ),
            ),
          ),
          borderData: FlBorderData(
            show: true,
            border: Border.all(color: Colors.grey.shade400, width: 1),
          ),
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              gradient: LinearGradient(
                colors: [Colors.lightGreenAccent, Colors.green],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              barWidth: 4,
              belowBarData: BarAreaData(
                show: false,
                gradient: LinearGradient(
                  colors: [Colors.orangeAccent, Colors.transparent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              dotData: FlDotData(show: true),
            ),
          ],
        ),
      ),
    );
  }
}
