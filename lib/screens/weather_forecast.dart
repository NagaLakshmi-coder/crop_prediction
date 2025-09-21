import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/api_service.dart';
import '../l10n/app_localizations.dart';

class WeatherForecast extends StatefulWidget {
  const WeatherForecast({Key? key}) : super(key: key);

  @override
  State<WeatherForecast> createState() => _WeatherForecastState();
}

class _WeatherForecastState extends State<WeatherForecast> {
  final TextEditingController _cityController = TextEditingController();
  List<Map<String, String>>? _forecast;
  bool _loading = false;
  String? _error;

  void _getWeather(String city) async {
    setState(() {
      _loading = true;
      _error = null;
    });

    final api = Provider.of<ApiService>(context, listen: false);
    try {
      final data = await api.getWeatherForecast(city: city);
      setState(() {
        _forecast = data;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = "Failed to fetch weather for $city";
        _forecast = null;
        _loading = false;
      });
    }
  }

  @override
  void dispose() {
    _cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(loc.weather_forecast)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _cityController,
              decoration: InputDecoration(
                labelText: "Enter city",
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                final city = _cityController.text.trim();
                if (city.isNotEmpty) _getWeather(city);
              },
              child: const Text("Get Weather"),
            ),
            const SizedBox(height: 16),
            if (_loading) const CircularProgressIndicator(),
            if (_error != null)
              Text(_error!, style: const TextStyle(color: Colors.red)),
            if (_forecast != null)
              Expanded(
                child: ListView.builder(
                  itemCount: _forecast!.length,
                  itemBuilder: (context, index) {
                    final day = _forecast![index];
                    return Card(
                      color: Colors.lightBlue[50],
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        leading: Icon(Icons.wb_sunny, color: Colors.orange[700]),
                        title: Text("${day['day']}: ${day['condition']}"),
                        subtitle: Text("${loc.temp}: ${day['temp']}°C"),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
