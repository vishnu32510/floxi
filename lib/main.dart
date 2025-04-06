import 'package:floxi/bloc_observer.dart';
import 'package:floxi/core/config/routes.dart';
import 'package:floxi/core/utils/app_constants.dart';
import 'package:floxi/modules/theme/theme.dart';
import 'package:floxi/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();

  runApp(const ThemeWrapper(child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return MaterialApp(
          navigatorKey: _navigatorKey,
          title: AppConstants.appTitle,
          theme: state.themeData,
          themeAnimationCurve: Curves.easeIn,
          themeAnimationDuration: const Duration(milliseconds: 500),
          themeMode: ThemeMode.system,
          darkTheme: DarkThemeState.darkTheme.themeData,
          home: const Dashboard(),
          debugShowCheckedModeBanner: false,
          onGenerateRoute: CustomRouter.onGenerateRoute,
          initialRoute: Dashboard.routeName,
        );
      },
    );
  }
}
