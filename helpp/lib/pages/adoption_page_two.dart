import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:helpp/models/animal.dart';
import 'package:helpp/models/anunciante.dart';
import 'package:helpp/utils/config.dart';
import 'package:helpp/widgets/app_button.dart';
import 'package:helpp/widgets/app_text.dart';
import 'package:helpp/utils/nav.dart';
import 'package:helpp/pages/adoption_page_three.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:validadores/validadores.dart';

class AdoptionPageTwo extends StatefulWidget {

  Animal animal;
  
  AdoptionPageTwo(this.animal);

  @override
  _AdoptionPageTwoState createState() => _AdoptionPageTwoState();
}

class _AdoptionPageTwoState extends State<AdoptionPageTwo> {
  final _formKey = GlobalKey<FormState>();

  //Informações da pessoa
  final _tNome = TextEditingController();
  final _tTelefone = TextEditingController();
  final _tEmail = TextEditingController();
  final _tCidade = TextEditingController();
  final _tWhatsapp = TextEditingController();

  //Focus
  final _focusTelefone = FocusNode();
  final _focusEmail = FocusNode();
  final _focusWhatsapp = FocusNode();

  //Listas
  List<DropdownMenuItem<String>> _listaItensEstado = List();
  String _estadoSelecionado;

  @override
  void initState() {
    super.initState();
    _listaItensEstado = Config.getEstados();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("HELPP",),
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
          child: ListView (
            children: <Widget>[
                
              SizedBox(height: 5,),
              
              Text(
                    "Informações do anunciante",
                    style: TextStyle(
                      color: Color(0xFF2196F3),
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    )
                  ),

              SizedBox(height: 12,),

              AppText("Nome*", 
              "Digite seu nome", 
              controller: _tNome, 
              sizeText: 18,
              validator: _validarNome,
              keyboardType: TextInputType.text, 
              textInputAction: TextInputAction.next, 
              nextFocus: _focusTelefone),
              
              SizedBox(height: 12,),

              AppText("Telefone*", 
              "Digite o seu telefone", 
              controller: _tTelefone,
              sizeText: 18, 
              validator: _validarTelefone, 
              keyboardType: TextInputType.number,
              inputFormatters: [
                WhitelistingTextInputFormatter.digitsOnly,
                TelefoneInputFormatter()
              ],
              focusNode: _focusTelefone, 
              textInputAction: TextInputAction.next, 
              nextFocus: _focusEmail),
              
              SizedBox(height: 12,),

              AppText("Email*", 
              "Digite o seu e-mail", 
              controller: _tEmail, 
              sizeText: 18,
              validator: _validarEmail,
              keyboardType: TextInputType.emailAddress,
              focusNode: _focusEmail,  
              textInputAction: TextInputAction.next,),
              
              SizedBox(height: 12,),

              Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: DropdownButtonFormField(
                        value: _estadoSelecionado,
                        hint: Text("Estado*"),
                        style: TextStyle (
                          color: Color(0xFF2196F3),
                          fontSize: 18
                        ),
                        items: _listaItensEstado,
                        validator: _validarEstado,
                        onChanged: (valor) {
                          setState(() {
                            _estadoSelecionado = valor;
                          });
                        }
                      ),
                    ),
                  ),
                ]

              ),

              SizedBox(height: 12,),

              AppText("Cidade*", 
              "Digite a cidade que você mora", 
              controller: _tCidade, 
              sizeText: 18,
              validator: _validarCidade,
              keyboardType: TextInputType.text,  
              textInputAction: TextInputAction.next,
              nextFocus: _focusWhatsapp),

              SizedBox(height: 12,),

              AppText("Whatsapp", 
              "Digite seu whatsapp", 
              controller: _tWhatsapp, 
              sizeText: 18,
              keyboardType: TextInputType.number,
              inputFormatters: [
                WhitelistingTextInputFormatter.digitsOnly,
                TelefoneInputFormatter()
              ],
              focusNode: _focusWhatsapp,),
              
              SizedBox(height: 22,),

              AppButton(
                "PRÓXIMO", 
                onPressed: _onNextPage,
              ),
            ],
          ),
      ),
    );
  }

  void _onNextPage() async {
    // Validação do formulário
    bool formOk = _formKey.currentState.validate();
    if(!formOk) {
      return;
    }

    Anunciante anunciante = new Anunciante();

    anunciante.nome = _tNome.text;
    anunciante.telefone = _tTelefone.text.toString();
    anunciante.email = _tEmail.text;
    anunciante.estado = _estadoSelecionado;
    anunciante.cidade = _tCidade.text;
    anunciante.whatsapp = _tWhatsapp.text.toString();
    
    push(context, AdoptionPageThree(widget.animal, anunciante));
  }

  
  String _validarNome(String nome) {
    return Validador()
    .add(Validar.OBRIGATORIO, msg: "Campo obrigatório")
    .valido(nome);
  } 
  
  String _validarTelefone(String telefone) {
    return Validador()
    .add(Validar.OBRIGATORIO, msg: "Campo obrigatório")
    .valido(telefone);
  } 

 String _validarEmail(String email) {
   return Validador()
    .add(Validar.OBRIGATORIO, msg: "Campo obrigatório")
    .add(Validar.EMAIL, msg: "E-mail inválido")
    .valido(email);
  } 

  String _validarEstado(String estado) {
   return Validador()
    .add(Validar.OBRIGATORIO, msg: "Campo obrigatório")
    .valido(estado);
  } 

  String _validarCidade(String cidade) {
   return Validador()
    .add(Validar.OBRIGATORIO, msg: "Campo obrigatório")
    .valido(cidade);
  } 
}