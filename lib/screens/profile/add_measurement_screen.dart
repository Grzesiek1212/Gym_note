import 'package:flutter/material.dart';

import '../../services/profile/profile_measurement_service.dart';

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
              _buildSectionTitle('Górna część ciała'),
              _buildInputField('Klatka piersiowa (cm)', _chestController),
              _buildInputField('Biceps lewy (cm)', _leftBicepsController),
              _buildInputField('Biceps prawy (cm)', _rightBicepsController),
              _buildInputField('Przedramię lewe (cm)', _leftForearmController),
              _buildInputField('Przedramię prawe (cm)', _rightForearmController),
              const SizedBox(height: 16),
              _buildSectionTitle('Środek ciała'),
              _buildInputField('Brzuch (cm)', _waistController),
              _buildInputField('Biodra (cm)', _hipsController),
              const SizedBox(height: 16),
              _buildSectionTitle('Dolna część ciała'),
              _buildInputField('Uda (cm)', _thighController),
              _buildInputField('Łydka (cm)', _calfController),
              const SizedBox(height: 32),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    final chest = _chestController.text;
                    final leftBiceps = _leftBicepsController.text;
                    final rightBiceps = _rightBicepsController.text;
                    final leftForearm = _leftForearmController.text;
                    final rightForearm = _rightForearmController.text;
                    final waist = _waistController.text;
                    final hips = _hipsController.text;
                    final thigh = _thighController.text;
                    final calf = _calfController.text;

                    // Tworzenie mapy z danymi do zapisania
                    final measurements = {
                      'klatka_piersiowa': chest,
                      'biceps_lewy': leftBiceps,
                      'biceps_prawy': rightBiceps,
                      'przedramie_lewe': leftForearm,
                      'przedramie_prawe': rightForearm,
                      'brzuch': waist,
                      'biodra': hips,
                      'uda': thigh,
                      'lydka': calf,
                    };

                    try {
                      await ProfileMeasurementService().saveMeasurements(measurements);

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Pomiary zapisane pomyślnie!'),
                          backgroundColor: Colors.green,
                        ),
                      );
                      Navigator.pop(context);
                    } catch (error) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Nie udało się zapisać danych. Spróbuj ponownie.')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  child: const Text('Zapisz'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
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
