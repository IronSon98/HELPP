import 'package:flutter/material.dart';
import 'package:helpp/pages/login_page.dart';
import 'package:helpp/widgets/app_button.dart';
import 'package:helpp/widgets/app_text.dart';
import 'package:helpp/utils/nav.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final _tNome = TextEditingController();
  final _tCPF = TextEditingController();
  final _tIdade = TextEditingController();
  final _tEmail = TextEditingController();
  final _tSenha =  TextEditingController();
  final _tTelefone = TextEditingController();

  final _focusCPF = FocusNode();
  final _focusIdade = FocusNode();
  final _focusEmail = FocusNode();
  final _focusSenha = FocusNode();
  final _focusTelefone = FocusNode();

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

            AppText("NOME", 
            "Digite o seu nome", 
            controller: _tNome, 
            sizeText: 18,
            keyboardType: TextInputType.text, 
            textInputAction: TextInputAction.next, 
            nextFocus: _focusCPF),
            SizedBox(height: 18,),

            AppText("CPF", 
            "Digite o seu CPF", 
            controller: _tCPF,
            sizeText: 18, 
            validator: _validarCPF, 
            keyboardType: TextInputType.number,
            focusNode: _focusCPF, 
            textInputAction: TextInputAction.next, 
            nextFocus: _focusIdade),
            SizedBox(height: 18,),

            AppText("IDADE", 
            "Digite a sua idade", 
            controller: _tIdade, 
            sizeText: 18,
            keyboardType: TextInputType.number,
            focusNode: _focusIdade,  
            textInputAction: TextInputAction.next, 
            nextFocus: _focusEmail),
            SizedBox(height: 18,),

            AppText("E-MAIL", 
            "Digite um e-mail válido", 
            controller: _tEmail, 
            sizeText: 18,
            keyboardType: TextInputType.emailAddress,
            focusNode: _focusEmail,  
            textInputAction: TextInputAction.next, 
            nextFocus: _focusSenha),
            SizedBox(height: 18,),

            AppText("SENHA", 
            "Digite sua senha", 
            password: true, 
            controller: _tSenha, 
            sizeText: 18,
            validator: _validarSenha,
            focusNode: _focusSenha, 
            textInputAction: TextInputAction.next, 
            nextFocus: _focusTelefone),
            SizedBox(height: 18,),

            AppText("TELEFONE", 
            "Digite um número de telefone para contato", 
            controller: _tTelefone,
            sizeText: 18,
            focusNode: _focusTelefone),
            SizedBox(height: 20,),

            AppButton(
              "CADASTRAR", 
              onPressed: _onClickRegister,
            ),
          ],
        ),
      ),
    );
  }

  void _onClickRegister() async {
    bool formOk = _formKey.currentState.validate();
    if(!formOk) {
      return;
    }

    String nome = _tNome.text;
    String cpf =  _tCPF.text;
    String idade = _tIdade.text;
    String email = _tEmail.text;
    String senha = _tSenha.text;
    String telefone = _tTelefone.text;

    print("Nome: $nome, CPF: $cpf, Idade: $idade, E-mail: $email, Senha: $senha, Telefone: $telefone");

  
    push(context, LoginPage());
    
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
}