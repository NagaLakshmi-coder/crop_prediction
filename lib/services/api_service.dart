class ApiService {
  final fallbackCropData = {
    "crop": "Wheat",
    "yield": "3.5",
    "advice": "Use organic fertilizer and ensure proper irrigation."
  };

  final fallbackSchemes = [
    {"name":"PM-Kisan","description":"Income support to farmers"},
    {"name":"Soil Health Card","description":"Improve soil productivity"},
  ];

  final fallbackWeather = [
    {"day":"Monday","temp":"32","condition":"Sunny"},
    {"day":"Tuesday","temp":"30","condition":"Cloudy"},
    {"day":"Wednesday","temp":"28","condition":"Rainy"},
  ];

  Future<Map<String,dynamic>> getCropPrediction() async {
    // TODO: Replace with real API call
    await Future.delayed(const Duration(seconds: 1));
    return fallbackCropData;
  }

  Future<List<Map<String,String>>> getSchemes() async {
    await Future.delayed(const Duration(seconds: 1));
    return fallbackSchemes;
  }

  Future<List<Map<String,String>>> getWeatherForecast() async {
    await Future.delayed(const Duration(seconds: 1));
    return fallbackWeather;
  }
}
