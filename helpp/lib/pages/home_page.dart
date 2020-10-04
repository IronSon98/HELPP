import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:helpp/pages/menu_adoption.dart';
import 'package:helpp/pages/login_page.dart';
import 'package:helpp/utils/nav.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  final _formKey = GlobalKey<FormState>();

  String _emailUsuario = "";

//Verifica se existe um usuário logado e o enviada para a tela inicial 
  Future _recuperarDadosUsuario() async {
    FirebaseAuth auth = FirebaseAuth.instance;

    FirebaseUser usuarioLogado = await auth.currentUser();

    setState(() {
      _emailUsuario = usuarioLogado.email;
    });
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
        title: Text("HELPP"),
        centerTitle: true,
        actions: <Widget> [
          IconButton(icon: Icon(Icons.power_settings_new), onPressed: ()  {
            FirebaseAuth auth = FirebaseAuth.instance;
            auth.signOut();
            push(context, LoginPage());
          },)
        ]
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
        child: SingleChildScrollView ( 
          child: Column (
           crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[

             
              GestureDetector(
                child: Image.asset(
                "imagens/logo_adocao.JPG", 
                width: 240, 
                height: 240,
              ),
                onTap: () {
                  push(context, MenuAdoption());
                },
              ),
            
              GestureDetector(
                child: Image.asset(
                "imagens/logo_maustratos.JPG", 
                width: 240, 
                height: 240,
              ),
                onTap: () {
                  push(context, MenuAdoption());
                },
              ),
              
              
            ],
          ),
        ),
      ),
    );
  }
}