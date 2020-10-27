
import 'package:cloud_firestore/cloud_firestore.dart';

class Anuncio {

  String _id;
  List<String> _fotos;
  String _tipo;
  String _sexo;
  String _porte;
  String _quantidade;
  String _nomeAnimal ;
  String _idade;
  String _raca;
  String _informacoesAdicionais;
  String _nome;
  String _telefone;
  String _email;
  String _estado;
  String _cidade;
  String _whatsapp;

  Anuncio();

  Anuncio.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    this.id = documentSnapshot.documentID;
    this.fotos = List<String>.from(documentSnapshot["fotos"]);
    this.tipo = documentSnapshot["tipo"];
    this.sexo = documentSnapshot["sexo"];
    this.porte = documentSnapshot["porte"];
    this.quantidade = documentSnapshot["quantidade"];
    this.nomeAnimal = documentSnapshot["nomeAnimal"];
    this.idade = documentSnapshot["idade"];
    this.raca = documentSnapshot["raca"];
    this.informacoesAdicionais = documentSnapshot["informacoesAdicionais"];
    this.nome = documentSnapshot["nome"];
    this.telefone = documentSnapshot["telefone"];
    this.email = documentSnapshot["email"];
    this.estado = documentSnapshot["estado"];
    this.cidade = documentSnapshot["cidade"];
    this.whatsapp =  documentSnapshot["whatsapp"];
  }

  Anuncio.gerarId(){
    Firestore db = Firestore.instance;
    CollectionReference anuncios = db.collection("adoption_animals");
    this.id = anuncios.document().documentID;

    this.fotos = [];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "id:" : this.id,
      "fotos" : this.fotos,
      "tipo" : this.tipo, 
      "sexo" : this.sexo,
      "porte" : this.porte,
      "quantidade" : this.quantidade,
      "nomeAnimal" : this.nomeAnimal,
      "idade" : this.idade,
      "raca" : this.raca,
      "informacoesAdicionais" : this.informacoesAdicionais,
      "nome" : this.nome,
      "telefone" : this.telefone,
      "email" : this.email,
      "estado" : this.estado,
      "cidade" : this.cidade,
      "whatsapp" : this.whatsapp,
    };

    return map;
  }

  String get id => _id;

   set id(String value) {
    _id = value;
  }

  List<String> get fotos => _fotos;

  set fotos(List<String> value) {
    _fotos = value;
  }

  String get tipo => _tipo;

  set tipo(String value) {
    _tipo = value;
  }

  String get sexo => _sexo;

  set sexo(String value) {
    _sexo = value;
  }

  String get porte => _porte;

  set porte(String value) {
    _porte = value;
  }

  String get quantidade => _quantidade;

  set quantidade(String value) {
    _quantidade = value;
  }

  String get nomeAnimal => _nomeAnimal;

  set nomeAnimal(String value) {
    _nomeAnimal = value;
  }

  String get idade => _idade;

  set idade(String value) {
    _idade = value;
  }

  String get raca => _raca;

  set raca(String value) {
    _raca = value;
  }

  String get informacoesAdicionais => _informacoesAdicionais;

  set informacoesAdicionais(String value) {
    _informacoesAdicionais = value;
  }

  String get nome => _nome;

  set nome(String value) {
    _nome = value;
  }

  String get telefone => _telefone;

  set telefone(String value) {
    _telefone = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get estado => _estado;

  set estado(String value) {
    _estado = value;
  }

  String get cidade => _cidade;

  set cidade(String value) {
    _cidade = value;
  }

  String get whatsapp => _whatsapp;

  set whatsapp(String value) {
    _whatsapp = value;
  }

}