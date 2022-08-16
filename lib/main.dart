import 'package:flutter/material.dart';
import 'package:stop_watch/login_screen.dart';
import 'package:stop_watch/stopWatch.dart';

void main() => runApp(const StopwatchApp());

class StopwatchApp extends StatelessWidget {
  const StopwatchApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoginScreen(),
    );
  }
}
