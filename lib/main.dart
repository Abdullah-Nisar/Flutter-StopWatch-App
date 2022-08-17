import 'package:flutter/material.dart';
import 'package:stop_watch/login.dart';
import 'package:stop_watch/stopWatch.dart';

void main() => runApp(const StopwatchApp());

class StopwatchApp extends StatelessWidget {
  const StopwatchApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        LoginScreen.route: (context) => LoginScreen(),
        StopWatch.route: (context) => StopwatchApp(),
      },
      // home: LoginScreen(),
    );
  }
}
