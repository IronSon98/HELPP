import 'package:flutter/material.dart';


class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HELPP"),
        ),
        body: _body(),
    );
  }

  _body() {
    return Container (
      padding: EdgeInsets.all(16),
      child: ListView(
        children: <Widget>[
          TextFormField(
            style: TextStyle(
              fontSize: 15,
              color: Colors.black
            ),
            decoration: InputDecoration(
              labelText: "CPF",
              labelStyle: TextStyle(
                fontSize: 20,
                color: Colors.blue
              ),
              hintText: "Digite o seu CPF",
              hintStyle: TextStyle(
                color: Colors.grey
              )
            ),
          ),
          SizedBox(height: 18,),
          TextFormField(
            style: TextStyle(
              fontSize: 15,
              color: Colors.black
            ),
            decoration: InputDecoration(
              labelText: "SENHA",
              labelStyle: TextStyle(
                fontSize: 18,
                color: Colors.blue
              ),
              hintText: "Digite sua senha",
              hintStyle: TextStyle(
                color: Colors.grey
              )
            ),
          ),
          SizedBox(height: 20,),
          Container(
            height:46,
            child: RaisedButton(
              color: Colors.blue,
              child: Text(
                "ACESSAR",
                style: TextStyle(
                  color: Colors.white, 
                  fontSize: 20
                ),
              ),
              onPressed: () {},
            ),
          )
        ]
      )
    );
  }
}