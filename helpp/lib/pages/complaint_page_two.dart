import 'package:flutter/material.dart';
import 'package:helpp/pages/menu_animals.dart';
import 'package:helpp/widgets/app_button.dart';
import 'package:helpp/widgets/app_text.dart';
import 'package:helpp/utils/nav.dart';
import 'package:helpp/models/email.dart';
import 'package:helpp/models/maustratos.dart';

class ComplaintPageTwo extends StatefulWidget {

   Maustratos denuncia;
  
   ComplaintPageTwo(this.denuncia);

  @override
  _ComplaintPageTwoState createState() => _ComplaintPageTwoState();
}

class _ComplaintPageTwoState extends State<ComplaintPageTwo> {
  
  String _text = '';
  var email = Email('helpp.denuncia@gmail.com', 'Anatnas23111998');
  
  final _formKey = GlobalKey<FormState>();

  //Informações da denúncia
  String _mensagem = '';
  String _assunto = '';
  String _destinatario = '';

  @override
  void initState() {
    super.initState();
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
    return Form(
      key: _formKey,
        child: Container (
          padding: EdgeInsets.all(16),
          child: Center (
            child: SingleChildScrollView (
              child: Column (
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  
                  SizedBox(height: 12,),

                  AppButton(
                    "ENVIAR", 
                    onPressed: _onComplaint,
                  ),
                ],
              ),
            ),
          ),
        ),
    );
  }

  void _onComplaint() async {
    // Validação do formulário
    bool formOk = _formKey.currentState.validate();
    if(!formOk) {
      return;
    }

    _mensagem = "ENDEREÇO DA OCORRÊNCIA \n" + 
    "Tipo de endereço: " + widget.denuncia.tipoDeEndereco + "\n" + 
    "Estado:" + widget.denuncia.estado + "\n" +
    "Município: " + widget.denuncia.municipio + "\n" +
    "Endereço: " + widget.denuncia.endereco + "\n" +
    "Número: " + widget.denuncia.numero + "\n" +
    "CEP: " + widget.denuncia.cep + "\n\n" +
    "INFORMAÇÕES DA OCORRÊNCIA \n" +
    "Data do fato: " + widget.denuncia.dataDoFato + "\n" +
    "Hora aproximada: " + widget.denuncia.horaDoFato + "\n" +
    "Relato do fato: " + widget.denuncia.relatoDoFato + "\n" +
    "Tipo de crime: " + widget.denuncia.tipoDeCrime + "\n" +
    "Classificação do animal: " + widget.denuncia.classificacaoDoAnimal + "\n" +
    "Porte do animal: " + widget.denuncia.porte + "\n" +
    "Quantidade de animais: " + widget.denuncia.quantidade + "\n\n"
    "INFORMAÇÕES DO DENUNCIANTE \n" +
    "Nome: " + widget.denuncia.nomeDenunciante + "\n" +
    "CPF: " + widget.denuncia.cpf + "\n" +
    "Telefone: " + widget.denuncia.telefone + "\n" +
    "E-mail: " + widget.denuncia.email + "\n" +
    "Estado: " + widget.denuncia.estadoDenunciante + "\n" +
    "Município: " + widget.denuncia.municipioDenunciante + "\n" +
    "Endereço: " + widget.denuncia.enderecoDenunciante + "\n" +
    "Número: " + widget.denuncia.numeroDenunciante + "\n" +
    "CEP: " + widget.denuncia.cepDenunciante + "\n\n" +
    "INFORMAÇÕES DO INFRATOR \n" + 
    "Nome: " + widget.denuncia.nomeDenunciado + "\n"
    "Descrição: " + widget.denuncia.descricao + "\n\n"
    "INFORMAÇÕES ADICIONAIS \n" +
    widget.denuncia.informacoesAdicionais;

    _assunto = "Denúncia de maus tratos contra animais";
    _destinatario = "ironcsantanafilho@gmail.com";

    _sendEmail(_mensagem, _destinatario, _assunto);
    
    push(context, MenuAnimals());
  }

  void _sendEmail(String mensagem, String destinatario, String assunto) async {
    bool result = await email.sendMessage(mensagem, destinatario, assunto);

    setState(() {
      _text = result ? 'Enviado.' : 'Não enviado.';
    });
  }
}