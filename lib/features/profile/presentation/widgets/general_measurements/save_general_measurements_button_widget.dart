import 'package:flutter/material.dart';
import '../../../../../main.dart';
import '../../../../plan/data/models/training_plan_card_model.dart';
import '../../../data/services/profile_general_measurement_service.dart';

class SaveGeneralMeasurementsButtonWidget extends StatelessWidget {
  final TextEditingController weightController;
  final TextEditingController heightController;
  final TextEditingController fatPercentageController;
  final TextEditingController musclePercentageController;

  const SaveGeneralMeasurementsButtonWidget({
    Key? key,
    required this.weightController,
    required this.heightController,
    required this.fatPercentageController,
    required this.musclePercentageController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () async {
          final weightText = weightController.text.trim();
          final heightText = heightController.text.trim();
          final fatPercentage = fatPercentageController.text.trim();
          final musclePercentage = musclePercentageController.text.trim();

          final weight = double.tryParse(weightText) ?? 0.0;
          final height = double.tryParse(heightText) ?? 0.0;

          final generalMeasurements = {
            'weight': weightText.isNotEmpty ? weightText : '-',
            'height': heightText.isNotEmpty ? heightText : '-',
            'BMI': (weight > 0 && height > 0)
                ? (weight / ((height / 100) * (height / 100)))
                    .toStringAsFixed(2)
                : '-',
            'fat': fatPercentage.isNotEmpty ? fatPercentage : '-',
            'muscles': musclePercentage.isNotEmpty ? musclePercentage : '-',
          };

          try {
            await ProfileGeneralMeasurementService().saveGeneralMeasurements(
              generalMeasurements,
            );

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Dane ogólne zapisane pomyślnie!'),
                backgroundColor: Colors.green,
              ),
            );

            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => MainNavigationBar(
                  flag: false,
                  trainingPlanCard: TrainingPlanCardModel.empty(),
                  panelNumber: 4,
                ),
              ),
              (route) => false,
            );
          } catch (error) {
            print('Błąd podczas zapisu danych: $error');
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content:
                    Text('Nie udało się zapisać danych. Spróbuj ponownie.'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          elevation: 8.0,
          backgroundColor: Colors.green,
          shadowColor: Colors.green.withOpacity(0.5),
          textStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.save, color: Colors.white),
            SizedBox(width: 8),
            Text(
              'Zapisz',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
