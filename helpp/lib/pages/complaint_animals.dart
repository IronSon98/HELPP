import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:helpp/models/maustratos.dart';
import 'package:helpp/pages/complaint_animals_page_one.dart';
import 'package:helpp/pages/details_complaint_animals.dart';
import 'package:helpp/utils/nav.dart';
import 'package:helpp/widgets/item_complaint_animals.dart';

class ComplaintAnimals extends StatefulWidget {
  @override
  _ComplaintAnimalsState createState() => _ComplaintAnimalsState();
}

class _ComplaintAnimalsState extends State<ComplaintAnimals> {
  
  final _controller = StreamController<QuerySnapshot>.broadcast();
  String _emailUsuarioLogado;

  Future<Stream<QuerySnapshot>> _adicionarListenerDenuncias() async {

    await _recuperarDadosUsuario();
    
    Firestore db = Firestore.instance;
    Stream<QuerySnapshot> stream = db
    .collection("complaint_animals")
    .document(_emailUsuarioLogado)
    .collection("denuncias")
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

  @override
  void initState() {
    super.initState();
    _adicionarListenerDenuncias();
  }

  @override
  Widget build(BuildContext context) {

    var carregandoDados =  Center (
      child: Column(children: <Widget>[
        Text("Carregando denúncias"),
        CircularProgressIndicator()
      ],),
    );

    return Scaffold(
      appBar: AppBar(
        title:Text("MINHAS DENÚNCIAS",),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
        onPressed: (){
          push(context, ComplaintAnimalsPageOne());
        },
      ),
      body: Container(
        child: Column (
          children: <Widget>[
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
                        child: Text("Nenhuma denúncia disponível!", style: TextStyle(
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
                          Maustratos denuncia = Maustratos.fromDocumentSnapshot(documentSnapshot);

                          return ItemComplaintAnimals(
                            denuncia: denuncia,
                            onTapItem: () {
                              push(context, DetailsComplaintAnimals(denuncia));
                            },
                          );

                        }
                      ),
                    );
                }
                return Container();
              }
            ),
          ],
        )
      )
    );
  }
} 