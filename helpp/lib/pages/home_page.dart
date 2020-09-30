import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center (
          child: Text(
            "HELPP",
            textAlign: TextAlign.center),
        )
      ),
      body: _body(),
    );
  }

  _body() {
    return Center(
      child: Text (
        "Página Inicial",
        style: TextStyle(
          fontSize: 22,
        ),
      ),
    );
  }
}