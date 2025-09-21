import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int _selectedIndex = 0;

  // Pages for different sections
  final List<Widget> _pages = [
    Center(child: Text("📊 Overview")),
    Center(child: Text("👨‍🌾 Farmers List")),
    Center(child: Text("🌱 Predictions")),
    Center(child: Text("📈 Analytics")),
    Center(child: Text("⬆️ Upload Data")),
    Center(child: Text("📝 Generate Report")),
  ];

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.admin_dashboard),
      ),
      body: _pages[_selectedIndex], // Show selected page
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text("Admin Panel",
                  style: TextStyle(color: Colors.white, fontSize: 20)),
            ),
            _buildDrawerItem(Icons.dashboard, "Overview", 0),
            _buildDrawerItem(Icons.group, "Farmers List", 1),
            _buildDrawerItem(Icons.eco, "Predictions", 2),
            _buildDrawerItem(Icons.analytics, "Analytics", 3),
            _buildDrawerItem(Icons.upload_file, "Upload Data", 4),
            _buildDrawerItem(Icons.description, "Generate Report", 5),
          ],
        ),
      ),
    );
  }

  // Drawer helper
  Widget _buildDrawerItem(IconData icon, String title, int index) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      selected: _selectedIndex == index,
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
        Navigator.pop(context); // close drawer
      },
    );
  }
}

