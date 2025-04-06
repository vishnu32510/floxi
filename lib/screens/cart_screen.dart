import 'dart:developer';

import 'package:floxi/core/services/services.dart';
import 'package:flutter/material.dart';

class CartTab extends StatelessWidget {
  final List<Map<String, dynamic>> miniApps = [
    {
      'icon': Icons.local_offer, // Example icon, replace with relevant one
      'label': 'Too Good To Go',
      'description': 'Save food and reduce waste',
      'route': 'https://play.google.com/store/apps/details?id=com.app.tgtg',
    },
    {
      'icon': Icons.eco, // Example icon for carbon-related apps
      'label': 'Carbon Footprint Calculator',
      'description': 'Calculate your carbon emissions',
      'route': 'https://www.barcodelookup.com/024463061095',
    },
    // Add more mini-apps here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 items per row
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.9, // Adjust to control height/width ratio of cards
          ),
          itemCount: miniApps.length,
          itemBuilder: (context, index) {
            final app = miniApps[index];
            return GestureDetector(
              onTap: () {
                // Optionally, you can open the app's URL or another screen
                // Example: Open a webpage
                OpenLinkService().openUrl(link:app['route']);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Square Container for App Icon and Name
                  Container(
                    width: 80,  // Fixed width to create a square container
                    height: 80, // Fixed height to create a square container
                    decoration: BoxDecoration(
                      color: Colors.green.shade200,  // Background color of the container
                      borderRadius: BorderRadius.circular(12), // Rounded corners
                    ),
                    child: Center(
                      child: Icon(
                        app['icon'], 
                        size: 40,  // Adjust the size of the icon
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    app['label'],
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 4),
                  Text(
                    app['description'],
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
