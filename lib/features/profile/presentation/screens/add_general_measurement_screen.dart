import 'package:flutter/material.dart';
import '../widgets/general_measurements/general_measurement_input_field_widget.dart';
import '../widgets/general_measurements/save_general_measurements_button_widget.dart';

class AddGeneralMeasurementsScreen extends StatefulWidget {
  const AddGeneralMeasurementsScreen({Key? key}) : super(key: key);

  @override
  _AddGeneralMeasurementsScreenState createState() =>
      _AddGeneralMeasurementsScreenState();
}

class _AddGeneralMeasurementsScreenState
    extends State<AddGeneralMeasurementsScreen> {
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _fatPercentageController =
      TextEditingController();
  final TextEditingController _musclePercentageController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dodaj dane ogólne'),
        backgroundColor: const Color(0xFFF5F5F5),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GeneralMeasurementInputFieldWidget(
                keyName: 'Waga (kg)',
                controller: _weightController,
                usePolishLabels: false,
              ),
              const SizedBox(height: 16),
              GeneralMeasurementInputFieldWidget(
                keyName: 'Wzrost (cm)',
                controller: _heightController,
                usePolishLabels: false,
              ),
              const SizedBox(height: 16),
              GeneralMeasurementInputFieldWidget(
                keyName: '% Tłuszczu',
                controller: _fatPercentageController,
                usePolishLabels: false,
              ),
              const SizedBox(height: 16),
              GeneralMeasurementInputFieldWidget(
                keyName: '% Mięśni',
                controller: _musclePercentageController,
                usePolishLabels: false,
              ),
              const SizedBox(height: 32),
              SaveGeneralMeasurementsButtonWidget(
                weightController: _weightController,
                heightController: _heightController,
                fatPercentageController: _fatPercentageController,
                musclePercentageController: _musclePercentageController,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _weightController.dispose();
    _heightController.dispose();
    _fatPercentageController.dispose();
    _musclePercentageController.dispose();
    super.dispose();
  }
}
