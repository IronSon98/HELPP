import 'package:flutter/material.dart';
import 'package:helpp/pages/login_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main(){

  WidgetsFlutterBinding.ensureInitialized();
  
  Firestore.instance
  .collection("users")
  .document("nome")
  .setData({"Iron": "054.526.571-18"});

  runApp(App());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}