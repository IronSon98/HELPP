import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:helpp/models/anuncio.dart';
import 'package:helpp/pages/details_ads.dart';
import 'package:helpp/pages/my_ads.dart';
import 'package:helpp/utils/config.dart';
import 'package:helpp/utils/nav.dart';
import 'package:helpp/widgets/item_ads.dart';

class AdoptionAnimals extends StatefulWidget {
  @override
  _AdoptionAnimalsState createState() => _AdoptionAnimalsState();
}

class _AdoptionAnimalsState extends State<AdoptionAnimals> {

  final _formKey = GlobalKey<FormState>();
  List<String> itensMenu = ["Meus anúncios"];
  List<DropdownMenuItem<String>> _listaItensEstado = List();
  String _itemSelecionadoEstado;
  final _controller = StreamController<QuerySnapshot>.broadcast();

  _escolhaMenuItem(String itemEscolhido){

    switch( itemEscolhido ){

      case "Meus anúncios" :
        push(context, MyAds());
        break;
    }
  }

  Future<Stream<QuerySnapshot>> _filtrarAnuncios() async {
    Firestore db = Firestore.instance;
    Query query = db.collection("adoption_animals_public");

    if(_itemSelecionadoEstado != null) {
      query = query.where("estado", isEqualTo: _itemSelecionadoEstado);
    }

    Stream<QuerySnapshot> stream = query.snapshots();
    stream.listen((dados) {
      _controller.add(dados);
     });
  }

  Future<Stream<QuerySnapshot>> _adicionarListenerAnuncios() async {
    Firestore db = Firestore.instance;
    Stream<QuerySnapshot> stream = db
    .collection("adoption_animals_public")
    .snapshots();

    stream.listen((dados) {
      _controller.add(dados);
     });
  }

  @override
  void initState() {
    super.initState();
    _listaItensEstado = Config.getEstados();
    _adicionarListenerAnuncios();
  }

  @override
  Widget build(BuildContext context) {

    var carregandoDados =  Center (
      child: Column(children: <Widget>[
        Text("Carregando anúncios"),
        CircularProgressIndicator()
      ],),
    );

    return Scaffold(
      appBar: AppBar(
        title:Text("ANIMAIS PARA ADOÇÃO",),
        centerTitle: true,
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: _escolhaMenuItem,
            itemBuilder: (context){
              return itensMenu.map((String item){
                return PopupMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: TextStyle(
                      color: Color(0xFF2196F3),
                    ),
                  ),
                );
              }).toList();
            },
          )
        ],
      ),
      
      body: Container(
        child: Column (
          children: <Widget>[
          Row(
            children: <Widget>[
            Expanded(
              child: DropdownButtonHideUnderline(
                child: Center(
                  child: DropdownButton(
                    iconEnabledColor: Color(0xFF2196F3),
                    value: _itemSelecionadoEstado,
                    items: _listaItensEstado,
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xFF2196F3)
                    ),
                    onChanged: (estado){
                      setState(() {
                        _itemSelecionadoEstado = estado;
                        _filtrarAnuncios();
                      });
                    },
                  ),
                ),
              ),
            )
          ],),

          StreamBuilder(
            stream: _controller.stream,
            builder: (context, snapshot) {
              switch(snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return carregandoDados;
                  break;
                case ConnectionState.active:
                case ConnectionState.done:

                  QuerySnapshot querySnapshot = snapshot.data;

                  if(querySnapshot.documents.length == 0) {
                    return Container(
                      padding: EdgeInsets.all(25),
                      child: Text("Nenhum anúncio disponível!", style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),),
                    );
                  }

                  return Expanded(
                    child: ListView.builder(
                      itemCount: querySnapshot.documents.length,
                      itemBuilder: (_, indice) {

                        List<DocumentSnapshot> anuncios = querySnapshot.documents.toList();
                        DocumentSnapshot documentSnapshot =  anuncios[indice];
                        Anuncio anuncio = Anuncio.fromDocumentSnapshot(documentSnapshot);

                        return ItemAds(
                          anuncio: anuncio,
                          onTapItem: () {
                            push(context, DetailsAds(anuncio));
                          },
                        );

                      }
                    ),
                  );
              }
              return Container();
            }
          )
        ],),
      ),
    );
  }
} 