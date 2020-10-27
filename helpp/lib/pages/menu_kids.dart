import 'package:flutter/material.dart';
import 'package:helpp/widgets/app_button.dart';
import 'package:helpp/utils/nav.dart';
import 'package:helpp/pages/adoption_page_one.dart';
import 'package:helpp/pages/complaint_page_one.dart';

class MenuKids extends StatefulWidget {
  @override
  _MenuKidsState createState() => _MenuKidsState();
}

class _MenuKidsState extends State<MenuKids> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CRIANÇAS E ADOLESCENTES"),
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
                    "imagens/logo_criancas2.JPG", 
                    width: 240, 
                    height: 240,
                  ),
                ),

                AppButton(
                  "VISUALIZAR DESAPARECIDOS", 
                  onPressed: _onAnnounceAdoption,
                ),

                SizedBox(height: 12,),

                AppButton(
                  "DENUNCIAR DESAPARECIMENTO",
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

  void _onComplaint() async {
    bool formOk = _formKey.currentState.validate();
    if(!formOk) {
      return;
    }

    push(context, ComplaintPageOne());
  }

}