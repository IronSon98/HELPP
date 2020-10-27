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
}