import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:helpp/pages/adoption_page_one.dart';
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
        title: Text("HELPP - " + _emailUsuario,),
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

                Center(
                  child: GestureDetector(
                    child: Image.asset(
                    "imagens/logo_adocao.JPG", 
                    width: 192, 
                    height: 192,
                  ),
                    onTap: () {
                      push(context, AdoptionPageOne());
                    },
                  ),
                )
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}