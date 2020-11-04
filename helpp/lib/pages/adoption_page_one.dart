import 'package:flutter/material.dart';
import 'package:helpp/models/animal.dart';
import 'package:helpp/utils/config.dart';
import 'package:helpp/widgets/app_button.dart';
import 'package:helpp/widgets/app_text.dart';
import 'package:helpp/utils/nav.dart';
import 'package:helpp/pages/adoption_page_two.dart';
import 'package:validadores/validadores.dart';

class AdoptionPageOne extends StatefulWidget {
  @override
  _AdoptionPageOneState createState() => _AdoptionPageOneState();
}

class _AdoptionPageOneState extends State<AdoptionPageOne> {
  final _formKey = GlobalKey<FormState>();

  //Informações do animal
  final _tAnimal = TextEditingController();
  final _tQuantidade = TextEditingController();
  final _tNomeAnimal = TextEditingController();
  final _tIdade =  TextEditingController();
  final _tRaca = TextEditingController();
  final _tInformacoesAdicionais = TextEditingController();

  //Focus
  final _focusNomeAnimal = FocusNode();
  final _focusIdade = FocusNode();
  final _focusRaca = FocusNode();
  final _focusInformacoesAdicionais = FocusNode();

  //Listas
  List<DropdownMenuItem<String>> _listaItensSexo = List();
  String _sexoSelecionado;
  List<DropdownMenuItem<String>> _listaItensPorte = List();
  String _porteSelecionado;

  @override
  void initState() {
    super.initState();
    _listaItensSexo = Config.getSexos();
    _listaItensPorte = Config.getPortes();
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
        
            child: SingleChildScrollView (
              child: Column (
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[

                  SizedBox(height: 5),

                  Text(
                        "Informações do(s) animal(is)",
                        style: TextStyle(
                          color: Color(0xFF2196F3),
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                        )
                      ),

                  SizedBox(height: 30),

                  AppText("Animal*", 
                  "Digite qual é o animal", 
                  controller: _tAnimal, 
                  sizeText: 18,
                  validator: _validarAnimal,
                  keyboardType: TextInputType.text),
                  
                  SizedBox(height: 12,),

                  Row (
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: DropdownButtonFormField(
                            value: _sexoSelecionado,
                            hint: Text("Sexo*"),
                            style: TextStyle (
                              color: Color(0xFF2196F3),
                              fontSize: 18
                            ),
                            items: _listaItensSexo,
                            validator: _validarSexo,
                            onChanged: (valor) {
                              setState(() {
                                _sexoSelecionado = valor;
                              });
                            }
                          ),
                        ),
                      ),

                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: DropdownButtonFormField(
                            value: _porteSelecionado,
                            hint: Text("Porte*"),
                            style: TextStyle (
                              color: Color(0xFF2196F3),
                              fontSize: 18
                            ),
                            items: _listaItensPorte,
                            validator: _validarPorte,
                            onChanged: (valor) {
                              setState(() {
                                _porteSelecionado = valor;
                              });
                            }
                          ),
                        ),
                      ),
                    ]

                  ),
                    
                  SizedBox(height: 12,),

                  AppText("Quantidade*", 
                  "Digite a quantidade de animais", 
                  controller: _tQuantidade, 
                  sizeText: 18,
                  validator: _validarQuantidade,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next, 
                  nextFocus: _focusNomeAnimal),
                  
                  SizedBox(height: 12,),

                  AppText("Nome", 
                  "Digite o nome do animal", 
                  controller: _tNomeAnimal, 
                  sizeText: 18,
                  keyboardType: TextInputType.text,
                  focusNode: _focusNomeAnimal,
                  textInputAction: TextInputAction.next, 
                  nextFocus: _focusIdade),
                  
                  SizedBox(height: 12,),

                  AppText("Idade", 
                  "Digite a idade do animal", 
                  controller: _tIdade,
                  sizeText: 18,
                  keyboardType: TextInputType.number,
                  focusNode: _focusIdade,
                  textInputAction: TextInputAction.next, 
                  nextFocus: _focusRaca),
                  
                  SizedBox(height: 12,),

                  AppText("Raça", 
                  "Digite a raça do animal", 
                  controller: _tRaca,
                  sizeText: 18,
                  keyboardType: TextInputType.text,
                  focusNode: _focusRaca,
                  textInputAction: TextInputAction.next, 
                  nextFocus: _focusInformacoesAdicionais),

                  SizedBox(height: 12,),

                  AppText("Informações adicionais", 
                  "Digite informações adicionais", 
                  controller: _tInformacoesAdicionais, 
                  sizeText: 18,
                  validator: _validarInformacoesAdicionais,
                  keyboardType: TextInputType.text,
                  maxLines: null,
                  focusNode: _focusInformacoesAdicionais),
                  
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Divider(
                      color: Color(0xFF2196F3),
                      thickness: 2,
                    ),
                  ),

                  AppButton(
                    "PRÓXIMO", 
                    onPressed: _onNextPage,
                  ),
                ],
              ),
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

    String _tipo = _tAnimal.text;
    String _sexo = _sexoSelecionado;
    String _porte = _porteSelecionado;
    String _quantidade = _tQuantidade.text;
    String _nomeAnimal = _tNomeAnimal.text;
    String _idade = _tIdade.text;
    String _raca = _tRaca.text;
    String _informacoesAdicionais = _tInformacoesAdicionais.text;

    Animal animal = new Animal();

    animal.tipo = _tipo;
    animal.sexo = _sexo;
    animal.porte = _porte;
    animal.quantidade = _quantidade;
    animal.nomeAnimal = _nomeAnimal;
    animal.idade = _idade;
    animal.raca = _raca;
    animal.informacoesAdicionais = _informacoesAdicionais;
    
    push(context, AdoptionPageTwo(animal));
  }

  
  String _validarAnimal(String animal) {
    return Validador()
    .add(Validar.OBRIGATORIO, msg: "Campo obrigatório")
    .valido(animal);
  } 
  
  String _validarSexo(String sexo) {
    return Validador()
    .add(Validar.OBRIGATORIO, msg: "Campo obrigatório")
    .valido(sexo);
  } 

  String _validarPorte(String porte) {
    return Validador()
    .add(Validar.OBRIGATORIO, msg: "Campo obrigatório")
    .valido(porte);
  } 

  String _validarQuantidade(String quantidade) {
    return Validador()
    .add(Validar.OBRIGATORIO, msg: "Campo obrigatório")
    .valido(quantidade);
  } 

  String _validarInformacoesAdicionais(String informacoesAdicionais) {
    return Validador()
    .maxLength(300, msg: "Máximo de 300 caracteres")
    .valido(informacoesAdicionais);
  } 
}