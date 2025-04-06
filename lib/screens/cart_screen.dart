import 'dart:developer';

import 'package:floxi/core/services/services.dart';
import 'package:flutter/material.dart';

class CartTab extends StatelessWidget {
  final List<Map<String, dynamic>> miniApps = [
    {
      'label': 'Too Good To Go',
      'description': '🪙 100 per \$1',
      'route': 'https://play.google.com/store/apps/details?id=com.app.tgtg',
      'image': 'assets/images/tgtg.png',
    },
    {
      'label': 'Ventra',
      'description': '🪙 50 per \$5',
      'route': 'https://www.ventrachicago.com/',
      'image': 'assets/images/ventra.png',
      
    },
    {
      'label': 'Missfits Market',
      'description': '🪙 200 per \$10',
      'route': 'https://www.misfitsmarket.com/?srsltid=AfmBOoqZTjl4BOtZEJsQQ3OO8CB7Aeoy2yJ029HoP2WQvKEr7FZJ_5ay',
      'image': 'assets/images/missfits.png',
      
    },
    {
      'label': 'Divvy',
      'description': '🪙 3000 per \$1',
      'route': 'https://divvybikes.com/',
      'image': 'assets/images/divvy.png',
      
    },
    // Add more mini-apps here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Text(
                    "Shop and Earn",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Expanded(child: SizedBox(),),
                  IconButton(
                    icon: const Icon(Icons.arrow_circle_right_outlined),
                    onPressed: () {
                    },
                  ),
                ],
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              primary: false,
              physics: const NeverScrollableScrollPhysics(), // Disable scrolling
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2 items per row
                crossAxisSpacing: 5,
                mainAxisSpacing: 0,
                // childAspectRatio: 0.9, // Adjust to control height/width ratio of cards
              ),
              itemCount: miniApps.length,
              itemBuilder: (context, index) {
                final app = miniApps[index];
                return GestureDetector(
                  onTap: () {
                    // Optionally, you can open the app's URL or another screen
                    // Example: Open a webpage
                    OpenLinkService().openUrl(link: app['route']);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Square Container for App Icon and Name
                      CircleAvatar(
                        radius: 30, // Half of the width and height to make it a perfect circle
                        backgroundColor: Colors.green.shade200, // Background color of the circle
                        backgroundImage: AssetImage(app['image']), // Image inside the circle
                        // child: Image.asset(
                        //   app['image'],
                        //   // size: 25, // Adjust the size of the icon
                        //   // color: Colors.white,
                        // ),
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
         Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Start Offsetting",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Donate to earn EcoCoins",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "You can donate to earn EcoCoins. The more you donate, the more EcoCoins you earn.",
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            TextButton(onPressed: (){
              OpenLinkService().openUrl(link: "https://purposeontheplanet.org/?give=8NDR96EK");
            }, child: Container(
              padding: const EdgeInsets.all(16),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: const Text(
                "Donate",
                style: TextStyle(color: Colors.white, fontSize: 16),textAlign: TextAlign.center,
              ),
            )),
          ],
        ),
      ),
    );
  }
}
