import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartWidget extends StatelessWidget {
  final List<Map<String, dynamic>> measurements;

  const LineChartWidget({Key? key, required this.measurements}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final spots = measurements.asMap().entries.map((entry) {
      final index = entry.key;
      final value = (entry.value['value'] as num).toDouble();
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
              return FlLine(
                color: Colors.grey.shade300,
                strokeWidth: 1,
              );
            },
          ),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                getTitlesWidget: (value, meta) {
                  return Text(
                    value.toStringAsFixed(1),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                    ),
                  );
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
                interval: measurements.length > 10 ? 2 : 1,
                getTitlesWidget: (value, meta) {
                  final index = value.toInt();
                  if (index >= 0 && index < measurements.length) {
                    final date = measurements[index]['date'] ?? '';
                    return Text(
                      date.substring(5),
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
              dotData: FlDotData(show: true),
            ),
          ],
        ),
      ),
    );
  }
}
