import 'package:flutter/material.dart';
import '../../../../../main.dart';
import '../../../../plan/data/models/training_plan_card_model.dart';
import '../../../data/services/profile_measurement_service.dart';

class SaveMeasurementsButtonWidget extends StatelessWidget {
  final TextEditingController chestController;
  final TextEditingController leftBicepsController;
  final TextEditingController rightBicepsController;
  final TextEditingController leftForearmController;
  final TextEditingController rightForearmController;
  final TextEditingController waistController;
  final TextEditingController hipsController;
  final TextEditingController thighController;
  final TextEditingController calfController;

  const SaveMeasurementsButtonWidget({
    Key? key,
    required this.chestController,
    required this.leftBicepsController,
    required this.rightBicepsController,
    required this.leftForearmController,
    required this.rightForearmController,
    required this.waistController,
    required this.hipsController,
    required this.thighController,
    required this.calfController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16.0),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          final measurements = {
            'chest': chestController.text,
            'leftBiceps': leftBicepsController.text,
            'rightBiceps': rightBicepsController.text,
            'leftForearm': leftForearmController.text,
            'rightForearm': rightForearmController.text,
            'waist': waistController.text,
            'hips': hipsController.text,
            'thigh': thighController.text,
            'calf': calfController.text,
          };

          try {
            await ProfileMeasurementService().saveMeasurements(measurements);

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Pomiary zapisane pomyślnie!'),
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
