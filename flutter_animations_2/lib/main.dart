import 'package:flutter/material.dart';
import 'package:flutter_animations_2/screens/home/home_screen.dart';
import 'package:flutter_animations_2/screens/login/login_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login animated',
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
