import 'package:flutter/material.dart';
import '../widgets/body_measurements/measurement_input_field_widget.dart';
import '../widgets/body_measurements/save_measurements_button_widget.dart';
import '../widgets/section_title_widget.dart';

class AddMeasurementScreen extends StatefulWidget {
  const AddMeasurementScreen({Key? key}) : super(key: key);

  @override
  _AddMeasurementScreenState createState() => _AddMeasurementScreenState();
}

class _AddMeasurementScreenState extends State<AddMeasurementScreen> {
  final TextEditingController _chestController = TextEditingController();
  final TextEditingController _leftBicepsController = TextEditingController();
  final TextEditingController _rightBicepsController = TextEditingController();
  final TextEditingController _leftForearmController = TextEditingController();
  final TextEditingController _rightForearmController = TextEditingController();
  final TextEditingController _waistController = TextEditingController();
  final TextEditingController _hipsController = TextEditingController();
  final TextEditingController _thighController = TextEditingController();
  final TextEditingController _calfController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dodaj pomiary'),
        backgroundColor: const Color(0xFFF5F5F5),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionTitleWidget(title: 'Górna część ciała'),
              MeasurementInputFieldWidget(keyName: 'Klatka piersiowa (cm)', controller: _chestController, usePolishLabels: false),
              MeasurementInputFieldWidget(keyName: 'Biceps lewy (cm)', controller: _leftBicepsController, usePolishLabels: false),
              MeasurementInputFieldWidget(keyName: 'Biceps prawy (cm)', controller: _rightBicepsController, usePolishLabels: false),
              MeasurementInputFieldWidget(keyName: 'Przedramię lewe (cm)', controller: _leftForearmController, usePolishLabels: false),
              MeasurementInputFieldWidget(keyName: 'Przedramię prawe (cm)', controller: _rightForearmController, usePolishLabels: false),
              const SizedBox(height: 16),
              const SectionTitleWidget(title: 'Środek ciała'),
              MeasurementInputFieldWidget(keyName: 'Brzuch (cm)', controller: _waistController, usePolishLabels: false),
              MeasurementInputFieldWidget(keyName: 'Biodra (cm)', controller: _hipsController, usePolishLabels: false),
              const SizedBox(height: 16),
              const SectionTitleWidget(title: 'Dolna część ciała'),
              MeasurementInputFieldWidget(keyName: 'Uda (cm)', controller: _thighController, usePolishLabels: false),
              MeasurementInputFieldWidget(keyName: 'Łydka (cm)', controller: _calfController, usePolishLabels: false),
              const SizedBox(height: 32),
              SaveMeasurementsButtonWidget(
                chestController: _chestController,
                leftBicepsController: _leftBicepsController,
                rightBicepsController: _rightBicepsController,
                leftForearmController: _leftForearmController,
                rightForearmController: _rightForearmController,
                waistController: _waistController,
                hipsController: _hipsController,
                thighController: _thighController,
                calfController: _calfController,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _chestController.dispose();
    _leftBicepsController.dispose();
    _rightBicepsController.dispose();
    _leftForearmController.dispose();
    _rightForearmController.dispose();
    _waistController.dispose();
    _hipsController.dispose();
    _thighController.dispose();
    _calfController.dispose();
    super.dispose();
  }
}
