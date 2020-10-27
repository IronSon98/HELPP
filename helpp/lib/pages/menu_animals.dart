import 'package:flutter/material.dart';
import 'package:helpp/pages/adoption_animals.dart';
import 'package:helpp/widgets/app_button.dart';
import 'package:helpp/utils/nav.dart';
import 'package:helpp/pages/adoption_page_one.dart';
import 'package:helpp/pages/complaint_page_one.dart';

class MenuAnimals extends StatefulWidget {
  @override
  _MenuAnimalsState createState() => _MenuAnimalsState();
}

class _MenuAnimalsState extends State<MenuAnimals> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ANIMAIS"),
        centerTitle: true,
      ),
      body: _body(),
    );
  }

  _body() {
    return Form(
      key: _formKey,
      child: Container (
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView ( 
          child: Row (
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: GestureDetector(
                  onTap: () {
                    push(context, AdoptionAnimals());
                  },
                  child: CircleAvatar(
                    backgroundColor: Color(0xFF2196F3),
                    radius: 50,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                      Icon(
                        Icons.list,
                        size: 40,
                        color: Color(0xFFFFFFFF),
                      ),
                      Text(
                        "Adoção",
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                        ),
                      )
                    ],),
                  ),
                ),
              ),

              SizedBox(height: 12,),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: GestureDetector(
                  onTap: () {
                    push(context, ComplaintPageOne());
                  },
                  child: CircleAvatar(
                    backgroundColor: Color(0xFF2196F3),
                    radius: 50,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                      Icon(
                        Icons.report,
                        size: 40,
                        color: Color(0xFFFFFFFF),
                      ),
                      Text(
                        "Denúncia",
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                        ),
                      )
                    ],),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}