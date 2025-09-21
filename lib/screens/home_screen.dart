import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';
import '../services/auth_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use Consumer to reactively get the userRole
    return Consumer<AuthService>(
      builder: (context, auth, _) {
        final String? userRole = auth.userRole;

        return Scaffold(
          appBar: AppBar(title: Text(AppLocalizations.of(context)!.home)),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.0,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              children: [
                // Always visible tiles
                _DashboardTile(
                  title: AppLocalizations.of(context)!.crop_prediction,
                  icon: Icons.agriculture,
                  onTap: () => Navigator.pushNamed(context, '/predict'),
                ),
                _DashboardTile(
                  title: AppLocalizations.of(context)!.weather_forecast,
                  icon: Icons.cloud,
                  onTap: () => Navigator.pushNamed(context, '/weather'),
                ),
                _DashboardTile(
                  title: AppLocalizations.of(context)!.govt_schemes,
                  icon: Icons.card_giftcard,
                  onTap: () => Navigator.pushNamed(context, '/schemes'),
                ),
                _DashboardTile(
                    title: AppLocalizations.of(context)!.farmer_dashboard,
                    icon: Icons.dashboard,
                    onTap: () =>
                        Navigator.pushNamed(context, '/farmerDashboard'),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _DashboardTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const _DashboardTile({
    Key? key,
    required this.title,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.green[50],
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: Colors.green),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
