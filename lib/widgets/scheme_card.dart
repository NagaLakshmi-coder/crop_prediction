import 'package:flutter/material.dart';

class SchemeCard extends StatelessWidget {
  final String title;
  final String description;
  final String iconPath;

  const SchemeCard({required this.title, required this.description, required this.iconPath});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.asset(iconPath, width: 48, height: 48, fit: BoxFit.contain),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(description),
        trailing: Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          showDialog(context: context, builder: (_) => AlertDialog(title: Text(title), content: Text(description), actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text('Close'))]));
        },
      ),
    );
  }
}
