import 'package:myapp/di/di.dart';
import 'package:myapp/domain/entity/daily_predict.dart';
import 'package:myapp/domain/entity/zodiac_sign.dart';
import 'package:flutter/material.dart';

final class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

final class _MainScreenState extends State<MainScreen> {
  bool _isLoading = false;
  DailyPredict? _predict;
  String? _error;
  ZodiacSign? _selectedSign;

  Future<void> _getDailyPredict() async {
    if (_selectedSign == null) return;

    setState(() {
      _isLoading = true;
      _error = null;
      _predict = null;
    });

    try {
      final predict = await getDailyPredictUseCase(sign: _selectedSign!);
      setState(() {
        _predict = predict;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
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
        title: const Text('Daily Horoscope'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButtonFormField<ZodiacSign>(
              initialValue: _selectedSign,
              hint: const Text('Select your Zodiac Sign'),
              isExpanded: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
              ),
              onChanged: (ZodiacSign? newValue) {
                if (newValue != null) {
                  setState(() {
                    _selectedSign = newValue;
                  });
                }
              },
              items: ZodiacSign.values.map<DropdownMenuItem<ZodiacSign>>((
                ZodiacSign value,
              ) {
                return DropdownMenuItem<ZodiacSign>(
                  value: value,
                  child: Text(
                    value.name[0].toUpperCase() + value.name.substring(1),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _isLoading || _selectedSign == null
                  ? null
                  : _getDailyPredict,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: _isLoading
                  ? const SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        color: Colors.white,
                      ),
                    )
                  : const Text('Get Prediction'),
            ),
            const SizedBox(height: 24),
            if (_predict != null)
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    _predict!.predict,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ),
            if (_error != null)
              SelectableText(
                _error!,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
          ],
        ),
      ),
    );
  }
}
