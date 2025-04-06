import 'package:floxi/models/dasboard_model.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class WalletScreen extends StatelessWidget {
  final DashboardModel dashboardModel;

  const WalletScreen({super.key, required this.dashboardModel});

  @override
  Widget build(BuildContext context) {
    final categories = [
      {'icon': Icons.directions_bike, 'label': 'Transport'},
      {'icon': Icons.shopping_bag, 'label': 'Shopping'},
      {'icon': Icons.recycling, 'label': 'Recycling'},
      {'icon': Icons.fastfood, 'label': 'Food'},
      {'icon': Icons.energy_savings_leaf, 'label': 'Energy'},
      {'icon': Icons.water_drop, 'label': 'Water'},
    ];

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Column(
          children: [
            // Wallet Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.green.shade100,
                boxShadow: [
                  BoxShadow(
                    color: Colors.green.shade200.withOpacity(0.4),
                    offset: const Offset(0, 6),
                    blurRadius: 12,
                  ),
                ],
              ),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("EcoPoints Balance", style: TextStyle(fontSize: 18, color: Colors.black54)),
                  SizedBox(height: 10),
                  Text("🪙 ${dashboardModel.totalPoints ??""}", style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const SizedBox(height: 30),
        
            // Bar Chart
            Align(
              alignment: Alignment.centerLeft,
              child: Text("Monthly EcoPoints", style: Theme.of(context).textTheme.titleMedium),
            ),
            const SizedBox(height: 20),
            const SizedBox(height: 180, child: MonthlyBarChart()),
            const SizedBox(height: 20),
            SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Past Earned EcoPoints",
                      style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 20),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Pridicted EcoPoints",
                      style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 20),
        
            Align(
              alignment: Alignment.centerLeft,
              child: Text("Ways to offset your Carbon emission", style: Theme.of(context).textTheme.titleMedium),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.only(top: 8),
                itemCount: categories.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return Container(
                    width: 100, // Fixed width for square container
                    height: 100, // Fixed height for square container
                    decoration: BoxDecoration(
                      color: Colors.white, // Background color of square
                      borderRadius: BorderRadius.circular(10), // Optional: rounded corners
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3), // Shadow position
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(
                          radius: 28,
                          backgroundColor: Colors.green.shade200,
                          child: Icon(category['icon'] as IconData, size: 28, color: Colors.white),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          category['label'] as String,
                          style: const TextStyle(fontSize: 14),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MonthlyBarChart extends StatelessWidget {
  const MonthlyBarChart({super.key});

  List<BarChartGroupData> generateBarChartData(List<double> values) {
    List<BarChartGroupData> barChartData = [];

    for (int i = 0; i < values.length; i++) {
      barChartData.add(
        BarChartGroupData(
          x: i, // x-axis value is the index
          barRods: [
            BarChartRodData(
              toY: values[i], // y-axis value from the list
              width: 25,
              borderRadius: BorderRadius.circular(5),
              gradient: LinearGradient(
                colors: i == values.length - 1?[Colors.orange.shade800, Colors.orange.shade400]:[Colors.green.shade800, Colors.green.shade400],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ],
        ),
      );
    }

    return barChartData;
  }

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: 500,
        barTouchData: BarTouchData(
          enabled: true,
          touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.grey[200],
            tooltipPadding: EdgeInsets.all(5),
            tooltipRoundedRadius: 7,
          ),
        ),
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (double value, _) {
                final months = ['Dec','Jan', 'Feb', 'Mar', 'Apr', 'May',];
                return Text(months[value.toInt() % months.length]);
              },
            ),
          ),
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(show: false),
        barGroups: generateBarChartData([300, 300, 300, 500, 200, 350]),
      ),
    );
  }
}
