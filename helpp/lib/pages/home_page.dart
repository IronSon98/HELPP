import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:helpp/pages/menu_animals.dart';
import 'package:helpp/pages/menu_kids.dart';
import 'package:helpp/pages/login_page.dart';
import 'package:helpp/utils/nav.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _emailUsuario = "";
  List<String> itensMenu = ["Sair / Deslogar"];

//Verifica se existe um usuário logado e o enviada para a tela inicial 
  Future _recuperarDadosUsuario() async {
    FirebaseAuth auth = FirebaseAuth.instance;

    FirebaseUser usuarioLogado = await auth.currentUser();

    setState(() {
      _emailUsuario = usuarioLogado.email;
    });
  }

  _escolhaMenuItem(String itemEscolhido){

    switch(itemEscolhido ){

      case "Sair / Deslogar" :
        FirebaseAuth auth = FirebaseAuth.instance;
        auth.signOut();
        push(context, LoginPage());
        break;
    }
  }

  @override
  void initState() {
    _recuperarDadosUsuario();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("HELPP",),
        centerTitle: true,
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: _escolhaMenuItem,
            itemBuilder: (context){
              return itensMenu.map((String item){
                return PopupMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: TextStyle(
                      color: Color(0xFF2196F3),
                    ),
                  ),
                );
              }).toList();
            },
          )
        ],
      ),
      body: _body(),
    );
  }

   _body() {
    return Container (
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView ( 
          child: Column (
           crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[

              GestureDetector(
                onTap: () {
    
                },
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Row(children: <Widget>[
                      SizedBox(
                        width: 120,
                        height: 120,
                        child: Image.asset(
                          "imagens/logotipo01_02.JPG", 
                          width: 120, 
                          height: 120,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                            Text(
                              "DISQUE DENÚNCIA",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2196F3),
                              ),
                            ),
                          ],)
                        )
                      ),
                    ],)
                  )
                )
              ),

              GestureDetector(
                onTap: () {
                  push(context, MenuAnimals());
                },
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Row(children: <Widget>[
                      SizedBox(
                        width: 120,
                        height: 120,
                        child: Image.asset(
                          "imagens/logotipo03_02.JPG", 
                          width: 120, 
                          height: 120,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                            Text(
                              "ANIMAIS",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2196F3),
                              ),
                            ),
                          ],)
                        )
                      ),
                    ],)
                  )
                )
              ),
             
             GestureDetector(
                onTap: () {
                  push(context, MenuKids());
                },
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Row(children: <Widget>[
                      SizedBox(
                        width: 120,
                        height: 120,
                        child: Image.asset(
                          "imagens/logotipo02_01.JPG", 
                          width: 120, 
                          height: 120,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                            Text(
                              "CRIANÇAS E ADOLESCENTES",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2196F3),
                              ),
                            ),
                          ],)
                        )
                      ),
                    ],)
                  )
                )
              ),
            ],
          ),
        ),
      );
  }
}