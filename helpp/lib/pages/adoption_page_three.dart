import 'package:flutter/material.dart';
import 'package:helpp/models/animal.dart';
import 'package:helpp/models/anunciante.dart';
import 'package:helpp/pages/menu_adoption.dart';
import 'package:helpp/widgets/app_button.dart';
import 'package:helpp/utils/nav.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

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
  File imagemSelecionada;
  
  Future _recuperarImagem(bool camera) async {
    if (camera) {
      imagemSelecionada = await ImagePicker.pickImage(source: ImageSource.camera);
    } else {
      imagemSelecionada = await ImagePicker.pickImage(source: ImageSource.gallery);
    }

    setState(() {
      _imagem = imagemSelecionada;
    });
  }

  @override
  void initState() {
    super.initState();
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
          child: Row (
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
                
              SizedBox(height: 5,),
              
              Text(
                "Imagens do animal",
                style: TextStyle(
                  color: Color(0xFF2196F3),
                  fontSize: 18
                )
              ),

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
              
              _imagem == null
              ? Container (
                child: Text(
                  "Selecione uma imagem",
                  style: TextStyle(
                    color: Color(0xFFFF0000),
                    fontSize: 18
                  )
                ),
              )
              : Image.file(_imagem),

              AppButton(
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

    //Referenciar arquivo
    FirebaseStorage storage = FirebaseStorage.instance;

    StorageReference pastaRaiz = storage.ref();
    StorageReference arquivo = pastaRaiz.child("adoption_animals").child("foto1.jpg");

    //Fazer upload da imagem
    arquivo.putFile(_imagem);

    push(context, MenuAdoption());

  }
}