import 'package:flutter/material.dart';
import 'package:helpp/models/animal.dart';
import 'package:helpp/widgets/app_button.dart';
import 'package:helpp/widgets/app_text.dart';
import 'package:helpp/utils/nav.dart';
import 'package:helpp/pages/adoption_page_two.dart';

class AdoptionPageOne extends StatefulWidget {
  @override
  _AdoptionPageOneState createState() => _AdoptionPageOneState();
}

class _AdoptionPageOneState extends State<AdoptionPageOne> {
  final _formKey = GlobalKey<FormState>();

  //Informações do animal
  final _tAnimal = TextEditingController();
  final _tSexo = TextEditingController();
  final _tPorte = TextEditingController();
  final _tNomeAnimal = TextEditingController();
  final _tIdade =  TextEditingController();
  final _tRaca = TextEditingController();
  final _tInformacoesAdicionais = TextEditingController();

  //Focus
  final _focusSexo = FocusNode();
  final _focusPorte = FocusNode();
  final _focusNomeAnimal = FocusNode();
  final _focusIdade = FocusNode();
  final _focusRaca = FocusNode();
  final _focusInformacoesAdicionais = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("HELPP",),
      ),
      
      body: _body(),
    );
  }

  _body() {
    return Form(
      key: _formKey,
        child: Container (
          padding: EdgeInsets.all(16),
          child: Center (
            child: SingleChildScrollView (
              child: Column (
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[

                  SizedBox(height: 5,),

                  Text(
                        "Informações do animal",
                        style: TextStyle(
                          color: Color(0xFF2196F3),
                          fontSize: 18
                        )
                      ),

                  SizedBox(height: 12,),

                  AppText("Animal*", 
                  "Digite qual é o animal", 
                  controller: _tAnimal, 
                  sizeText: 18,
                  validator: _validarAnimal,
                  keyboardType: TextInputType.text, 
                  textInputAction: TextInputAction.next, 
                  nextFocus: _focusSexo),
                  
                  SizedBox(height: 12,),

                  AppText("Sexo*", 
                  "Digite o sexo do animal", 
                  controller: _tSexo,
                  sizeText: 18, 
                  validator: _validarSexo, 
                  keyboardType: TextInputType.text,
                  focusNode: _focusSexo, 
                  textInputAction: TextInputAction.next, 
                  nextFocus: _focusPorte),
                  
                  SizedBox(height: 12,),

                  AppText("Porte*", 
                  "Digite o porte do animal", 
                  controller: _tPorte, 
                  sizeText: 18,
                  validator: _validarPorte,
                  keyboardType: TextInputType.text,
                  focusNode: _focusPorte,  
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
                  keyboardType: TextInputType.text,
                  focusNode: _focusInformacoesAdicionais),
                  
                  SizedBox(height: 22,),

                  AppButton(
                    "PRÓXIMO", 
                    onPressed: _onNextPage,
                  ),
                ],
              ),
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
    String _sexo = _tSexo.text;
    String _porte = _tPorte.text;
    String _nomeAnimal = _tNomeAnimal.text;
    String _idade = _tIdade.text;
    String _raca = _tRaca.text;
    String _informacoesAdicionais = _tInformacoesAdicionais.text;

    Animal animal = new Animal();

    animal.tipo = _tipo;
    animal.sexo = _sexo;
    animal.porte = _porte;
    animal.nomeAnimal = _nomeAnimal;
    animal.idade = _idade;
    animal.raca = _raca;
    animal.informacoesAdicionais = _informacoesAdicionais;
    
    push(context, AdoptionPageTwo(animal));
  }

  
  String _validarAnimal(String animal) {
    if(animal.isEmpty) {
      return "Digite o animal";
    }
    return null;
  } 
  
  String _validarSexo(String sexo) {
    if(sexo.isEmpty) {
      return "Digite o sexo do animal";
    }
    return null;
  } 

  String _validarPorte(String porte) {
    if(porte.isEmpty) {
      return "Digite o porte do animal";
    }
    return null;
  } 

  /*String _validarNomeAnimal(String nomeAnimal) {
    if(nomeAnimal.isEmpty) {
      return "Digite o nome do animal";
    }
    return null;
  }*/

  /*String _validarIdade(String idade) {
    if(idade.isEmpty) {
      return "Digite a idade do animal";
    }
    return null;
  }*/

  /*String _validarRaca(String raca) {
    if(raca.isEmpty) {
      return "Digite a raça do animal";
    }
    return null;
  }*/

  /*String _validarInformacoesAdicionais(String informacoesAdicionais) {
    if(informacoesAdicionais.isEmpty) {
      return "Digite informações adicionais";
    }
    return null;
  }*/

}