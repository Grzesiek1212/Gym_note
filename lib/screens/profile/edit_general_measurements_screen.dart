import 'package:flutter/material.dart';
import '../../services/profile/profile_general_measurement_service.dart';

class EditGeneralMeasurementsScreen extends StatefulWidget {
  const EditGeneralMeasurementsScreen({Key? key}) : super(key: key);

  @override
  _EditMeasurementsScreenState createState() => _EditMeasurementsScreenState();
}

class _EditMeasurementsScreenState extends State<EditGeneralMeasurementsScreen> {
  final ProfileGeneralMeasurementService _profileService = ProfileGeneralMeasurementService();
  final Map<String, TextEditingController> _controllers = {};
  bool _isLoading = false;
  String? _selectedDate; // Wybrana data
  List<String> _availableDates = []; // Lista dostępnych dat

  @override
  void initState() {
    super.initState();
    const initialKeys = ['waga', 'wzrost', 'tluszcz', 'miesnie'];
    for (var key in initialKeys) {
      _controllers[key] = TextEditingController();
    }
    _fetchAvailableDates(); // Pobierz dostępne daty przy inicjalizacji
  }

  @override
  void dispose() {
    _controllers.values.forEach((controller) => controller.dispose());
    super.dispose();
  }

  Future<void> _fetchAvailableDates() async {
    try {
      final dates = await _profileService.fetchGeneralAvailableDates();
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
      final measurements = await _profileService.fetchGeneralMeasurementsByDate(date);
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
        title: const Text('Edytuj dane ogólne'),
        backgroundColor: const Color(0xFFF5F5F5),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Wybierz datę:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _selectedDate,
                items: _availableDates.map((date) {
                  return DropdownMenuItem(
                    value: date,
                    child: Text(date),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedDate = value;
                    });
                    _fetchDataByDate(value);
                  }
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Data',
                ),
              ),
              const SizedBox(height: 32),
              if (_isLoading)
                const Center(child: CircularProgressIndicator())
              else ...[
                const Text(
                  'Edytuj dane:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                ..._controllers.keys.map((key) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextField(
                      controller: _controllers[key],
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: key,
                        border: const OutlineInputBorder(),
                      ),
                    ),
                  );
                }).toList(),
                const SizedBox(height: 32),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      final updatedMeasurements = _controllers.map((key, controller) {
                        return MapEntry(key, controller.text);
                      });

                      if (_selectedDate == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Wybierz datę przed zapisaniem danych'),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      }

                      try {
                        await _profileService.updateGeneralMeasurements(
                          date: _selectedDate!,
                          measurements: updatedMeasurements,
                        );

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Dane zapisane pomyślnie!'),
                            backgroundColor: Colors.green,
                          ),
                        );
                        Navigator.pop(context);
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
                      backgroundColor: Colors.green,
                    ),
                    child: const Text('Zapisz dane'),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
