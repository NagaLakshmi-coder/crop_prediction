import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

class WelcomeScreen extends StatelessWidget {
  final Function(Locale) setLocale;
  final Locale selectedLocale;

  const WelcomeScreen({Key? key, required this.setLocale, required this.selectedLocale}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green, Colors.lightGreen],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "🌾 ${AppLocalizations.of(context)!.welcome_to} Crop Prediction with AI",
                  style: const TextStyle(
                      fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                ElevatedButton.icon(
                  icon: const Icon(Icons.login),
                  label: Text(AppLocalizations.of(context)!.login),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.green,
                      minimumSize: const Size(double.infinity, 50)),
                  onPressed: () => Navigator.pushNamed(context, '/login'),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  icon: const Icon(Icons.app_registration),
                  label: Text(AppLocalizations.of(context)!.register),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.green,
                      minimumSize: const Size(double.infinity, 50)),
                  onPressed: () => Navigator.pushNamed(context, '/register'),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text("Language: ", style: TextStyle(color: Colors.white)),
                    DropdownButton<Locale>(
                      value: selectedLocale,
                      dropdownColor: Colors.green,
                      items: const [
                        DropdownMenuItem(child: Text('English'), value: Locale('en')),
                        DropdownMenuItem(child: Text('Hindi'), value: Locale('hi')),
                        DropdownMenuItem(child: Text('Telugu'), value: Locale('te')),
                        DropdownMenuItem(child: Text('Odia'), value: Locale('or')),
                      ],
                      onChanged: (locale) {
                        if (locale != null) setLocale(locale);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        onPressed: () {
          Navigator.pushNamed(context, '/voice');
        },
        child: const Icon(Icons.mic),
      ),
    );
  }
}
