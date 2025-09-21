import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fl_chart/fl_chart.dart'; // for pie chart
import '../l10n/app_localizations.dart';
import 'welcome_screen.dart'; // Make sure this path is correct

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int _selectedIndex = 0;

  // List to store uploaded files
  List<String> uploadedFiles = [];

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    final List<Widget> _pages = [
      // 0 - Overview (full functional)
      const _OverviewPage(),

      // 1 - Farmers List
      const _FarmersListPage(),

      // 2 - Predictions
      _buildPredictions(),

      // 3 - Analytics
      _buildAnalytics(),

      // 4 - Upload Data
      _buildUploadData(),

      // 5 - Generate Report
      _buildGenerateReport(),
    ];

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
            _buildDrawerItem(Icons.exit_to_app, "Exit", 6),
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

        // Handle Exit button
        if (index == 6) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => WelcomeScreen(
                setLocale: (locale) {}, // empty function as placeholder
                selectedLocale: const Locale('en'),
              ),
            ),
            (route) => false,
          );
        } else {
          Navigator.pop(context); // close drawer for other pages
        }
      },
    );
  }

  /// ------------------ Predictions Page ------------------
  Widget _buildPredictions() {
    final predictions = [
      {"crop": "Paddy", "season": "Kharif", "soil": "Clayey", "weather": "Humid"},
      {"crop": "Wheat", "season": "Rabi", "soil": "Loamy", "weather": "Cool"},
      {"crop": "Maize", "season": "Zaid", "soil": "Sandy loam", "weather": "Warm"},
      {"crop": "Cotton", "season": "Kharif", "soil": "Silty", "weather": "Hot"},
      {"crop": "Groundnut", "season": "Rabi", "soil": "Loamy", "weather": "Dry"},
    ];

    return ListView(
      children: predictions
          .map((p) => Card(
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  leading: const Icon(Icons.eco, color: Colors.orange),
                  title: Text("${p["crop"]} - ${p["season"]}"),
                  subtitle: Text("Soil: ${p["soil"]}, Weather: ${p["weather"]}"),
                ),
              ))
          .toList(),
    );
  }

  /// ------------------ Analytics Page ------------------
  Widget _buildAnalytics() {
    return ListView(
      children: const [
        Card(
          margin: EdgeInsets.all(8),
          child: ListTile(
            leading: Icon(Icons.bar_chart, color: Colors.blue),
            title: Text("Most Profitable Crop: Cotton"),
            subtitle: Text("High demand in market with maximum profits."),
          ),
        ),
        Card(
          margin: EdgeInsets.all(8),
          child: ListTile(
            leading: Icon(Icons.show_chart, color: Colors.green),
            title: Text("Top Grown Crops Across India"),
            subtitle: Text("Paddy, Wheat, Maize are most widely cultivated."),
          ),
        ),
        Card(
          margin: EdgeInsets.all(8),
          child: ListTile(
            leading: Icon(Icons.people, color: Colors.purple),
            title: Text("Farmer Analytics"),
            subtitle: Text("70% farmers grow seasonal crops, 30% cash crops."),
          ),
        ),
      ],
    );
  }

  /// ------------------ Upload Data Page ------------------
  Widget _buildUploadData() {
    return Column(
      children: [
        const SizedBox(height: 16),
        ElevatedButton.icon(
          icon: const Icon(Icons.upload_file),
          label: const Text("Upload File"),
          onPressed: () async {
            FilePickerResult? result =
                await FilePicker.platform.pickFiles(allowMultiple: true);

            if (result != null) {
              setState(() {
                uploadedFiles
                    .addAll(result.files.map((file) => file.name).toList());
              });
            }
          },
        ),
        const SizedBox(height: 16),
        Expanded(
          child: uploadedFiles.isEmpty
              ? const Center(child: Text("No files uploaded yet"))
              : ListView.builder(
                  itemCount: uploadedFiles.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const Icon(Icons.insert_drive_file),
                      title: Text(uploadedFiles[index]),
                    );
                  },
                ),
        ),
      ],
    );
  }

  /// ------------------ Generate Report Page ------------------
  Widget _buildGenerateReport() {
    return ListView(
      children: const [
        Card(
          margin: EdgeInsets.all(8),
          child: ListTile(
            leading: Icon(Icons.article, color: Colors.teal),
            title: Text("Generated Report"),
            subtitle: Text("Farmers cultivated 5 major crops with good yields."),
          ),
        ),
        Card(
          margin: EdgeInsets.all(8),
          child: ListTile(
            leading: Icon(Icons.check_circle, color: Colors.green),
            title: Text("Result Summary"),
            subtitle: Text(
                "Cotton and Paddy gave maximum profits, recommended for next season."),
          ),
        ),
      ],
    );
  }
}

/// ------------------ Farmers List Page ------------------
class _FarmersListPage extends StatelessWidget {
  const _FarmersListPage();

  final List<Map<String, String>> farmers = const [
    {"name": "Ravi Kumar", "village": "Guntur", "season": "Kharif", "crop": "Paddy"},
    {"name": "Sita Reddy", "village": "Nellore", "season": "Rabi", "crop": "Maize"},
    {"name": "Mahesh", "village": "Warangal", "season": "Zaid", "crop": "Cotton"},
    {"name": "Lakshmi", "village": "Anantapur", "season": "Kharif", "crop": "Groundnut"},
    {"name": "Arjun", "village": "Khammam", "season": "Rabi", "crop": "Chillies"},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: farmers.length,
      itemBuilder: (context, index) {
        final farmer = farmers[index];
        return Card(
          margin: const EdgeInsets.all(8),
          child: ListTile(
            leading: const Icon(Icons.person, color: Colors.green),
            title: Text(farmer["name"] ?? ""),
            subtitle: Text(
                "Village: ${farmer["village"]}, Season: ${farmer["season"]}, Crop: ${farmer["crop"]}"),
          ),
        );
      },
    );
  }
}

/// ------------------ Overview Page ------------------
class _OverviewPage extends StatelessWidget {
  const _OverviewPage();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("📊 Admin Overview",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),

          // Top Stats Cards
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatCard("👥 Total Users", "1,250", Colors.blue),
              _buildStatCard("🌱 Predictions", "340", Colors.green),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatCard("📑 Schemes", "15 Active", Colors.orange),
              _buildStatCard("⚠️ Alerts", "2 Issues", Colors.red),
            ],
          ),
          const SizedBox(height: 24),

          // Pie Chart Example: User Roles
          const Text("👥 User Distribution",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 200, child: _UserPieChart()),

          const SizedBox(height: 24),

          // Recent Predictions Table
          const Text("🌱 Recent Predictions",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          DataTable(
            columns: const [
              DataColumn(label: Text("Farmer")),
              DataColumn(label: Text("Crop")),
              DataColumn(label: Text("Date")),
            ],
            rows: const [
              DataRow(cells: [
                DataCell(Text("Ravi")),
                DataCell(Text("Wheat")),
                DataCell(Text("21 Sept")),
              ]),
              DataRow(cells: [
                DataCell(Text("Sita")),
                DataCell(Text("Rice")),
                DataCell(Text("20 Sept")),
              ]),
              DataRow(cells: [
                DataCell(Text("Anil")),
                DataCell(Text("Maize")),
                DataCell(Text("19 Sept")),
              ]),
            ],
          ),
          const SizedBox(height: 24),

          // Quick Actions
          const Text("⚡ Quick Actions",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              ElevatedButton.icon(
                icon: const Icon(Icons.person_add),
                label: const Text("Add User"),
                onPressed: () {},
              ),
              ElevatedButton.icon(
                icon: const Icon(Icons.campaign),
                label: const Text("Send Alert"),
                onPressed: () {},
              ),
              ElevatedButton.icon(
                icon: const Icon(Icons.download),
                label: const Text("Export Data"),
                onPressed: () {},
              ),
            ],
          )
        ],
      ),
    );
  }

  // Stat card helper
  Widget _buildStatCard(String title, String value, Color color) {
    return Expanded(
      child: Card(
        color: color.withOpacity(0.1),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(title,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
              const SizedBox(height: 8),
              Text(value,
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold, color: color)),
            ],
          ),
        ),
      ),
    );
  }
}

// Pie Chart Widget
class _UserPieChart extends StatelessWidget {
  const _UserPieChart();

  @override
  Widget build(BuildContext context) {
    return PieChart(
      PieChartData(
        sections: [
          PieChartSectionData(value: 60, color: Colors.blue, title: "Farmers"),
          PieChartSectionData(value: 30, color: Colors.green, title: "Admins"),
          PieChartSectionData(value: 10, color: Colors.orange, title: "Experts"),
        ],
      ),
    );
  }
}
