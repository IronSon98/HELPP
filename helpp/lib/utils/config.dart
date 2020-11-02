import 'package:flutter/material.dart';
import 'package:brasil_fields/brasil_fields.dart';

class Config {
  static List<DropdownMenuItem<String>> getSexos() {
    List<DropdownMenuItem<String>> itensDropSexo = [];

    //Sexos
    itensDropSexo.add(
      DropdownMenuItem(child: Text(
        "Sexo*", style: TextStyle (
        color: Color(0xFF2196F3)
        ),
        ), value: null,)
    );

    itensDropSexo.add(
      DropdownMenuItem(child: Text("Macho"), value: "Macho",)
    );

    itensDropSexo.add(
      DropdownMenuItem(child: Text("Fêmea"), value: "Fêmea",)
    );

    return itensDropSexo;
  }

  static List<DropdownMenuItem<String>> getPortes() {
    List<DropdownMenuItem<String>> itensDropPorte = [];

    //Portes
    itensDropPorte.add(   
      DropdownMenuItem(child: Text(
        "Porte*", style: TextStyle (
        color: Color(0xFF2196F3)
        ),
        ), value: null,)
    );

    itensDropPorte.add(
      DropdownMenuItem(child: Text("Pequeno"), value: "Pequeno",)
    );

    itensDropPorte.add(
      DropdownMenuItem(child: Text("Médio"), value: "Médio",)
    );

    itensDropPorte.add(
      DropdownMenuItem(child: Text("Grande"), value: "Grande",)
    );

    return itensDropPorte;
  }

  static List<DropdownMenuItem<String>> getEstados() {

    List<DropdownMenuItem<String>> itensDropEstados = [];

    //Estados
    itensDropEstados.add(
      DropdownMenuItem(child: Text(
        "Estado*", style: TextStyle (
        color: Color(0xFF2196F3)
        ),
        ), value: null,)
    );

    for(var estado in Estados.listaEstados) {
      itensDropEstados.add(
        DropdownMenuItem(child: Text(estado), value: estado,)
      );
    }

    return itensDropEstados;

  }


  static List<DropdownMenuItem<String>> getClassificacoes() {
    List<DropdownMenuItem<String>> itensDropClassificacao = [];

    //Classificações de animais
    itensDropClassificacao.add(   
      DropdownMenuItem(child: Text(
        "Classificação do animal*", style: TextStyle (
        color: Color(0xFF2196F3)
        ),
        ), value: null,)
    );

    itensDropClassificacao.add(
      DropdownMenuItem(child: Text("Cão"), value: "Cão",)
    );

    itensDropClassificacao.add(
      DropdownMenuItem(child: Text("Gato"), value: "Gato",)
    );

    itensDropClassificacao.add(
      DropdownMenuItem(child: Text("Equino"), value: "Equino",)
    );

    itensDropClassificacao.add(
      DropdownMenuItem(child: Text("Suíno"), value: "Suíno",)
    );

    itensDropClassificacao.add(
      DropdownMenuItem(child: Text("Pássaro"), value: "Pássaro",)
    );

    itensDropClassificacao.add(
      DropdownMenuItem(child: Text("Bovino"), value: "Bovino",)
    );

    itensDropClassificacao.add(
      DropdownMenuItem(child: Text("Outros (especificar)"), value: "Outros",)
    );

    return itensDropClassificacao;
  }

  static List<DropdownMenuItem<String>> getTiposDeEnderecos() {
    List<DropdownMenuItem<String>> itensTipoDeEndereco = [];

    //Classificações de animais
    itensTipoDeEndereco.add(   
      DropdownMenuItem(child: Text(
        "Tipo de endereço*", style: TextStyle (
        color: Color(0xFF2196F3)
        ),
        ), value: null,)
    );

    itensTipoDeEndereco.add(
      DropdownMenuItem(child: Text("Residencial"), value: "Residencial",)
    );

    itensTipoDeEndereco.add(
      DropdownMenuItem(child: Text("Comercial"), value: "Comercial",)
    );

    itensTipoDeEndereco.add(
      DropdownMenuItem(child: Text("Industrial"), value: "Industrial",)
    );

    itensTipoDeEndereco.add(
      DropdownMenuItem(child: Text("Ponto de referência"), value: "Ponto de referência",)
    );

    itensTipoDeEndereco.add(
      DropdownMenuItem(child: Text("Outro"), value: "Outro",)
    );

    return itensTipoDeEndereco;
  }

  static List<DropdownMenuItem<String>> getTiposDeCrimes() {
    List<DropdownMenuItem<String>> itensTipoDeCrime = [];

    //Classificações de animais
    itensTipoDeCrime.add(   
      DropdownMenuItem(child: Text(
        "Tipo de crime*", style: TextStyle (
        color: Color(0xFF2196F3)
        ),
        ), value: null,)
    );

    itensTipoDeCrime.add(
      DropdownMenuItem(child: Text("Abandono"), value: "Abandono",)
    );

    itensTipoDeCrime.add(
      DropdownMenuItem(child: Text("Cativeiro"), value: "Cativeiro",)
    );

    itensTipoDeCrime.add(
      DropdownMenuItem(child: Text("Caça"), value: "Caça",)
    );

    itensTipoDeCrime.add(
      DropdownMenuItem(child: Text("Maus tratos"), value: "Maus tratos",)
    );

    itensTipoDeCrime.add(
      DropdownMenuItem(child: Text("Envenenamento"), value: "Envenenamento",)
    );

    itensTipoDeCrime.add(
      DropdownMenuItem(child: Text("Mutilação"), value: "Mutilação",)
    );

    itensTipoDeCrime.add(
      DropdownMenuItem(child: Text("Outros (especificar)"), value: "Outros",)
    );

    return itensTipoDeCrime;
  }
}