import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helpp/models/desaparecidos.dart';

class DetailsComplaintMissing extends StatefulWidget {
  Desaparecidos denuncia;
  DetailsComplaintMissing(this.denuncia);

  @override
  _DetailsComplaintMissingState createState() => _DetailsComplaintMissingState();
}

class _DetailsComplaintMissingState extends State<DetailsComplaintMissing> {

  Desaparecidos _denuncia;

  List<Widget> _getListaImagens() {
    List<String> listaUrlImagens = _denuncia.fotos;
    return listaUrlImagens.map((url){
      return Container(
        height: 250,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(url),
            fit: BoxFit.fill
          )
        ),
      );
    }).toList();
  }

  @override
  void initState() {
    super.initState();

    _denuncia = widget.denuncia;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HELPP"),
      ),
      body: Stack(children: <Widget>[

        ListView(children: <Widget>[
          SizedBox(
            height: 250,
            child: Carousel (
              images: _getListaImagens(),
              dotSize: 8,
              dotBgColor: Colors.transparent,
              dotColor: Colors.white,
              autoplay: false,
              dotIncreasedColor: Color(0xFF2196F3),
            ),
          ),

          Container(
            padding: EdgeInsets.all(16),
            child: Column (
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
              Text(
                "${_denuncia.nomeDesaparecido}" + ", " + "${_denuncia.idade}",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2196F3)
                ),
              ),

              Text(
                "Desaparecido desde:" + "${_denuncia.dataDesaparecimento}",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Divider(),
              ),

              Text(
                    "Informações do declarante",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    )
                  ),

                  Text(
                    "Nome: ${_denuncia.nome}\n" +
                    "CPF: ${_denuncia.cpf}\n" +
                    "Telefone: ${_denuncia.telefone}\n" +
                    "E-mail: ${_denuncia.email}\n" + 
                    "Estado: ${_denuncia.estado}\n" +
                    "Município ${_denuncia.cidade}\n",
                    style: TextStyle(
                      fontSize: 18
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Divider(),
                  ),

                  Text(
                        "Informações do desaparecido",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                        )
                      ),

                  if (_denuncia.nomeDoPai.length > 0)
                    Text(
                      "Nome do pai: ${_denuncia.nomeDoPai}",
                      style: TextStyle(
                        fontSize: 18
                      ),
                    ),

                  if (_denuncia.nomeDaMae.length > 0)
                    Text(
                      "Nome do pai: ${_denuncia.nomeDaMae}",
                      style: TextStyle(
                        fontSize: 18
                      ),
                    ),

                  Text(
                    "Sexo: ${_denuncia.sexo}\n" +
                    "Data de nascimento: ${_denuncia.dataDoNascimento}\n" + 
                    "Estado: ${_denuncia.estadoDesaparecido}\n" +
                    "Município ${_denuncia.cidadeDesaparecido}\n",
                    style: TextStyle(
                      fontSize: 18
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Divider(),
                  ),

                  Text(
                        "Informações do desaparecimento",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                        )
                      ),

                  Text(
                    "Local do desaparecimento: ${_denuncia.localDesaparecimento}\n" +
                    "Hora do desaparecimento: ${_denuncia.horaDesaparecimento}\n" + 
                    "Data do desaparecimento: ${_denuncia.dataDesaparecimento}\n",
                    style: TextStyle(
                      fontSize: 18
                    ),
                  ),

                  if(_denuncia.altura.length > 0 || _denuncia.corOlhos.length > 0 || _denuncia.corPele.length > 0 || _denuncia.corCabelo.length > 0 || _denuncia.outras.length > 0)
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Divider(),
                    ),

                  if(_denuncia.altura.length > 0 || _denuncia.corOlhos.length > 0 || _denuncia.corPele.length > 0 || _denuncia.corCabelo.length > 0 || _denuncia.outras.length > 0)
                    Text(
                          "Características físicas do desaparecido",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                          )
                        ),

                  if (_denuncia.altura.length > 0)
                    Text(
                      "Altura: ${_denuncia.altura}",
                      style: TextStyle(
                        fontSize: 18
                      ),
                    ),

                   if (_denuncia.corOlhos.length > 0)
                    Text(
                      "Cor dos olhos: ${_denuncia.corOlhos}",
                      style: TextStyle(
                        fontSize: 18
                      ),
                    ),

                  if (_denuncia.corPele.length > 0)
                    Text(
                      "Cor da pele: ${_denuncia.corPele}",
                      style: TextStyle(
                        fontSize: 18
                      ),
                    ),

                  if (_denuncia.corCabelo.length > 0)
                    Text(
                      "Cor do cabelo: ${_denuncia.corCabelo}",
                      style: TextStyle(
                        fontSize: 18
                      ),
                    ),

                  if (_denuncia.outras.length > 0)
                    Text(
                      "Outras características:\n ${_denuncia.outras}",
                      style: TextStyle(
                        fontSize: 18
                      ),
                    ),

                  if(_denuncia.informacoesAdicionais.length > 0) 
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Divider(),
                    ),

                  if(_denuncia.informacoesAdicionais.length > 0) 
                    Text(
                      "Informações adicionais",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${_denuncia.informacoesAdicionais}\n",
                      style: TextStyle(
                        fontSize: 18
                      ),
                    ),
            ],),
          )
        ],),
      ],),
    );
  }
}