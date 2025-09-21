import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final fallbackCropData = {
    "crop": "Wheat",
    "yield": "3.5",
    "advice": "Use organic fertilizer and ensure proper irrigation."
  };

  final fallbackSchemes = [
    {"name": "PM-Kisan", "description": "Income support to farmers"},
    {"name": "Soil Health Card", "description": "Improve soil productivity"},
  ];

  final fallbackWeather = [
    {"day": "Monday", "temp": "32", "condition": "Sunny"},
    {"day": "Tuesday", "temp": "30", "condition": "Cloudy"},
    {"day": "Wednesday", "temp": "28", "condition": "Rainy"},
  ];

  Future<Map<String, dynamic>> getCropPrediction() async {
    await Future.delayed(const Duration(seconds: 1));
    return fallbackCropData;
  }

  Future<List<Map<String, String>>> getSchemes() async {
    await Future.delayed(const Duration(seconds: 1));
    return fallbackSchemes;
  }

  // Weather API now requires 'city' and returns current weather
  Future<List<Map<String, String>>> getWeatherForecast({required String city}) async {
    try {
      const apiKey = '99d0cc9e079f2e5cbf325c07ccd32d37'; // Replace with your API key
      final url =
          'https://api.openweathermap.org/data/2.5/weather?q=${Uri.encodeComponent(city)}&appid=$apiKey&units=metric';

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        final condition = data['weather'][0]['main'];
        final temp = (data['main']['temp'] as num).toStringAsFixed(1);

        // Return a single-day forecast list (current day)
        return [
          {
            'day': 'Today',
            'condition': condition,
            'temp': temp,
          }
        ];
      } else {
        // fallback if API fails
        return fallbackWeather;
      }
    } catch (e) {
      return fallbackWeather;
    }
  }

  String _getDayName(int weekday) {
    switch (weekday) {
      case 1:
        return "Monday";
      case 2:
        return "Tuesday";
      case 3:
        return "Wednesday";
      case 4:
        return "Thursday";
      case 5:
        return "Friday";
      case 6:
        return "Saturday";
      case 7:
        return "Sunday";
      default:
        return "";
    }
  }
}
