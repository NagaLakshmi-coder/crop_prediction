import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/api_service.dart';
import '../l10n/app_localizations.dart';

class CropPrediction extends StatefulWidget {
  const CropPrediction({Key? key}) : super(key: key);

  @override
  _CropPredictionState createState() => _CropPredictionState();
}

class _CropPredictionState extends State<CropPrediction> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Animated Card with stagger
  Widget _animatedCard({required Widget child, required int index}) {
    final delay = Duration(milliseconds: 300 * index);

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        double animationValue = (_controller.value - (index * 0.15)).clamp(0.0, 1.0);
        return Opacity(
          opacity: animationValue,
          child: Transform.translate(
            offset: Offset(0, 50 * (1 - animationValue)),
            child: Transform.scale(
              scale: 0.95 + 0.05 * animationValue,
              child: child,
            ),
          ),
        );
      },
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        shadowColor: Colors.greenAccent.withOpacity(0.5),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final api = Provider.of<ApiService>(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.crop_prediction),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFB2F7EF), Color(0xFF6BE7C1)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: FutureBuilder<Map<String, dynamic>>(
          future: api.getCropPrediction(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  strokeWidth: 4,
                ),
              );
            }

            if (snapshot.hasError) {
              return Center(
                child: Text(
                  AppLocalizations.of(context)!.error_fetching_data,
                  style: const TextStyle(fontSize: 18, color: Colors.redAccent),
                ),
              );
            }

            final data = snapshot.data ?? api.fallbackCropData;

            final cards = [
              _animatedCard(
                index: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.agriculture, color: Colors.green, size: 40),
                    const SizedBox(height: 10),
                    Text(
                      "${AppLocalizations.of(context)!.recommended_crop}: ${data['crop']}",
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "${AppLocalizations.of(context)!.expected_yield}: ${data['yield']} tons/hectare",
                      style: const TextStyle(fontSize: 18, color: Colors.black87),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "${AppLocalizations.of(context)!.advice}: ${data['advice']}",
                      style: const TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                  ],
                ),
              ),
              _animatedCard(
                index: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.show_chart, color: Colors.orange, size: 40),
                    const SizedBox(height: 10),
                    Text(
                      "Growth Tips",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold, color: Colors.orange),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Water regularly and use natural fertilizers for best yield.",
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                  ],
                ),
              ),
              _animatedCard(
                index: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.info, color: Colors.blue, size: 40),
                    const SizedBox(height: 10),
                    Text(
                      "Additional Info",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Monitor weather updates regularly to adjust your crop care schedule.",
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                  ],
                ),
              ),
            ];

            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ...cards.expand((c) => [c, const SizedBox(height: 20)]),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
