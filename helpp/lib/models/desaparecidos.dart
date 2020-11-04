
import 'package:cloud_firestore/cloud_firestore.dart';

class Desaparecidos {

  //ID da denúncia
  String _id;

  //Informações do declarante
  String _nome;
  String _cpf;
  String _telefone;
  String _email;
  String _estado;
  String _cidade;

  //Dados do desaparecido
  String _nomeDoPai;
  String _nomeDaMae;
  String _nomeDesaparecido;
  String _sexo;
  String _idade;
  String _dataDoNascimento;
  String _estadoDesaparecido;
  String _cidadeDesaparecido;
  List<String> _fotos;

  //Informações do desaparecimento
  String _localDesaparecimento;
  String _horaDesaparecimento;
  String _dataDesaparecimento;

  //Características físicas do desaparecido
  String _altura;
  String _corOlhos;
  String _corPele;
  String _corCabelo;
  String _outras;

  //Informações adicionais
  String _informacoesAdicionais;
  

  Desaparecidos();

  Desaparecidos.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    this.id = documentSnapshot.documentID;
    this.nome = documentSnapshot["nome"];
    this.cpf = documentSnapshot["cpf"];
    this.telefone = documentSnapshot["telefone"];
    this.email = documentSnapshot["email"];
    this.estado = documentSnapshot["estado"];
    this.cidade = documentSnapshot["cidade"];
    this.nomeDoPai = documentSnapshot["nomeDoPai"];
    this.nomeDaMae = documentSnapshot["nomeDaMae"];
    this.nomeDesaparecido = documentSnapshot["nomeDesaparecido"];
    this.sexo = documentSnapshot["sexo"];
    this.idade = documentSnapshot["idade"];
    this.dataDoNascimento = documentSnapshot["dataDoNascimento"];
    this.estadoDesaparecido = documentSnapshot["estadoDesaparecido"];
    this.cidadeDesaparecido = documentSnapshot["cidadeDesaparecido"];
    this.fotos = List<String>.from(documentSnapshot["fotos"]);
    this.localDesaparecimento = documentSnapshot["localDesaparecimento"];
    this.horaDesaparecimento = documentSnapshot["horaDesaparecimento"];
    this.dataDesaparecimento = documentSnapshot["dataDesaparecimento"];
    this.altura = documentSnapshot["altura"];
    this.corOlhos = documentSnapshot["corOlhos"];
    this.corPele = documentSnapshot["corPele"];
    this.corCabelo = documentSnapshot["corCabelo"];
    this.outras = documentSnapshot["outras"];
    this.informacoesAdicionais = documentSnapshot["informacoesAdicionais"];
  }

  Desaparecidos.gerarId(){
    Firestore db = Firestore.instance;
    CollectionReference desaparecidos = db.collection("complaint_missing");
    this.id = desaparecidos.document().documentID;

    this.fotos = [];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "id:" : this.id,
      "nome:" : this.nome,
      "cpf:" : this.cpf,
      "telefone:" : this.telefone,
      "email:" : this.email,
      "estado:" : this.estado,
      "cidade:" : this.cidade,
      "nomeDoPai:" : this.nomeDoPai,
      "nomeDaMae:" : this.nomeDaMae,
      "nomeDesaparecido:" : this.nomeDesaparecido,
      "sexo:" : this.sexo,
      "idade:" : this.idade,
      "dataDoNascimento:" : this.dataDoNascimento,
      "estadoDesaparecido:" : this.estadoDesaparecido,
      "cidadeDesaparecido:" : this.cidadeDesaparecido,
      "fotos:" : this.fotos,
      "localDesaparecimento:" : this.localDesaparecimento,
      "horaDesaparecimento:" : this.horaDesaparecimento,
      "dataDesaparecimento:" : this.dataDesaparecimento,
      "altura:" : this.altura,
      "corOlhos:" : this.corOlhos,
      "corPele:" : this.corPele,
      "corCabelo:" : this.corCabelo,
      "outras:" : this.outras,
      "informacoesAdicionais:" : this.informacoesAdicionais,
    };

    return map;
  }

  //ID da denúncia
  String get id => _id;

   set id(String value) {
    _id = value;
  }

  //Informações do declarante
  String get nome => _nome;

  set nome(String value) {
    _nome = value;
  }

  String get cpf => _cpf;

  set cpf(String value) {
    _cpf = value;
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

  //Dados do desaparecido
  String get nomeDoPai => _nomeDoPai;

  set nomeDoPai(String value) {
    _nomeDoPai = value;
  }

   String get nomeDaMae => _nomeDaMae;

  set nomeDaMae(String value) {
    _nomeDaMae = value;
  }

   String get nomeDesaparecido => _nomeDesaparecido;

  set nomeDesaparecido(String value) {
    _nomeDesaparecido = value;
  }

  String get sexo => _sexo;

  set sexo(String value) {
    _sexo = value;
  }

  String get idade => _idade;

  set idade(String value) {
    _idade = value;
  }

  String get dataDoNascimento => _dataDoNascimento;

  set dataDoNascimento(String value) {
    _dataDoNascimento = value;
  }

  String get estadoDesaparecido => _estadoDesaparecido;

  set estadoDesaparecido(String value) {
    _estadoDesaparecido = value;
  }

  String get cidadeDesaparecido => _cidadeDesaparecido;

  set cidadeDesaparecido(String value) {
    _cidadeDesaparecido = value;
  }

  List<String> get fotos => _fotos;

  set fotos(List<String> value) {
    _fotos = value;
  }

  //Informações do desaparecimento
  String get localDesaparecimento => _localDesaparecimento;

  set localDesaparecimento(String value) {
    _localDesaparecimento = value;
  }

  String get horaDesaparecimento => _horaDesaparecimento;

  set horaDesaparecimento(String value) {
    _horaDesaparecimento = value;
  }

  String get dataDesaparecimento => _dataDesaparecimento;

  set dataDesaparecimento(String value) {
    _dataDesaparecimento = value;
  }

  //Características físicas da pessoa
  String get altura => _altura;

  set altura(String value){
    _altura = value;
  }

  String get corOlhos => _corOlhos;

  set corOlhos(String value) {
    _corOlhos = value;
  }

  String get corPele => _corPele;

  set corPele(String value) {
    _corPele = value;
  }

  String get corCabelo => _corCabelo;

  set corCabelo(String value) {
    _corCabelo = value;
  }

  String get outras => _outras;

  set outras(String value) {
    _outras = value;
  }

  //Informações adicionais
  String get informacoesAdicionais => _informacoesAdicionais;

  set informacoesAdicionais(String value) {
    _informacoesAdicionais = value;
  }

}