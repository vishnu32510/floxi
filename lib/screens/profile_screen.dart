import 'package:floxi/models/dasboard_model.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final DashboardModel dashboardModel;
  const ProfileScreen({super.key, required this.dashboardModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Profile Picture
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/profile.jpg'), // Add your image path
              backgroundColor: Colors.grey.shade300,
            ),
            const SizedBox(height: 12),
            Text(
              "${dashboardModel.username}",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text(
              "Eco Warrior 🌱",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("EcoPoints", style: TextStyle(fontSize: 18)),
                    Text("🪙 ${dashboardModel.totalPoints ??""}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Activity List
            Align(
              alignment: Alignment.centerLeft,
              child: Text("Recent Activity", style: Theme.of(context).textTheme.titleMedium),
            ),
            const SizedBox(height: 12),
            ...[
              "♻️ Recycled 2kg plastic",
              "🚶 Walked 3km instead of driving",
              "🍃 Bought eco-friendly groceries",
            ].map((activity) => ListTile(
              leading: const Icon(Icons.check_circle_outline, color: Colors.green),
              title: Text(activity),
            )),
            const SizedBox(height: 20),

            // Sign Out button
            OutlinedButton.icon(
              onPressed: () {
                // TODO: Sign out logic
              },
              icon: const Icon(Icons.logout),
              label: const Text("Sign Out"),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.red,
                side: const BorderSide(color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
