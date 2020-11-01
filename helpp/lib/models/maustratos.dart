
import 'package:cloud_firestore/cloud_firestore.dart';

class Maustratos {

  String _id;

  //Endereço
  String _tipoDeEndereco;
  String _estado;
  String _municipio;
  String _endereco;
  String _numero;
  String _cep;

  //Informações da ocorrência
  String _dataDoFato;
  String _horaDoFato;
  String _relatoDoFato;
  String _tipoDeCrime;
  String _classificacaoDoAnimal;
  String _porte;
  String _quantidade;
  List<String> _fotos;

  //Informações do denunciante
  String _nomeDenunciante;
  String _cpf;
  String _telefone;
  String _email;
  String _estadoDenunciante;
  String _municipioDenunciante;
  String _enderecoDenunciante;
  String _numeroDenunciante;
  String _cepDenunciante;

  //Informações do denunciado
  String _nomeDenunciado;
  String _descricao;

  //Outros
  String _informacoesAdicionais;

  Maustratos();

  Maustratos.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    this.id = documentSnapshot.documentID;
    this.tipoDeEndereco = documentSnapshot["tipoDeEndereco"];
    this.estado = documentSnapshot["estado"];
    this.municipio = documentSnapshot["municipio"];
    this.endereco = documentSnapshot["endereco"];
    this.numero = documentSnapshot["numero"];
    this.cep = documentSnapshot["cep"];
    this.dataDoFato = documentSnapshot["dataDoFato"];
    this.horaDoFato = documentSnapshot["horaDoFato"];
    this.relatoDoFato = documentSnapshot["relatoDoFato"];
    this.tipoDeCrime = documentSnapshot["tipoDeCrime"];
    this.classificacaoDoAnimal = documentSnapshot["classificacaoDoAnimal"];
    this.porte = documentSnapshot["porte"];
    this.quantidade = documentSnapshot["quantidade"];
    this.fotos = List<String>.from(documentSnapshot["fotos"]);
    this.nomeDenunciante = documentSnapshot["nomeDenunciante"];
    this.cpf = documentSnapshot["cpf"];
    this.telefone = documentSnapshot["telefone"];
    this.email = documentSnapshot["email"];
    this.estadoDenunciante = documentSnapshot["estadoDenunciante"];
    this.municipioDenunciante = documentSnapshot["municipioDenunciante"];
    this.enderecoDenunciante = documentSnapshot["enderecoDenunciante"];
    this.numeroDenunciante = documentSnapshot["numeroDenunciante"];
    this.cepDenunciante = documentSnapshot["cepDenunciante"];
    this.nomeDenunciado = documentSnapshot["nomeDenunciado"];
    this.descricao = documentSnapshot["descricao"];
    this.informacoesAdicionais = documentSnapshot["informacoesAdicionais"];
  }

  Maustratos.gerarId(){
    Firestore db = Firestore.instance;
    CollectionReference anuncios = db.collection("complaint_animals");
    this.id = anuncios.document().documentID;

    this.fotos = [];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "id:" : this.id,
      "tipoDeEndereco" : this.tipoDeEndereco,
      "estado" : this.estado,
      "municipio" : this.municipio,
      "endereco" : this.endereco,
      "numero" : this.numero,
      "cep" : this.cep,
      "dataDoFato" : this.dataDoFato,
      "horaDoFato": this.horaDoFato,
      "realtoDoFato" : this.relatoDoFato,
      "tipoDeCrime" : this.tipoDeCrime,
      "classificacaoDoAnimal" : this.classificacaoDoAnimal,
      "porte" : this.porte,
      "quantidade" : this.quantidade,
      "fotos" : this.fotos,
      "nomeDenunciante" : this.nomeDenunciante,
      "cpf" : this.cpf,
      "telefone" : this.telefone,
      "email" : this.email,
      "estadoDenunciante" : this.estadoDenunciante,
      "municipioDenunciante" : this.municipioDenunciante,
      "enderecoDenunciante" : this.enderecoDenunciante,
      "numeroDenunciante" : this.numeroDenunciante,
      "cepDenunciante" : this.cepDenunciante,
      "nomeDenunciado" : this.nomeDenunciado,
      "descricao" : this.descricao,
      "informacoesAdicionais" : this.informacoesAdicionais,
    };

    return map;
  }

  String get id => _id;

   set id(String value) {
    _id = value;
  }

  String get tipoDeEndereco => _tipoDeEndereco;

  set tipoDeEndereco(String value) {
    _tipoDeEndereco = value;
  }

  String get estado => _estado;

  set estado(String value) {
    _estado = value;
  }

  String get municipio => _municipio;

  set municipio(String value) {
    _municipio = value;
  }

  String get endereco => _endereco;

  set endereco(String value) {
    _endereco = value;
  }

  String get numero => _numero;

  set numero(String value) {
    _numero = value;
  }

  String get cep => _cep;

  set cep(String value) {
    _cep = value;
  }

  String get dataDoFato => _dataDoFato;

  set dataDoFato(String value) {
    _dataDoFato = value;
  }

  String get horaDoFato => _horaDoFato;

  set horaDoFato(String value) {
    _horaDoFato = value;
  }
  
  String get relatoDoFato => _relatoDoFato;

  set relatoDoFato(String value) {
    _relatoDoFato = value;
  }

  String get tipoDeCrime => _tipoDeCrime;

  set tipoDeCrime(String value) {
    _tipoDeCrime = value;
  }

  String get classificacaoDoAnimal => _classificacaoDoAnimal;

  set classificacaoDoAnimal(String value) {
    _classificacaoDoAnimal = value;
  }

  String get porte => _porte;

  set porte(String value) {
    _porte = value;
  }

  String get quantidade => _quantidade;

  set quantidade(String value) {
    _quantidade = value;
  }

   List<String> get fotos => _fotos;

  set fotos(List<String> value) {
    _fotos = value;
  }

  String get nomeDenunciante => _nomeDenunciante;

  set nomeDenunciante(String value) {
    _nomeDenunciante = value;
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

  String get estadoDenunciante => _estadoDenunciante;

  set estadoDenunciante(String value) {
    _estadoDenunciante = value;
  }

  String get municipioDenunciante => _municipioDenunciante;

  set municipioDenunciante(String value) {
    _municipioDenunciante = value;
  }

  String get enderecoDenunciante => _enderecoDenunciante;

  set enderecoDenunciante(String value) {
    _enderecoDenunciante = value;
  }

  String get numeroDenunciante => _numeroDenunciante;

  set numeroDenunciante(String value) {
    _numeroDenunciante = value;
  }

  String get cepDenunciante => _cepDenunciante;

  set cepDenunciante(String value) {
    _cepDenunciante = value;
  }

  String get nomeDenunciado => _nomeDenunciado;

  set nomeDenunciado(String value) {
    _nomeDenunciado = value;
  }

  String get descricao => _descricao;

  set descricao(String value) {
    _descricao = value;
  }

  String get informacoesAdicionais => _informacoesAdicionais;

  set informacoesAdicionais(String value) {
    _informacoesAdicionais = value;
  }

}