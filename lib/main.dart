import 'package:flutter/material.dart';
import '../screens/intro.dart';
import '../screens/dashboard.dart';

void main() {
  runApp(GlobeApp());
}

class GlobeApp extends StatelessWidget {
  const GlobeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.indigo),
      routes: {
        '/': (context) => IntroScreen(),
        '/dashboard': (context) => DashboardScreen(),
      },
      initialRoute: '/',
    );
  }
}
