import 'package:flutter/material.dart';
import 'package:helpp/pages/login_page.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF2196F3),
      ),
      home: LoginPage(),
    );
  }
}