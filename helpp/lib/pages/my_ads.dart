import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:helpp/models/anuncio.dart';
import 'package:helpp/pages/adoption_page_one.dart';
import 'package:helpp/utils/nav.dart';
import 'package:helpp/widgets/item_ads.dart';

class MyAds extends StatefulWidget {
  @override
  _MyAdsState createState() => _MyAdsState();
}

class _MyAdsState extends State<MyAds> {

  final _controller = StreamController<QuerySnapshot>.broadcast();
  String _emailUsuarioLogado;

  Future<Stream<QuerySnapshot>> _adicionarListenerAnuncios() async {

    await _recuperarDadosUsuario();
    
    Firestore db = Firestore.instance;
    Stream<QuerySnapshot> stream = db
    .collection("adoption_animals")
    .document(_emailUsuarioLogado)
    .collection("meus_anuncios")
    .snapshots();

    stream.listen((dados) {
      _controller.add(dados);
     });
  }

  _recuperarDadosUsuario() async  {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser usuarioLogado = await auth.currentUser();
    _emailUsuarioLogado = usuarioLogado.email;
  }

  _removerAnuncio(String idAnuncio) {
    Firestore db = Firestore.instance;
    db.collection("adoption_animals")
    .document(_emailUsuarioLogado)
    .collection("meus_anuncios")
    .document(idAnuncio)
    .delete().then((_){
      db.collection("adoption_animals_public")
      .document(idAnuncio)
      .delete();
    });
  }

  _removerImagensAnuncio (Anuncio anuncio) async {
    int indice = 0;

    while (anuncio.fotos.length > 0) {
      StorageReference storageReference = await FirebaseStorage.instance.getReferenceFromUrl(anuncio.fotos[indice]);
      await storageReference.delete();
      indice = indice + 1;
    }
    
  }

  @override
  void initState() {
    super.initState();
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
        title: Text("MEUS ANÚNCIOS"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
        onPressed: (){
          push(context, AdoptionPageOne());
        },
      ),
      body: StreamBuilder (
        stream: _controller.stream,
        builder: (context, snapshot) {
          switch(snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return carregandoDados;
              break;
            case ConnectionState.active:
            case ConnectionState.done:

              if(snapshot.hasError)
                return Text("Erro ao carregar os dados!");

              QuerySnapshot querySnapshot = snapshot.data;

              return ListView.builder(
                itemCount: querySnapshot.documents.length,
                itemBuilder: (_, indice) {

                  List<DocumentSnapshot> anuncios = querySnapshot.documents.toList();
                  DocumentSnapshot documentSnapshot =  anuncios[indice];
                  Anuncio anuncio = Anuncio.fromDocumentSnapshot(documentSnapshot);

                  return ItemAds(
                    anuncio: anuncio,
                    onPressedRemover: (){
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Confirmar"),
                            content: Text("Deseja realmente excluir o anúncio?"),
                            actions: <Widget>[
                              FlatButton(
                                color: Color(0xFF2196F3),
                                child: Text(
                                  "Cancelar",
                                  style: TextStyle(
                                    color: Colors.white
                                  ),
                                ),
                                onPressed: (){
                                  Navigator.of(context).pop();
                                }
                              ),

                              FlatButton(
                                color: Colors.red,
                                child: Text(
                                  "Remover",
                                  style: TextStyle(
                                    color: Colors.white
                                  ),
                                ),
                                onPressed: (){
                                  _removerAnuncio(anuncio.id);
                                  _removerImagensAnuncio(anuncio);
                                  Navigator.of(context).pop();
                                }
                              )
                            ]
                          );
                        }
                      );
                    },
                  );
                }
              );
          }
          return Container();
        }
      ),
    );
  }
}
