import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:helpp/models/desaparecidos.dart';
import 'package:helpp/widgets/app_button.dart';
import 'package:image_picker/image_picker.dart';

class ComplaintMissingPageTwo extends StatefulWidget {

   Desaparecidos denuncia;
  
   ComplaintMissingPageTwo(this.denuncia);

  @override
  _ComplaintMissingPageTwoState createState() => _ComplaintMissingPageTwoState();
}

class _ComplaintMissingPageTwoState extends State<ComplaintMissingPageTwo> {

  final _formKey = GlobalKey<FormState>();
  List<File> _listaImagens = List();
  String _emailUsuarioLogado;
  File imagemSelecionada;
  List<String> origemFotos = [];
  BuildContext _dialogContext;

  Future _recuperarImagem(bool camera) async {
    if (camera) {
      imagemSelecionada = await ImagePicker.pickImage(source: ImageSource.camera);
    } else {
      imagemSelecionada = await ImagePicker.pickImage(source: ImageSource.gallery);
    }

    if( imagemSelecionada != null ){
      setState(() {
        _listaImagens.add( imagemSelecionada );
      });
    }
  }

  Future _uploadImagens() async {

    //Referenciar arquivo
    FirebaseStorage storage = FirebaseStorage.instance;
    StorageReference pastaRaiz = storage.ref();

    for(var imagem in _listaImagens) {

      String nomeImagem = DateTime.now().millisecondsSinceEpoch.toString();

      StorageReference arquivo = pastaRaiz
      .child("complaint_missing")
      .child(widget.denuncia.id)
      .child(nomeImagem);

      //Fazer upload da imagem
      StorageUploadTask uploadTask = arquivo.putFile(imagem);
      
      //Controlar progresso do upload
      StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;

      String url = await taskSnapshot.ref.getDownloadURL();
      widget.denuncia.fotos.add(url);
    }
  }

  _recuperarDadosUsuario()async  {

    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser usuarioLogado = await auth.currentUser();
    _emailUsuarioLogado = usuarioLogado.email;
  }

  _abrirDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
            CircularProgressIndicator(),
            SizedBox(height: 20,),
            Text("Enviando divulgação...")
          ],),
        );
      }
    );
  }

  @override
  void initState() {
    super.initState();
    _recuperarDadosUsuario();
  }

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("HELPP",),
        centerTitle: true,
      ),
      
      body: _body(),
    );
  }

  _body() {
    return SingleChildScrollView(
      child: Container (
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column (
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[  

              FormField<List>(
                initialValue: _listaImagens,
                validator: (imagens) {
                  if(imagens.length == 0) {
                    return "Necessário selecionar uma imagem!";
                  }

                  return null;
                },
                builder: (state) {
                  return Column(children: <Widget>[
                    Container(
                      height: 100,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _listaImagens.length + 1,
                        itemBuilder: (context, indice) {
                          if(indice == _listaImagens.length) {
                            return Padding ( 
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: GestureDetector(
                                onTap: () {
                                  _recuperarImagem(false);
                                },
                                child: CircleAvatar(
                                  backgroundColor: Colors.grey[400],
                                  radius: 50,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                    Icon(
                                      Icons.photo,
                                      size: 40,
                                      color: Colors.grey[100],
                                    ),
                                    Text(
                                      "Adicionar",
                                      style: TextStyle(
                                        color: Colors.grey[100]
                                      ),
                                    )
                                  ],),
                                ),
                              ),
                            );
                          }

                          if(_listaImagens.length > 0) {
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: GestureDetector (
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => Dialog(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Image.file(_listaImagens[indice]),
                                          FlatButton(
                                            child: Text("Excluir"),
                                            textColor: Colors.red,
                                            onPressed: () {
                                              setState((){
                                                _listaImagens.removeAt(indice);
                                                Navigator.of(context).pop();
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                child: CircleAvatar(
                                  radius: 50,
                                  backgroundImage: FileImage(_listaImagens[indice]),
                                  child: Container( 
                                    color: Color.fromRGBO(255, 255, 255, 0.4),
                                    alignment: Alignment.center,
                                    child: Icon(Icons.delete, color: Colors.red,),
                                  ),
                                ),
                              ),
                            );
                          }

                          return Container();
                        },
                      ),
                    ),
                    if(state.hasError)
                      Container(
                        child: Text(
                          "[${state.errorText}]",
                          style: TextStyle (
                            color: Colors.red, fontSize: 14
                          ),
                        ),
                      )
                  ],);
                },
              ),

              SizedBox(height: 22,),
              
              AppButton(
                "PUBLICAR",  
                onPressed: _onComplaint,
              ),
            ],
          ),
        )
      ),
    );
  }

  void _onComplaint() async {
    // Validação do formulário
    bool formOk = _formKey.currentState.validate();
    if(!formOk) {
      return;
    }

    //Configura dialog context
    _dialogContext = context;

     _abrirDialog(_dialogContext);

    //Upload imagens no Storage
    await _uploadImagens();

    //Salvar anuncio no Firestore
    Firestore db = Firestore.instance;

    db.collection("complaint_missing")
    .document(_emailUsuarioLogado)
    .collection("minhas_denuncias")
    .document(widget.denuncia.id)
    .setData(
     widget.denuncia.toMap()
    );

    db.collection("complaint_missing_public")
    .document(widget.denuncia.id)
    .setData(
      widget.denuncia.toMap()
    );

    Navigator.pop(_dialogContext);
    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.pop(context);
  }
}