import 'package:flutter/material.dart';
import 'package:flutter_store_manager/screens/login_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.orange,
      ),
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}