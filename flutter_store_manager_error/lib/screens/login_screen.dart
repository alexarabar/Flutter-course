import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.grey[850],
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(16),
          child: Column (
            children: <Widget>[
              Icon(
                  Icons.store,
                  color:Colors.deepOrangeAccent,
                  size: 160
              ),
            ],
          )
        )
      )
    );
  }
}
