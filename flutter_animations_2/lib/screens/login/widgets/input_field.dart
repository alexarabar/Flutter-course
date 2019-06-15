import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String hint;
  final bool obscure;
  final IconData icon;

  InputField({this.hint, this.obscure, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.white24,
            width: 0.6,
          ),
        )
      ),
      child: TextFormField(
        obscureText: obscure,
        style: TextStyle(
          color: Colors.white,
        ),
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: Colors.white,
          ),
          border: InputBorder.none,
          hintText: hint,
          hintStyle: TextStyle(
            color: Colors.white,
            fontSize: 15,
          ),
          contentPadding: EdgeInsets.only(
            left:    5,
            top:    30,
            right:  30,
            bottom: 30,
          ),
        ),
      ),
    );
  }
}
