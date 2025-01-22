import 'package:flutter/material.dart';
import '../../../../../main.dart';
import '../../../../plan/data/models/training_plan_card_model.dart';
import '../../../data/services/profile_general_measurement_service.dart';

class SaveEditGeneralMeasurementsButtonWidget extends StatelessWidget {
  final String? selectedDate;
  final Map<String, TextEditingController> controllers;
  final ProfileGeneralMeasurementService profileService;

  const SaveEditGeneralMeasurementsButtonWidget({
    Key? key,
    required this.selectedDate,
    required this.controllers,
    required this.profileService,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16.0),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          if (selectedDate == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Wybierz datę przed zapisaniem danych'),
                backgroundColor: Colors.red,
              ),
            );
            return;
          }

          final updatedMeasurements = controllers.map((key, controller) {
            return MapEntry(key, controller.text);
          });

          bool allFieldsFilled = true;
          controllers.forEach((key, controller) {
            if (controller.text.isEmpty) {
              allFieldsFilled = false;
            }
          });

          if (!allFieldsFilled) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('By zapisać dane wszytskie pola muszą być uzupełnione'),
                backgroundColor: Colors.red,
              ),
            );
            return;
          }

          try {
            await profileService.updateGeneralMeasurements(
              date: selectedDate!,
              measurements: updatedMeasurements,
            );

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Dane zapisane pomyślnie!'),
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
                content: Text('Błąd podczas zapisu danych. Spróbuj ponownie.'),
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
          backgroundColor: Colors.blue,
          shadowColor: Colors.blueAccent,
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
              'Zapisz dane',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
