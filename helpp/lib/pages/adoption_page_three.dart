import 'package:flutter/material.dart';
import 'package:helpp/models/animal.dart';
import 'package:helpp/models/anunciante.dart';
import 'package:helpp/pages/menu_animals.dart';
import 'package:helpp/widgets/app_button.dart';
import 'package:helpp/utils/nav.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';

class AdoptionPageThree extends StatefulWidget {

  Animal animal;
  Anunciante anunciante;
  
  AdoptionPageThree(this.animal, this.anunciante);

  @override
  _AdoptionPageThreeState createState() => _AdoptionPageThreeState();
}

class _AdoptionPageThreeState extends State<AdoptionPageThree> {
  final _formKey = GlobalKey<FormState>();

  File _imagem;
  String _idUsuarioLogado;
  String _emailUsuarioLogado;
  File imagemSelecionada;
  bool _subindoImagem = false;
  String _urlImagemRecuperada;
  
  Future _recuperarImagem(bool camera) async {
    if (camera) {
      imagemSelecionada = await ImagePicker.pickImage(source: ImageSource.camera);
    } else {
      imagemSelecionada = await ImagePicker.pickImage(source: ImageSource.gallery);
    }

    setState(() {
      _imagem = imagemSelecionada;
      if(_imagem != null) {
        _subindoImagem = true;
        _uploadImagem();
      }
    });
  }

  Future _uploadImagem() async {

    //Referenciar arquivo
    FirebaseStorage storage = FirebaseStorage.instance;

    StorageReference pastaRaiz = storage.ref();
    StorageReference arquivo = pastaRaiz
    .child("adoption_animals_imagens")
    .child(_idUsuarioLogado + ".jpg");

    //Fazer upload da imagem
    StorageUploadTask task = arquivo.putFile(_imagem);

    //Controlar progresso do upload
    task.events.listen((StorageTaskEvent storageEvent) {

      if(storageEvent.type == StorageTaskEventType.progress) {
        setState(() {
          _subindoImagem = true;
        });
      } else if(storageEvent.type == StorageTaskEventType.success) {
        setState(() {
          _subindoImagem = false;
        });
      }
    });

    task.onComplete.then((StorageTaskSnapshot snapshot){
      _recuperarUrlImagem(snapshot);

    });
  }

  Future _recuperarUrlImagem(StorageTaskSnapshot snapshot) async {
    String url = await snapshot.ref.getDownloadURL();

    setState(() {
      _urlImagemRecuperada = url;
    });
  }

  _recuperarDadosUsuario()async  {

    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser usuarioLogado = await auth.currentUser();
    _idUsuarioLogado = usuarioLogado.uid;
    _emailUsuarioLogado = usuarioLogado.email;
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
      ),
      
      body: _body(),
    );
  }

  _body() {
    return Form(
      key: _formKey,
      child: Container (
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column (
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
                
              SizedBox(height: 5,),
              
              Text(
                "Imagens do animal",
                style: TextStyle(
                  color: Color(0xFF2196F3),
                  fontSize: 18
                )
              ),

              SizedBox(height: 5,),

              Container(
                padding: EdgeInsets.all(16),
              child: _subindoImagem
              ? CircularProgressIndicator()
              : Container(),
              ),

              SizedBox(height: 5,),

              IconButton(
                icon: Icon(Icons.photo_camera), onPressed: ()  {
                  _recuperarImagem(true);
                }
              ),

              IconButton(
                icon: Icon(Icons.photo), onPressed: ()  {
                  _recuperarImagem(false);
                }
              ),
              
              SizedBox(height: 5,),
              
              _imagem == null
              ? Container (
                child: Text(
                  "Selecione uma imagem",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFFFF0000),
                    fontSize: 18
                  )
                ),
              )
              : Image.file(_imagem),
              _imagem == null
              ? Container()
              : AppButton(
                "FINALIZAR",  
                onPressed: _publishAdoption,
              ),
            ],
          ),
        )
      ),
    );
  }

  void _publishAdoption() async {
    // Validação do formulário
    bool formOk = _formKey.currentState.validate();
    if(!formOk) {
      return;
    }

    String _mensagemErro = "";
    
    Firestore db = Firestore.instance;

    db.collection("animals")
    .document(_emailUsuarioLogado)
    .setData(
      {
        "tipo" : widget.animal.tipo, 
        "sexo" : widget.animal.sexo,
        "porte" : widget.animal.porte,
        "nomeAnimal" : widget.animal.nomeAnimal,
        "idade" : widget.animal.idade,
        "raca" : widget.animal.raca,
        "informacoesAdicionais" : widget.animal.informacoesAdicionais,
        "nome" : widget.anunciante.nome,
        "telefone" : widget.anunciante.telefone,
        "email" : widget.anunciante.email,
        "whatsapp" : widget.anunciante.whatsapp,
        'urlImagem' : _urlImagemRecuperada
      }
    );

    push(context, MenuAnimals());

  }
}