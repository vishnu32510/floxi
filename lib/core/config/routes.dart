import 'package:floxi/screens/bar_code_screen.dart';
import 'package:floxi/screens/camera_screen.dart';
import 'package:floxi/screens/dashboard.dart';
import 'package:floxi/screens/items_screen.dart';
import 'package:flutter/material.dart';

class CustomRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    debugPrint('Route: ${settings.name}');
    switch (settings.name) {
      case Dashboard.routeName:
        return Dashboard.route();
      case CameraScreen.routeName:
        return CameraScreen.route(settings.arguments as CameraScreen);
      case ItemsScreen.routeName:
        return ItemsScreen.route(settings.arguments as ItemsScreen);
      case BarCodeScreen.routeName:
        return BarCodeScreen.route(settings.arguments as BarCodeScreen);
      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: '/error'),
      builder:
          (context) => Scaffold(appBar: AppBar(title: const Center(child: Text('Error Page')))),
    );
  }
}
