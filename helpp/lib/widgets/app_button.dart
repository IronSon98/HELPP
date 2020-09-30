import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  String text;
  Function onPressed;

  AppButton(this.text, {this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height:52,
      child: RaisedButton(
        color: Color(0xFF2196F3),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white, 
            fontSize: 18,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32)
        ),
        onPressed: onPressed,
      ),
    );
  }
}