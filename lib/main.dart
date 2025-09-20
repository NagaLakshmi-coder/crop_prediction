import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'screens/welcome_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/home_screen.dart';
import 'screens/admin_dashboard.dart';
import 'screens/farmer_dashboard.dart';
import 'screens/crop_prediction.dart';
import 'screens/weather_forecast.dart';
import 'screens/govt_schemes.dart';
import 'widgets/voice_assistant.dart';
import 'services/auth_service.dart';
import 'services/connectivity_service.dart';
import 'services/hive_service.dart';
import 'services/api_service.dart';
import 'l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        Provider(create: (_) => HiveService()),
        Provider(create: (_) => ConnectivityService()),
        Provider(create: (_) => ApiService()),
      ],
      child: const AiCropApp(),
    ),
  );
}

class AiCropApp extends StatefulWidget {
  const AiCropApp({super.key});

  @override
  _AiCropAppState createState() => _AiCropAppState();
}

class _AiCropAppState extends State<AiCropApp> {
  Locale _selectedLocale = const Locale('en');

  void setLocale(Locale locale) {
    setState(() {
      _selectedLocale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Crop Optimization',
      debugShowCheckedModeBanner: false,
      locale: _selectedLocale,
      supportedLocales: const [
        Locale('en'),
        Locale('hi'),
        Locale('te'),
        Locale('or'),
      ],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(
        primaryColor: Colors.green,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
        ),
      ),
      routes: {
        '/': (context) => WelcomeScreen(
            setLocale: setLocale, selectedLocale: _selectedLocale),
        '/home': (context) => const HomeScreen(),
        '/admin': (context) => const AdminDashboard(),
        '/farmerDashboard': (context) => const FarmerDashboard(),
        '/predict': (context) => const CropPrediction(),
        '/weather': (context) => const WeatherForecast(),
        '/schemes': (context) => const GovtSchemes(),
        '/voice': (context) => const VoiceAssistant(),
        '/login': (context) =>
            LoginScreen(setLocale: setLocale, selectedLocale: _selectedLocale),
        '/register': (context) => RegisterScreen(
            setLocale: setLocale, selectedLocale: _selectedLocale),
      },
      builder: (context, child) {
        // Show floating mic button only on WelcomeScreen and HomeScreen
        final showMic = child is WelcomeScreen || child is HomeScreen;
        if (showMic) {
          return Stack(
            children: [
              child!,
              Positioned(
                bottom: 20,
                right: 20,
                child: FloatingActionButton(
                  backgroundColor: Colors.green,
                  onPressed: () {
                    Navigator.of(context).pushNamed('/voice');
                  },
                  child: const Icon(Icons.mic),
                ),
              ),
            ],
          );
        }
        return child!;
      },
    );
  }
}
