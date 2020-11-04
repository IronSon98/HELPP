import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:helpp/widgets/app_button.dart';
import 'package:helpp/models/email.dart';
import 'package:helpp/models/maustratos.dart';
import 'package:image_picker/image_picker.dart';

class ComplaintAnimalsPageTwo extends StatefulWidget {

   Maustratos denuncia;
  
   ComplaintAnimalsPageTwo(this.denuncia);

  @override
  _ComplaintAnimalsPageTwoState createState() => _ComplaintAnimalsPageTwoState();
}

class _ComplaintAnimalsPageTwoState extends State<ComplaintAnimalsPageTwo> {

  final _formKey = GlobalKey<FormState>();
  String _text = '';
  var email = Email('helpp.denuncia@gmail.com', 'Anatnas23111998');
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
      .child("complaint_animals")
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
            Text("Enviando denúncia...")
          ],),
        );
      }
    );
  }

  //Informações da denúncia
  String _mensagem = '';
  String _assunto = '';
  String _destinatario = '';

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
                "DENUNCIAR",  
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

    db.collection("complaint_animals")
    .document(_emailUsuarioLogado)
    .collection("denuncias")
    .document(widget.denuncia.id)
    .setData(
     widget.denuncia.toMap()
    );

    _mensagem = "ENDEREÇO DA OCORRÊNCIA \n" + 
    "Tipo de endereço: " + widget.denuncia.tipoDeEndereco + "\n" + 
    "Estado:" + widget.denuncia.estado + "\n" +
    "Município: " + widget.denuncia.municipio + "\n" +
    "Endereço: " + widget.denuncia.endereco + "\n" +
    "Número: " + widget.denuncia.numero + "\n";
    if(widget.denuncia.cep.length > 0)
      _mensagem = _mensagem + "CEP: " + widget.denuncia.cep + "\n";

    _mensagem = _mensagem + "\n" + "INFORMAÇÕES DA OCORRÊNCIA \n" +
    "Data do fato: " + widget.denuncia.dataDoFato + "\n" +
    "Hora aproximada: " + widget.denuncia.horaDoFato + "\n" +
    "Relato do fato: " + widget.denuncia.relatoDoFato + "\n" +
    "Tipo de crime: " + widget.denuncia.tipoDeCrime + "\n" +
    "Classificação do animal: " + widget.denuncia.classificacaoDoAnimal + "\n" +
    "Porte do animal: " + widget.denuncia.porte + "\n" +
    "Quantidade de animais: " + widget.denuncia.quantidade + "\n";

    _mensagem = _mensagem + "\n" + "INFORMAÇÕES DO DENUNCIANTE \n" +
    "Nome: " + widget.denuncia.nomeDenunciante + "\n" +
    "CPF: " + widget.denuncia.cpf + "\n" +
    "Telefone: " + widget.denuncia.telefone + "\n" +
    "E-mail: " + widget.denuncia.email + "\n" +
    "Estado: " + widget.denuncia.estadoDenunciante + "\n" +
    "Município: " + widget.denuncia.municipioDenunciante + "\n" +
    "Endereço: " + widget.denuncia.enderecoDenunciante + "\n" +
    "Número: " + widget.denuncia.numeroDenunciante + "\n";
    if(widget.denuncia.cepDenunciante.length > 0)
      _mensagem = _mensagem + "CEP: " + widget.denuncia.cepDenunciante + "\n";

    if(widget.denuncia.nomeDenunciado.length > 0 || widget.denuncia.descricao.length > 0)
      _mensagem = _mensagem + "\n" + "INFORMAÇÕES DO INFRATOR \n";

    if(widget.denuncia.nomeDenunciado.length > 0) 
      _mensagem = _mensagem + "Nome: " + widget.denuncia.nomeDenunciado + "\n";

    if(widget.denuncia.descricao.length > 0)
      _mensagem = _mensagem + "Descrição: " + widget.denuncia.descricao + "\n";

    if(widget.denuncia.informacoesAdicionais.length > 0)
      _mensagem = _mensagem + "\n" + "INFORMAÇÕES ADICIONAIS \n" + widget.denuncia.informacoesAdicionais + "\n";

    _mensagem = _mensagem + "\n" + "OBS.: PRÓXIMAS INFORMAÇÕES REFERENTE A ESSA DENÚNCIA, ENVIAR PARA O E-MAIL DO DENUNCIANTE!";

    _assunto = "Denúncia de maus tratos contra animais";
    _destinatario = "ironcsantanafilho@gmail.com";

    _sendEmail(_mensagem, _listaImagens, _destinatario, _assunto);

    Navigator.pop(_dialogContext);
    Navigator.pop(context);
    Navigator.pop(context);
  }

  void _sendEmail(String mensagem, List<File> _listaImagens, String destinatario, String assunto) async {
    bool result = await email.sendMessage(mensagem, _listaImagens, destinatario, assunto);

    if(!mounted) return;

    setState(() {
      _text = result ? 'Enviado.' : 'Não enviado.';
    });
  }
}