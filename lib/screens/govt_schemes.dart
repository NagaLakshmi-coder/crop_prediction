import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/api_service.dart';
import '../l10n/app_localizations.dart';

class GovtSchemes extends StatelessWidget {
  const GovtSchemes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final api = Provider.of<ApiService>(context);

    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.govt_schemes)),
      body: FutureBuilder<List<Map<String, String>>>(
        future: api.getSchemes(),
        builder: (context, snapshot) {
          final schemes = snapshot.data ?? api.fallbackSchemes;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: schemes.length,
            itemBuilder: (context, index){
              final scheme = schemes[index];
              return Card(
                color: Colors.green[50],
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  title: Text(scheme['name'] ?? '', style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(scheme['description'] ?? ''),
                  trailing: const Icon(Icons.arrow_forward, color: Colors.green),
                  onTap: (){},
                ),
              );
            },
          );
        },
      ),
    );
  }
}
