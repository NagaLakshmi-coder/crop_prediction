import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/api_service.dart';
import '../l10n/app_localizations.dart';

class CropPrediction extends StatelessWidget {
  const CropPrediction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final api = Provider.of<ApiService>(context);

    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.crop_prediction)),
      body: FutureBuilder<Map<String, dynamic>>(
        future: api.getCropPrediction(),
        builder: (context, snapshot) {
          if(snapshot.connectionState==ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator());
          }
          if(snapshot.hasError){
            return Center(child: Text(AppLocalizations.of(context)!.error_fetching_data));
          }

          final data = snapshot.data ?? api.fallbackCropData;

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${AppLocalizations.of(context)!.recommended_crop}: ${data['crop']}", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Text("${AppLocalizations.of(context)!.expected_yield}: ${data['yield']} tons/hectare", style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 10),
                Text("${AppLocalizations.of(context)!.advice}: ${data['advice']}", style: const TextStyle(fontSize: 16)),
              ],
            ),
          );
        },
      ),
    );
  }
}
