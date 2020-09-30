import 'package:flutter/material.dart';
import 'package:helpp/pages/home_page.dart';
import 'package:helpp/pages/register_page.dart';
import 'package:helpp/widgets/app_button.dart';
import 'package:helpp/widgets/app_text.dart';
import 'package:helpp/utils/nav.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _tEmail = TextEditingController();
  final _tSenha =  TextEditingController();

  final _focusSenha = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    "imagens/logo_03.jpg", 
                    width: 192, 
                    height: 192,
                  ),
                ),

                AppText("E-mail", 
                "Digite o seu e-mail", 
                controller: _tEmail, 
                sizeText: 18,
                validator: _validarEmail, 
                keyboardType: TextInputType.emailAddress, 
                textInputAction: TextInputAction.next, 
                nextFocus: _focusSenha),

                SizedBox(height: 12,),

                AppText("Senha", 
                "Digite sua senha", 
                password: true, 
                controller: _tSenha, 
                sizeText: 18,
                validator: _validarSenha, 
                focusNode: _focusSenha),

                SizedBox(height: 22,),

                AppButton(
                  "ACESSAR", 
                  onPressed: _onClickLogin,
                ),

                SizedBox(height: 12,),

                AppButton(
                  "CADASTRAR",
                  onPressed: _onClickRegister,
                ),

                SizedBox(height: 20,),

                Center(
                  child: GestureDetector(
                    child: Text(
                      "Esqueci minha senha",
                      style: TextStyle(
                        color: Color(0xFF2196F3),
                        fontSize: 14
                      )
                    ),
                    onTap: () {

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

  void _onClickLogin() async {
    // Validação do formulário
    bool formOk = _formKey.currentState.validate();
    if(!formOk) {
      return;
    }

    String email = _tEmail.text;
    String senha = _tSenha.text;

    _validarCadastro(email, senha);
  }

  void _onClickRegister() async {

    push(context, RegisterPage());

  }

  String _validarEmail(String email) {
    if(email.isEmpty) {
      return "Digite o seu e-mail";
    }
    return null;
  } 

   String _validarSenha(String senha) {
    if(senha.isEmpty) {
      return "Digite sua senha";
    }
    return null;
  } 

  void _validarCadastro(String email, String senha) {

    FirebaseAuth auth = FirebaseAuth.instance;

   auth.signInWithEmailAndPassword(
     email: email, 
     password: senha
     ).then((firebaseUser) {
       print("Login realizado com sucesso! Email: " + firebaseUser.email);
       push(context, HomePage());
     }).catchError((erro) {
       print("Erro ao realizar o login! Erro: " + erro.toString());
     });
  }
}