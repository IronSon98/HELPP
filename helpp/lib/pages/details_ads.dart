import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helpp/models/anuncio.dart';

class DetailsAds extends StatefulWidget {
  Anuncio anuncio;
  DetailsAds(this.anuncio);

  @override
  _DetailsAdsState createState() => _DetailsAdsState();
}

class _DetailsAdsState extends State<DetailsAds> {

  Anuncio _anuncio;

  List<Widget> _getListaImagens() {
    List<String> listaUrlImagens = _anuncio.fotos;
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

    _anuncio = widget.anuncio;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HELPP"),
        centerTitle: true,
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
                "${_anuncio.tipo}" + ", " + "${_anuncio.raca}",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2196F3)
                ),
              ),

              Text(
                "${_anuncio.cidade}" + ", " + "${_anuncio.estado}",
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
                "Informações do animal",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Text(
                "Sexo: ${_anuncio.sexo}\n" +
                "Porte: ${_anuncio.porte}\n" +
                "Quantidade: ${_anuncio.quantidade}",
                style: TextStyle(
                  fontSize: 18
                ),
              ),

              if (_anuncio.nomeAnimal.length > 0)
                Text(
                  "Nome do animal: ${_anuncio.nomeAnimal}",
                  style: TextStyle(
                    fontSize: 18
                  ),
                ),

              if (_anuncio.idade.length > 0)
                Text(
                  "Idade: ${_anuncio.idade}",
                  style: TextStyle(
                    fontSize: 18
                  ),
                ),


              if (_anuncio.informacoesAdicionais.length > 0)
                Text(
                  "Informações adicionais: ${_anuncio.informacoesAdicionais}",
                  style: TextStyle(
                    fontSize: 18
                  ),
                ),
        
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Divider(),
              ),

              Text(
                "Informações do anunciante",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

               Text(
                "Nome: ${_anuncio.nome}\n" +
                "Telefone: ${_anuncio.telefone}\n" +
                "E-mail: ${_anuncio.email}",
                style: TextStyle(
                  fontSize: 18
                ),
              ),

              if (_anuncio.whatsapp.length > 0)
                Text(
                  "Whatsapp: ${_anuncio.whatsapp}",
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