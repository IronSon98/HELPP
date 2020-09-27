import 'package:flutter/material.dart';
import 'package:helpp/pages/home_page.dart';
import 'package:helpp/pages/login_api.dart';
import 'package:helpp/pages/register_page.dart';
import 'package:helpp/widgets/app_button.dart';
import 'package:helpp/widgets/app_text.dart';
import 'package:helpp/utils/nav.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _tCPF = TextEditingController();
  final _tSenha =  TextEditingController();

  final _focusSenha = FocusNode();

  @override
  void initState() {
    super.initState();
  }

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
    return Form(
      key: _formKey,
      child: Container (
        padding: EdgeInsets.all(16),
        child: ListView(
          children: <Widget>[

            AppText("CPF", 
            "Digite o seu CPF", 
            controller: _tCPF, 
            sizeText: 20,
            validator: _validarCPF, 
            keyboardType: TextInputType.number, 
            textInputAction: TextInputAction.next, 
            nextFocus: _focusSenha),
            SizedBox(height: 18,),

            AppText("SENHA", 
            "Digite sua senha", 
            password: true, 
            controller: _tSenha, 
            sizeText: 20,
            validator: _validarSenha, 
            focusNode: _focusSenha),
            SizedBox(height: 20,),

            AppButton(
              "ACESSAR", 
              onPressed: _onClickLogin,
            ),
            SizedBox(height: 20,),

            AppButton(
              "CADASTRAR",
              onPressed: _onClickRegister,
            )
          ],
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

    String cpf = _tCPF.text;
    String senha = _tSenha.text;

    print("CPF: $cpf, Senha: $senha");

    bool loginAceito = await LoginApi.login(cpf, senha);

    if(loginAceito) {
      push(context, HomePage());
    } else {
      print("Login incorreto!");
    }
    
  }

  void _onClickRegister() async {

    push(context, RegisterPage());

  }

  String _validarCPF(String cpf) {
    if(cpf.isEmpty) {
      return "Digite o seu CPF";
    }
    if(cpf.length != 11) {
      return "CPF incorreto";
    }
    return null;
  } 

   String _validarSenha(String senha) {
    if(senha.isEmpty) {
      return "Digite sua senha";
    }
    return null;
  } 

  String _validarCadastro(String cpf, String senha) async {

    Firestore db = Firestore.instance;
    String msgRetorno;
    bool validaCPF, validaSenha;

    db.collection("users").snapshots().listen( // Verifica se tem alguma alteração no banco de dados e atualiza
      (snapshot) {
        for(DocumentSnapshot cadastro in snapshot.documents) {
         var dados = cadastro.data; 
        }
       }
    );
  }
}