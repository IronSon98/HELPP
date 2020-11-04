import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:helpp/models/desaparecidos.dart';
import 'package:helpp/pages/details_complaint_missing.dart';
import 'package:helpp/pages/my_complaint_missing.dart';
import 'package:helpp/utils/config.dart';
import 'package:helpp/utils/nav.dart';
import 'package:helpp/widgets/item_complaint_missing.dart';

class ComplaintMissing extends StatefulWidget {
  @override
  _ComplaintMissingState createState() => _ComplaintMissingState();
}

class _ComplaintMissingState extends State<ComplaintMissing> {

  List<String> itensMenu = ["Minhas divulgações"];
  List<DropdownMenuItem<String>> _listaItensEstado = List();
  String _itemSelecionadoEstado;
  final _controller = StreamController<QuerySnapshot>.broadcast();

  _escolhaMenuItem(String itemEscolhido){

    switch( itemEscolhido ){

      case "Minhas divulgações" :
        push(context, MyComplaintMissing());
        break;
    }
  }

  Future<Stream<QuerySnapshot>> _filtrarAnuncios() async {
    Firestore db = Firestore.instance;
    Query query = db.collection("complaint_missing_public");

    if(_itemSelecionadoEstado != null) {
      query = query.where("estado", isEqualTo: _itemSelecionadoEstado);
    }

    Stream<QuerySnapshot> stream = query.snapshots();
    stream.listen((dados) {
      _controller.add(dados);
     });
  }

  Future<Stream<QuerySnapshot>> _adicionarListenerDenuncias() async {
    Firestore db = Firestore.instance;
    Stream<QuerySnapshot> stream = db
    .collection("complaint_missing_public")
    .snapshots();

    stream.listen((dados) {
      _controller.add(dados);
     });
  }

  @override
  void initState() {
    super.initState();
    _listaItensEstado = Config.getEstados();
    _adicionarListenerDenuncias();
  }

  @override
  Widget build(BuildContext context) {

    var carregandoDados =  Center (
      child: Column(children: <Widget>[
        Text("Carregando desaparecidos"),
        CircularProgressIndicator()
      ],),
    );

    return Scaffold(
      appBar: AppBar(
        title:Text("DESAPARECIDOS"),
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
                      child: Text("Nenhuma divulgação encontrada!", style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),),
                    );
                  }

                  return Expanded(
                    child: ListView.builder(
                      itemCount: querySnapshot.documents.length,
                      itemBuilder: (_, indice) {

                        List<DocumentSnapshot> denuncias = querySnapshot.documents.toList();
                        DocumentSnapshot documentSnapshot =  denuncias[indice];
                        Desaparecidos denuncia = Desaparecidos.fromDocumentSnapshot(documentSnapshot);

                        return ItemComplaintMissing(
                          denuncia: denuncia,
                          onTapItem: () {
                            push(context, DetailsComplaintMissing(denuncia));
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