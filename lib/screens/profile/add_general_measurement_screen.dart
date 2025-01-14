import 'package:flutter/material.dart';

import '../../services/profile/profile_general_measurement_service.dart';



class AddGeneralMeasurementsScreen extends StatefulWidget {
  const AddGeneralMeasurementsScreen({Key? key}) : super(key: key);

  @override
  _AddGeneralMeasurementsScreenState createState() => _AddGeneralMeasurementsScreenState();
}

class _AddGeneralMeasurementsScreenState extends State<AddGeneralMeasurementsScreen> {
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _fatPercentageController = TextEditingController();
  final TextEditingController _musclePercentageController = TextEditingController();

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
              _buildInputField('Waga (kg)', _weightController),
              const SizedBox(height: 16),
              _buildInputField('Wzrost (cm)', _heightController),
              const SizedBox(height: 16),
              _buildInputField('% Tłuszczu', _fatPercentageController),
              const SizedBox(height: 16),
              _buildInputField('% Mięśni', _musclePercentageController),
              const SizedBox(height: 32),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    final weight = _weightController.text;
                    final height = _heightController.text;
                    final fatPercentage = _fatPercentageController.text;
                    final musclePercentage = _musclePercentageController.text;

                    // Tworzenie mapy z danymi do zapisania
                    final generalMeasurements = {
                      'waga': weight,
                      'wzrost': height,
                      'tluszcz': fatPercentage,
                      'miesnie': musclePercentage,
                    };

                    try {
                      // Wywołanie funkcji zapisu w ProfileService
                      await ProfileGeneralMeasurementService().saveGeneralMeasurements(generalMeasurements);

                      // Wyświetlenie SnackBar z informacją o sukcesie
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Dane ogólne zapisane pomyślnie!'),
                          backgroundColor: Colors.green,
                        ),
                      );

                      // Powrót do poprzedniego ekranu po sukcesie
                      Navigator.pop(context);
                    } catch (error) {
                      // Obsługa błędu
                      print('Błąd podczas zapisu danych: $error');
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Nie udało się zapisać danych. Spróbuj ponownie.'),
                          backgroundColor: Colors.red,
                        ),
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

  @override
  void dispose() {
    _weightController.dispose();
    _heightController.dispose();
    _fatPercentageController.dispose();
    _musclePercentageController.dispose();
    super.dispose();
  }
}
