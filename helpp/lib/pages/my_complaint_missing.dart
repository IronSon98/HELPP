import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:helpp/models/desaparecidos.dart';
import 'package:helpp/pages/complaint_missing_page_one.dart';
import 'package:helpp/utils/nav.dart';
import 'package:helpp/widgets/item_complaint_missing.dart';

class MyComplaintMissing extends StatefulWidget {
  @override
  _MyComplaintMissingState createState() => _MyComplaintMissingState();
}

class _MyComplaintMissingState extends State<MyComplaintMissing> {

  final _controller = StreamController<QuerySnapshot>.broadcast();
  String _emailUsuarioLogado;

  Future<Stream<QuerySnapshot>> _adicionarListenerDenuncias() async {

    await _recuperarDadosUsuario();
    
    Firestore db = Firestore.instance;
    Stream<QuerySnapshot> stream = db
    .collection("complaint_missing")
    .document(_emailUsuarioLogado)
    .collection("minhas_denuncias")
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

  _removerDenuncia(String idDenuncia) {
    Firestore db = Firestore.instance;
    db.collection("complaint_missing")
    .document(_emailUsuarioLogado)
    .collection("minhas_denuncias")
    .document(idDenuncia)
    .delete().then((_){
      db.collection("complaint_missing_public")
      .document(idDenuncia)
      .delete();
    });
  }

  _removerImagensDenuncia (Desaparecidos denuncia) async {
    int indice = 0;

    while (denuncia.fotos.length > 0) {
      StorageReference storageReference = await FirebaseStorage.instance.getReferenceFromUrl(denuncia.fotos[indice]);
      await storageReference.delete();
      indice = indice + 1;
    }
  }

  @override
  void initState() {
    super.initState();
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
        title: Text("MINHAS DIVULGAÇÕES"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
        onPressed: (){
          push(context, ComplaintMissingPageOne());
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

                  List<DocumentSnapshot> denuncias = querySnapshot.documents.toList();
                  DocumentSnapshot documentSnapshot =  denuncias[indice];
                  Desaparecidos denuncia = Desaparecidos.fromDocumentSnapshot(documentSnapshot);

                  return ItemComplaintMissing(
                   denuncia: denuncia,
                    onPressedRemover: (){
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Confirmar"),
                            content: Text("Deseja realmente excluir a divulgação?"),
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
                                  _removerDenuncia(denuncia.id);
                                  _removerImagensDenuncia(denuncia);
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
