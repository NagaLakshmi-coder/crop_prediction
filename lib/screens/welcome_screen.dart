import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

class WelcomeScreen extends StatelessWidget {
  final Function(Locale) setLocale;
  final Locale selectedLocale;

  const WelcomeScreen({
    Key? key,
    required this.setLocale,
    required this.selectedLocale,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.green, Colors.lightGreen],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),

                // Top Row: Logo + Mic
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.eco, color: Colors.white, size: 32),
                        SizedBox(width: 10),
                        Text(
                          "OutCast",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    // Mic button integrated in top row
                    IconButton(
                      onPressed: () => Navigator.pushNamed(context, '/voice'),
                      icon: const Icon(Icons.mic, color: Colors.white, size: 28),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // AI Badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade100,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    "🚀 Powered by AI & Machine Learning",
                    style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
                  ),
                ),

                const SizedBox(height: 20),

                // Headline
                const Text(
                  "Smart Farming Made Simple",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 20),

                // Description
                const Text(
                  "Optimize your crop yields with AI-powered predictions, "
                  "real-time weather data, and government scheme recommendations. "
                  "Join thousands of farmers increasing their productivity by 30%.",
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                ),

                const SizedBox(height: 30),

                // 🌟 Tagline
                const Center(
                  child: Text(
                    "Start Farming Smart →",
                    style: TextStyle(
                      fontSize: 20,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                // Login button
                ElevatedButton.icon(
                  icon: const Icon(Icons.login),
                  label: Text(loc.login),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.green,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  onPressed: () => Navigator.pushNamed(context, '/login'),
                ),

                const SizedBox(height: 20),

                // Register button
                ElevatedButton.icon(
                  icon: const Icon(Icons.app_registration),
                  label: Text(loc.register),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.green,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  onPressed: () => Navigator.pushNamed(context, '/register'),
                ),

                const SizedBox(height: 30),

                // Language dropdown
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
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
