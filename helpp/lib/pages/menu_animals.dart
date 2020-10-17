import 'package:flutter/material.dart';
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
        title: Text("HELPP"),
        centerTitle: true,
      ),
      body: _body(),
    );
  }

  _body() {
    return Form(
      key: _formKey,
      child: Container (
        decoration: BoxDecoration(color: Color(0xFFFFFFFF)),
        padding: EdgeInsets.all(16),
        child: Center (
          child: SingleChildScrollView ( 
            child: Column (
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[

                Padding(
                  padding: EdgeInsets.only(bottom: 32),
                  child: Image.asset(
                    "imagens/logo_animais2.JPG", 
                    width: 240, 
                    height: 240,
                  ),
                ),

                AppButton(
                  "ANUNCIAR ADOÇÃO", 
                  onPressed: _onAnnounceAdoption,
                ),

                SizedBox(height: 12,),

                AppButton(
                  "ADOTAR ANIMAL",
                  onPressed: _onAdoption,
                ),

                SizedBox(height: 12,),

                AppButton(
                  "DENUNCIAR MAUS TRATOS",
                  onPressed: _onComplaint,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onAnnounceAdoption() async {
    bool formOk = _formKey.currentState.validate();
    if(!formOk) {
      return;
    }

    push(context, AdoptionPageOne());
  }

  void _onAdoption() async {
    bool formOk = _formKey.currentState.validate();
    if(!formOk) {
      return;
    }

    push(context, AdoptionPageOne());
  }

  void _onComplaint() async {
    bool formOk = _formKey.currentState.validate();
    if(!formOk) {
      return;
    }

    push(context, ComplaintPageOne());
  }

}