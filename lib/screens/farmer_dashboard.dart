import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

class FarmerDashboard extends StatefulWidget {
  const FarmerDashboard({Key? key}) : super(key: key);

  @override
  State<FarmerDashboard> createState() => _FarmerDashboardState();
}

class _FarmerDashboardState extends State<FarmerDashboard> {
  int _selectedIndex = 0;

  // Pages for farmer features
  final List<Widget> _pages = const [
    Center(child: Text("🌱 hello,user")),
    Center(child: Text("☁️ Contacts")),
    Center(child: Text("📊 My Reports Page")),
    Center(child: Text("🚪 Logout Page")),
  ];

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.farmer_dashboard),
      ),
      body: _pages[_selectedIndex],
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.green),
              child: Text("Farmer Panel",
                  style: TextStyle(color: Colors.white, fontSize: 20)),
            ),
            _buildDrawerItem(Icons.eco, "Farmer Profile", 0),
            _buildDrawerItem(Icons.cloud, "Help", 1),
            _buildDrawerItem(Icons.bar_chart, "Reports and History", 2),
             _buildDrawerItem(Icons.article, "Logout", 3),
          ],
        ),
      ),
    );
  }

  // Drawer menu helper
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
