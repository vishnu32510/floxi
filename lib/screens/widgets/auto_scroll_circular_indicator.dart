import 'package:floxi/models/dasboard_model.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class AutoScrollCircularIndicator extends StatefulWidget {
  final DashboardModel dashboardModel;
  const AutoScrollCircularIndicator({super.key, required this.dashboardModel});

  @override
  State<AutoScrollCircularIndicator> createState() => _AutoScrollCircularIndicatorState();
}

class _AutoScrollCircularIndicatorState extends State<AutoScrollCircularIndicator> {
  DashboardModel get dashboardModel => widget.dashboardModel;

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircularPercentIndicator(
          radius: 95.0,
          lineWidth: 13.0,
          animation: true,
          animationDuration: 1000,
          percent: dashboardModel.totalEmissions! / dashboardModel.threshold!,
          circularStrokeCap: CircularStrokeCap.round,
          backgroundColor: Colors.grey[200]!,
          progressColor: Colors.green,
        ),
        Positioned(
          top: 15,
          left: 15,
          child: CircularPercentIndicator(
            radius: 80.0,
            lineWidth: 13.0,
            animation: true,
            animationDuration: 1000,
            percent: dashboardModel.monthlypoints! / dashboardModel.target!,
            center: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${dashboardModel.totalEmissions?.toStringAsFixed(2)}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.green
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  "🪙 ${dashboardModel.monthlypoints}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange
                  ),
                ),
              ],
            ),
            circularStrokeCap: CircularStrokeCap.round,
            backgroundColor: Colors.grey[200]!,
            progressColor: Colors.orange,
          ),
        ),
      ],
    );
  }
}