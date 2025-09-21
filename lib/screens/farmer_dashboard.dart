import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import 'welcome_screen.dart'; // Make sure this path is correct

class FarmerDashboard extends StatefulWidget {
  final Function(Locale) setLocale;
  final Locale selectedLocale;

  const FarmerDashboard({
    Key? key,
    required this.setLocale,
    required this.selectedLocale,
  }) : super(key: key);

  @override
  State<FarmerDashboard> createState() => _FarmerDashboardState();
}

class _FarmerDashboardState extends State<FarmerDashboard>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;

  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(
            CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _scaleAnimation = Tween<double>(begin: 0.95, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _animatedCard({required Widget child}) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: ScaleTransition(scale: _scaleAnimation, child: child),
      ),
    );
  }

  List<Widget> _buildPages(AppLocalizations loc) => [
        // ------------------- Main Dashboard -------------------
        SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _animatedCard(
                child: _buildCard(
                  title: "${loc.recommended_crop} 🌾",
                  subtitle: "Check your best crops and yields here.",
                  color: Colors.green,
                  icon: Icons.agriculture,
                ),
              ),
              const SizedBox(height: 20),
              _animatedCard(
                child: _buildCard(
                  title: "Weather Updates ☁️",
                  subtitle: "Stay updated with local weather for crops.",
                  color: Colors.blue,
                  icon: Icons.cloud,
                ),
              ),
              const SizedBox(height: 20),
              _animatedCard(
                child: _buildCard(
                  title: "Reports 📊",
                  subtitle: "View your crop reports and history.",
                  color: Colors.orange,
                  icon: Icons.bar_chart,
                ),
              ),
              const SizedBox(height: 20),
              _animatedCard(
                child: _buildCard(
                  title: "📞 Key Contact Numbers",
                  subtitle:
                      "e-Pest: 0674-6667171\nJoint Director of Agriculture: 0674-2355299\nKrushi Samruddhi / Ama Krushi Helpline: 155333",
                  color: Colors.purple,
                  icon: Icons.contact_phone,
                ),
              ),
            ],
          ),
        ),

        // ------------------- Help Section -------------------
        _buildHelpPage(),

        // ------------------- Reports & History -------------------
        _buildReportsHistoryPage(),

        // ------------------- Logout Placeholder -------------------
        const Center(child: Text("Logout Page 🚪")),
      ];

  Widget _buildCard({
    required String title,
    required String subtitle,
    required Color color,
    required IconData icon,
  }) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      shadowColor: color.withOpacity(0.5),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 40),
            const SizedBox(height: 10),
            Text(title,
                style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold, color: color)),
            const SizedBox(height: 8),
            Text(subtitle, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }

  // ------------------- HELP PAGE -------------------
  Widget _buildHelpPage() {
    final List<Map<String, String>> helpData = [
      {
        "title": "Soil Testing",
        "subtitle": "Learn how to test soil quality for better yield."
      },
      {
        "title": "Pest Control",
        "subtitle": "Get tips on organic and chemical pest control."
      },
      {
        "title": "Crop Rotation",
        "subtitle": "Understand how rotating crops improves soil fertility."
      },
      {
        "title": "Government Schemes",
        "subtitle": "Access latest schemes available for farmers."
      },
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: helpData
            .map((item) => _animatedCard(
                  child: _buildCard(
                    title: item["title"]!,
                    subtitle: item["subtitle"]!,
                    color: Colors.teal,
                    icon: Icons.help_outline,
                  ),
                ))
            .toList(),
      ),
    );
  }

  // ------------------- REPORTS & HISTORY PAGE -------------------
  Widget _buildReportsHistoryPage() {
    final List<Map<String, dynamic>> reports = [
      {
        "title": "Wheat Report",
        "subtitle": "Yield: 2.5 tons, Profit: ₹50,000",
        "icon": Icons.grass
      },
      {
        "title": "Maize Report",
        "subtitle": "Yield: 3 tons, Profit: ₹60,000",
        "icon": Icons.eco
      },
      {
        "title": "Cotton Report",
        "subtitle": "Yield: 1.5 tons, Profit: ₹75,000",
        "icon": Icons.agriculture
      },
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: reports
            .map((item) => _animatedCard(
                  child: _buildCard(
                    title: item["title"] as String,
                    subtitle: item["subtitle"] as String,
                    color: Colors.deepOrange,
                    icon: item["icon"] as IconData,
                  ),
                ))
            .toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.farmer_dashboard),
      ),
      body: _buildPages(loc)[_selectedIndex],
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
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text("Logout"),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WelcomeScreen(
                      setLocale: widget.setLocale,
                      selectedLocale: widget.selectedLocale,
                    ),
                  ),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, int index) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      selected: _selectedIndex == index,
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
        Navigator.pop(context);
      },
    );
  }
}
