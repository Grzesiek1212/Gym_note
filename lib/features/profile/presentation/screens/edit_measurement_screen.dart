import 'package:flutter/material.dart';
import '../widgets/date_selector_widget.dart';
import '../widgets/body_measurements/measurement_input_field_widget.dart';
import '../../data/services/profile_measurement_service.dart';
import '../widgets/body_measurements/save_edit_measurements_button_widget.dart';

class EditMeasurementsScreen extends StatefulWidget {
  const EditMeasurementsScreen({Key? key}) : super(key: key);

  @override
  _EditBodyMeasurementsScreenState createState() =>
      _EditBodyMeasurementsScreenState();
}

class _EditBodyMeasurementsScreenState
    extends State<EditMeasurementsScreen> {
  final ProfileMeasurementService _profileService = ProfileMeasurementService();
  final Map<String, TextEditingController> _controllers = {};
  bool _isLoading = false;
  String? _selectedDate;
  List<String> _availableDates = [];

  @override
  void initState() {
    super.initState();
    const initialKeys = [
      'chest',
      'leftBiceps',
      'rightBiceps',
      'BMI',
      'leftForearm',
      'rightForearm',
      'waist',
      'hips',
      'thigh',
      'calf',
    ];
    for (var key in initialKeys) {
      _controllers[key] = TextEditingController();
    }
    _fetchAvailableDates();
  }

  @override
  void dispose() {
    _controllers.values.forEach((controller) => controller.dispose());
    super.dispose();
  }

  Future<void> _fetchAvailableDates() async {
    try {
      final dates = await _profileService.fetchAvailableDates();
      setState(() {
        _availableDates = dates;
      });
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Błąd podczas pobierania dostępnych dat: $error'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _fetchDataByDate(String date) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final measurements = await _profileService.fetchMeasurementsByDate(date);
      setState(() {
        measurements.forEach((key, value) {
          if (_controllers.containsKey(key)) {
            _controllers[key]!.text = value;
          }
        });
      });
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Błąd podczas pobierania danych: $error'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edytuj pomiary ciała'),
        backgroundColor: const Color(0xFFF5F5F5),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DateSelectorWidget(
                availableDates: _availableDates,
                selectedDate: _selectedDate,
                onDateSelected: (date) {
                  setState(() {
                    _selectedDate = date;
                  });
                  _fetchDataByDate(date);
                },
              ),
              const SizedBox(height: 16),
              if (_isLoading)
                const Center(child: CircularProgressIndicator())
              else ...[
                const Text(
                  'Edytuj dane:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                ..._controllers.keys.map((key) {
                  return MeasurementInputFieldWidget(
                    keyName: key,
                    controller: _controllers[key]!,
                  );
                }).toList(),
                const SizedBox(height: 32),
                SaveEditMeasurementsButtonWidget(
                  selectedDate: _selectedDate,
                  controllers: _controllers,
                  profileService: _profileService,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
