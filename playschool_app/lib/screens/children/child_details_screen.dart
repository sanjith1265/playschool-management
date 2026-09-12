import 'package:flutter/material.dart';
import '../../models/child.dart';
import 'edit_child_screen.dart';

class ChildDetailsScreen extends StatelessWidget {
  final Child child;

  const ChildDetailsScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(child.name),

        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () async {
              final updated = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => EditChildScreen(child: child),
                ),
              );

              if (updated == true && context.mounted) {
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),

      body: Padding(
  padding: const EdgeInsets.all(16),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Name: ${child.name}",
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),

      const SizedBox(height: 12),

      Text("Date of Birth: ${child.dateOfBirth}"),

      const SizedBox(height: 8),

      Text("Gender: ${child.gender}"),

      const SizedBox(height: 8),

      Text("Father: ${child.fatherName}"),

      const SizedBox(height: 8),

      Text("Mother: ${child.motherName}"),

      const SizedBox(height: 8),

      Text("Phone: ${child.parentPhone}"),

      const SizedBox(height: 8),

      Text("Address: ${child.address}"),

      const SizedBox(height: 8),

      Text("Monthly Fee: ₹${child.monthlyFee}"),
    ],
  ),
),
    );
  }
}
