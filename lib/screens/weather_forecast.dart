import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/api_service.dart';
import '../l10n/app_localizations.dart';

class WeatherForecast extends StatelessWidget {
  const WeatherForecast({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final api = Provider.of<ApiService>(context);

    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.weather_forecast)),
      body: FutureBuilder<List<Map<String, String>>>(
        future: api.getWeatherForecast(),
        builder: (context, snapshot) {
          final forecast = snapshot.data ?? api.fallbackWeather;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: forecast.length,
            itemBuilder: (context,index){
              final day = forecast[index];
              return Card(
                color: Colors.lightBlue[50],
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  leading: Icon(Icons.wb_sunny, color: Colors.orange[700]),
                  title: Text("${day['day']}: ${day['condition']}"),
                  subtitle: Text("${AppLocalizations.of(context)!.temp}: ${day['temp']}°C"),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
