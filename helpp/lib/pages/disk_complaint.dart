import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DiskComplaint extends StatefulWidget {
  @override
  _DiskComplaintState createState() => _DiskComplaintState();
}

class _DiskComplaintState extends State<DiskComplaint> {
  final _formKey = GlobalKey<FormState>();
  String telefone100 = "100";
  String telefone180 = "180";
  String telefone181 = "181";
  String telefone190 = "190";

  _ligarTelefone(String telefone) async {
    if(await canLaunch("tel:$telefone")) {
      await launch("tel:$telefone");
    } else {
      print("Não foi possível realizar a ligação!");
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DISQUE DENÚNCIA"),
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
          child: Column (
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget> [
              Row (
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: GestureDetector(
                      onTap: () {
                        _ligarTelefone(telefone100);
                      },
                      child: CircleAvatar(
                        backgroundColor: Color(0xFF2196F3),
                        radius: 50,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                          Icon(
                            Icons.local_phone,
                            size: 40,
                            color: Color(0xFFFFFFFF),
                          ),
                          Text(
                            telefone100,
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontWeight: FontWeight.bold
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
                        _ligarTelefone(telefone180);
                      },
                      child: CircleAvatar(
                        backgroundColor: Color(0xFF2196F3),
                        radius: 50,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                          Icon(
                            Icons.local_phone,
                            size: 40,
                            color: Color(0xFFFFFFFF),
                          ),
                          Text(
                            telefone180,
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontWeight: FontWeight.bold
                            ),
                          )
                        ],),
                      ),
                    ),
                  ),
                ],
              ),

    

              SizedBox(height: 12,),

         
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: GestureDetector(
                      onTap: () {
                        _ligarTelefone(telefone181);
                      },
                      child: CircleAvatar(
                        backgroundColor: Color(0xFF2196F3),
                        radius: 50,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                          Icon(
                            Icons.local_phone,
                            size: 40,
                            color: Color(0xFFFFFFFF),
                          ),
                          Text(
                            telefone181,
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontWeight: FontWeight.bold
                            ),
                          )
                        ],),
                      ),
                    ),
                  ),

                  SizedBox(height: 180,),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: GestureDetector(
                      onTap: () {
                        _ligarTelefone(telefone190);
                      },
                      child: CircleAvatar(
                        backgroundColor: Color(0xFF2196F3),
                        radius: 50,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                          Icon(
                            Icons.local_phone,
                            size: 40,
                            color: Color(0xFFFFFFFF),
                          ),
                          Text(
                            telefone190,
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontWeight: FontWeight.bold
                            ),
                          )
                        ],),
                      ),
                    ),
                  ),
                ],
              ),  
            ], 
          ),
        ),
      ),
    );
  }
}