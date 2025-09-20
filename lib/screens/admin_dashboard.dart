import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(loc.admin_dashboard)),
      body: Center(
        child: Text(
          AppLocalizations.of(context)!.welcome_admin,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
