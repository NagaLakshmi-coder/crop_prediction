import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

class FarmerDashboard extends StatelessWidget {
  const FarmerDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.farmer_dashboard)),
      body: Center(
        child: Text(
          AppLocalizations.of(context)!.welcome_farmer,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
