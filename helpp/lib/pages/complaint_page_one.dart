import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:helpp/models/maustratos.dart';
import 'package:helpp/widgets/app_button.dart';
import 'package:helpp/widgets/app_text.dart';
import 'package:helpp/utils/nav.dart';
import 'package:helpp/models/email.dart';
import 'package:helpp/pages/complaint_page_two.dart';
import 'package:helpp/models/maustratos.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:validadores/validadores.dart';

class ComplaintPageOne extends StatefulWidget {
  @override
  _ComplaintPageOneState createState() => _ComplaintPageOneState();
}

class _ComplaintPageOneState extends State<ComplaintPageOne> {
  
  String _text = '';
  var email = Email('helpp.denuncia@gmail.com', 'Anatnas23111998');
  
  final _formKey = GlobalKey<FormState>();

  //Endereço
  final _tTipoDeEndereco = TextEditingController();
  final _tEstado = TextEditingController();
  final _tMunicipio = TextEditingController();
  final _tEndereco = TextEditingController();
  final _tNumero = TextEditingController();
  final _tCep = TextEditingController();

  //Informações da ocorrência
  final _tDataDoFato = TextEditingController();
  final _tHoraDoFato = TextEditingController();
  final _tRelatoDoFato = TextEditingController();
  final _tTipoDeCrime = TextEditingController();
  final _tClassificacaoDoAnimal = TextEditingController();
  final _tPorte = TextEditingController();
  final _tQuantidade = TextEditingController();

  //Informações do denunciante
  final _tNomeDenunciante = TextEditingController();
  final _tCpf = TextEditingController();
  final _tTelefone = TextEditingController();
  final _tEmail = TextEditingController();
  final _tEstadoDenunciante = TextEditingController();
  final _tMunicipioDenunciante = TextEditingController();
  final _tEnderecoDenunciante = TextEditingController();
  final _tNumeroDenunciante = TextEditingController();
  final _tCepDenunciante = TextEditingController();

  //Informações do denunciado
  final _tNomeDenunciado = TextEditingController();
  final _tDescricao = TextEditingController();

  //Outros
  final _tInformacoesAdicionais = TextEditingController();

  //Focus
  final _focusEstado = FocusNode();
  final _focusMunicipio = FocusNode();
  final _focusEndereco = FocusNode();
  final _focusNumero = FocusNode();
  final _focusCep = FocusNode();
  final _focusDataDoFato = FocusNode();
  final _focusHoraDoFato = FocusNode();
  final _focusRelatoDoFato = FocusNode();
  final _focusTipoDeCrime = FocusNode();
  final _focusClassificacaoDoAnimal = FocusNode();
  final _focusPorte = FocusNode();
  final _focusQuantidade = FocusNode();
  final _focusNomeDenunciante = FocusNode();
  final _focusCpf = FocusNode();
  final _focusTelefone = FocusNode();
  final _focusEmail = FocusNode();
  final _focusEstadoDenunciante = FocusNode();
  final _focusMunicipioDenunciante = FocusNode();
  final _focusEnderecoDenunciante = FocusNode();
  final _focusNumeroDenunciante = FocusNode();
  final _focusCepDenunciante = FocusNode();
  final _focusNomeDenunciado = FocusNode();
  final _focusDescricao = FocusNode();
  final _focusInformacoesAdicionais = FocusNode();

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

                  SizedBox(height: 5,),

                  Text(
                        "Edereço da ocorrência",
                        style: TextStyle(
                          color: Color(0xFF2196F3),
                          fontSize: 18
                        )
                      ),

                  SizedBox(height: 12,),

                  AppText("Tipo de endereço*", 
                  "Selecione o tipo de endereço", 
                  controller: _tTipoDeEndereco, 
                  sizeText: 18,
                  validator: _validarTipoDeEndereco,
                  keyboardType: TextInputType.text, 
                  textInputAction: TextInputAction.next, 
                  nextFocus: _focusEstado),
                  
                  SizedBox(height: 12,),

                  AppText("Estado*", 
                  "Digite o estado", 
                  controller: _tEstado,
                  sizeText: 18, 
                  validator: _validarEstado, 
                  keyboardType: TextInputType.text,
                  focusNode: _focusEstado, 
                  textInputAction: TextInputAction.next, 
                  nextFocus: _focusMunicipio),
                  
                  SizedBox(height: 12,),

                  AppText("Município*", 
                  "Digite o município", 
                  controller: _tMunicipio, 
                  sizeText: 18,
                  validator: _validarMunicipio,
                  keyboardType: TextInputType.text,
                  focusNode: _focusMunicipio,  
                  textInputAction: TextInputAction.next, 
                  nextFocus: _focusEndereco),
                  
                  SizedBox(height: 12,),

                  AppText("Endereço*", 
                  "Digite o endereço", 
                  controller: _tEndereco, 
                  sizeText: 18,
                  validator: _validarEndereco,
                  keyboardType: TextInputType.text,
                  focusNode: _focusEndereco,  
                  textInputAction: TextInputAction.next, 
                  nextFocus: _focusNumero),
                  
                  SizedBox(height: 12,),

                  AppText("Número*", 
                  "Digite o número", 
                  controller: _tNumero,
                  sizeText: 18,
                  validator: _validarNumero,
                  keyboardType: TextInputType.number,
                  focusNode: _focusNumero,
                  textInputAction: TextInputAction.next, 
                  nextFocus: _focusCep),
                  
                  SizedBox(height: 12,),

                  AppText("CEP", 
                  "Digite o CEP", 
                  controller: _tCep,
                  sizeText: 18,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    WhitelistingTextInputFormatter.digitsOnly,
                    CepInputFormatter()
                  ],
                  focusNode: _focusCep,
                  textInputAction: TextInputAction.next, 
                  nextFocus: _focusDataDoFato),
                  
                  SizedBox(height: 12,),

                  Text(
                        "Informações da ocorrência",
                        style: TextStyle(
                          color: Color(0xFF2196F3),
                          fontSize: 18
                        )
                      ),

                  SizedBox(height: 12,),

                  AppText("Data do fato*", 
                  "Digite a data do fato", 
                  controller: _tDataDoFato,
                  sizeText: 18,
                  validator: _validarDataDoFato,
                  keyboardType: TextInputType.datetime,
                  inputFormatters: [
                    WhitelistingTextInputFormatter.digitsOnly,
                    DataInputFormatter()
                  ],
                  focusNode: _focusDataDoFato,
                  textInputAction: TextInputAction.next, 
                  nextFocus: _focusHoraDoFato),

                  SizedBox(height: 12,),

                  AppText("Hora do fato*", 
                  "Digite a hora do fato", 
                  controller: _tHoraDoFato,
                  sizeText: 18,
                  validator: _validarHoraDoFato,
                  keyboardType: TextInputType.datetime,
                  inputFormatters: [
                    WhitelistingTextInputFormatter.digitsOnly,
                    HoraInputFormatter()
                  ],
                  focusNode: _focusHoraDoFato,
                  textInputAction: TextInputAction.next, 
                  nextFocus: _focusRelatoDoFato),

                  SizedBox(height: 12,),

                  AppText("Relato do fato*", 
                  "Digite o relato do fato", 
                  controller: _tRelatoDoFato,
                  sizeText: 18,
                  validator: _validarRelatoDoFato,
                  keyboardType: TextInputType.text,
                  focusNode: _focusRelatoDoFato,
                  textInputAction: TextInputAction.next, 
                  nextFocus: _focusTipoDeCrime),

                  SizedBox(height: 12,),

                  AppText("Tipo do crime*", 
                  "Selecione o tipo do crime", 
                  controller: _tTipoDeCrime,
                  sizeText: 18,
                  validator: _validarTipoDeCrime,
                  keyboardType: TextInputType.text,
                  focusNode: _focusTipoDeCrime,
                  textInputAction: TextInputAction.next, 
                  nextFocus: _focusClassificacaoDoAnimal),

                  SizedBox(height: 12,),

                  AppText("Classificação do animal*", 
                  "Selecione a classificação do animal", 
                  controller: _tClassificacaoDoAnimal,
                  sizeText: 18,
                  validator: _validarClassificacaoDoAnimal,
                  keyboardType: TextInputType.text,
                  focusNode: _focusClassificacaoDoAnimal,
                  textInputAction: TextInputAction.next, 
                  nextFocus: _focusPorte),

                  SizedBox(height: 12,),

                  AppText("Porte*", 
                  "Selecione o porte do animal", 
                  controller: _tPorte,
                  sizeText: 18,
                  validator: _validarPorte,
                  keyboardType: TextInputType.text,
                  focusNode: _focusPorte,
                  textInputAction: TextInputAction.next, 
                  nextFocus: _focusQuantidade),

                  SizedBox(height: 12,),

                  AppText("Quantidade*", 
                  "Digite a quantidade de animais", 
                  controller: _tQuantidade,
                  sizeText: 18,
                  validator: _validarQuantidade,
                  keyboardType: TextInputType.number,
                  focusNode: _focusQuantidade,
                  textInputAction: TextInputAction.next, 
                  nextFocus: _focusNomeDenunciante),

                  SizedBox(height: 12,),

                  Text(
                        "Informações do denunciante",
                        style: TextStyle(
                          color: Color(0xFF2196F3),
                          fontSize: 18
                        )
                      ),

                  SizedBox(height: 12,),

                  AppText("Nome*", 
                  "Digite seu nome", 
                  controller: _tNomeDenunciante,
                  sizeText: 18,
                  validator: _validarNomeDenunciante,
                  keyboardType: TextInputType.text,
                  focusNode: _focusNomeDenunciante,
                  textInputAction: TextInputAction.next, 
                  nextFocus: _focusCpf),

                  SizedBox(height: 12,),

                  AppText("CPF*", 
                  "Digite seu CPF", 
                  controller: _tCpf,
                  sizeText: 18,
                  validator: _validarCpf,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    WhitelistingTextInputFormatter.digitsOnly,
                    CpfInputFormatter()
                  ],
                  focusNode: _focusCpf,
                  textInputAction: TextInputAction.next, 
                  nextFocus: _focusTelefone),

                  SizedBox(height: 12,),

                  AppText("Telefone*", 
                  "Digite seu telefone", 
                  controller: _tTelefone,
                  sizeText: 18,
                  validator: _validarTelefone,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    WhitelistingTextInputFormatter.digitsOnly,
                    TelefoneInputFormatter()
                  ],
                  focusNode: _focusTelefone,
                  textInputAction: TextInputAction.next, 
                  nextFocus: _focusEmail),

                  SizedBox(height: 12,),

                  AppText("E-mail*", 
                  "Digite seu e-mail", 
                  controller: _tEmail,
                  sizeText: 18,
                  validator: _validarEmail,
                  keyboardType: TextInputType.emailAddress,
                  focusNode: _focusEmail,
                  textInputAction: TextInputAction.next, 
                  nextFocus: _focusEstadoDenunciante),

                  SizedBox(height: 12,),

                  AppText("Estado*", 
                  "Digite o estado que você mora", 
                  controller: _tEstadoDenunciante,
                  sizeText: 18, 
                  validator: _validarEstadoDenunciante, 
                  keyboardType: TextInputType.text,
                  focusNode: _focusEstadoDenunciante, 
                  textInputAction: TextInputAction.next, 
                  nextFocus: _focusMunicipioDenunciante),
                  
                  SizedBox(height: 12,),

                  AppText("Município*", 
                  "Digite o município que você mora", 
                  controller: _tMunicipioDenunciante, 
                  sizeText: 18,
                  validator: _validarMunicipioDenunciante,
                  keyboardType: TextInputType.text,
                  focusNode: _focusMunicipioDenunciante,  
                  textInputAction: TextInputAction.next, 
                  nextFocus: _focusEnderecoDenunciante),
                  
                  SizedBox(height: 12,),

                  AppText("Endereço*", 
                  "Digite o seu endereço", 
                  controller: _tEnderecoDenunciante, 
                  sizeText: 18,
                  validator: _validarEnderecoDenunciante,
                  keyboardType: TextInputType.text,
                  focusNode: _focusEnderecoDenunciante,  
                  textInputAction: TextInputAction.next, 
                  nextFocus: _focusNumeroDenunciante),
                  
                  SizedBox(height: 12,),

                  AppText("Número*", 
                  "Digite o número do seu endereço", 
                  controller: _tNumeroDenunciante,
                  sizeText: 18,
                  validator: _validarNumeroDenunciante,
                  keyboardType: TextInputType.number,
                  focusNode: _focusNumeroDenunciante,
                  textInputAction: TextInputAction.next, 
                  nextFocus: _focusCepDenunciante),
                  
                  SizedBox(height: 12,),

                  AppText("CEP", 
                  "Digite o seu CEP", 
                  controller: _tCepDenunciante,
                  sizeText: 18,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    WhitelistingTextInputFormatter.digitsOnly,
                    CepInputFormatter()
                  ],
                  focusNode: _focusCepDenunciante,
                  textInputAction: TextInputAction.next, 
                  nextFocus: _focusNomeDenunciado),
                  
                  SizedBox(height: 12,),

                  Text(
                        "Informações do infrator",
                        style: TextStyle(
                          color: Color(0xFF2196F3),
                          fontSize: 18
                        )
                      ),

                  SizedBox(height: 12,),

                  AppText("Nome", 
                  "Digite o nome do infrator", 
                  controller: _tNomeDenunciado,
                  sizeText: 18,
                  keyboardType: TextInputType.text,
                  focusNode: _focusNomeDenunciado,
                  textInputAction: TextInputAction.next, 
                  nextFocus: _focusDescricao),

                  SizedBox(height: 12,),

                  AppText("Descrição", 
                  "Descreva o infrator", 
                  controller: _tDescricao,
                  sizeText: 18,
                  keyboardType: TextInputType.text,
                  focusNode: _focusDescricao,
                  textInputAction: TextInputAction.next, 
                  nextFocus: _focusInformacoesAdicionais),

                  SizedBox(height: 12,),

                  AppText("Informações adicionais", 
                  "Digite informações adicionais", 
                  controller: _tInformacoesAdicionais, 
                  sizeText: 18,
                  keyboardType: TextInputType.text,
                  focusNode: _focusInformacoesAdicionais),
                  
                  SizedBox(height: 22,),

                  AppButton(
                    "PRÓXIMO", 
                    onPressed: _onNextPage,
                  ),
                ],
              ),
            ),
          ),
        ),
    );
  }

  void _onNextPage() async {
    // Validação do formulário
    bool formOk = _formKey.currentState.validate();
    if(!formOk) {
      return;
    }

    Maustratos denuncia = new Maustratos();

    denuncia.tipoDeEndereco = _tTipoDeEndereco.text;
    denuncia.estado = _tEstado.text;
    denuncia.municipio = _tMunicipio.text;
    denuncia.endereco = _tEndereco.text;
    denuncia.numero = _tNumero.text;
    denuncia.cep = _tCep.text.toString();

    denuncia.dataDoFato = _tDataDoFato.text.toString();
    denuncia.horaDoFato = _tHoraDoFato.text.toString();
    denuncia.relatoDoFato = _tRelatoDoFato.text;
    denuncia.tipoDeCrime = _tTipoDeCrime.text;
    denuncia.classificacaoDoAnimal = _tClassificacaoDoAnimal.text;
    denuncia.porte = _tPorte.text;
    denuncia.quantidade = _tQuantidade.text;

    denuncia.nomeDenunciante = _tNomeDenunciante.text;
    denuncia.cpf = _tCpf.text.toString();
    denuncia.telefone = _tTelefone.text.toString();
    denuncia.email = _tEmail.text;
    denuncia.estadoDenunciante = _tEstadoDenunciante.text;
    denuncia.municipioDenunciante = _tMunicipioDenunciante.text;
    denuncia.enderecoDenunciante = _tEnderecoDenunciante.text;
    denuncia.numeroDenunciante = _tNumeroDenunciante.text;
    denuncia.cepDenunciante = _tCepDenunciante.text.toString();

    denuncia.nomeDenunciado = _tNomeDenunciado.text;
    denuncia.descricao = _tDescricao.text;

    denuncia.informacoesAdicionais = _tInformacoesAdicionais.text;
    
    push(context, ComplaintPageTwo(denuncia));
  }

  String _validarTipoDeEndereco(String tipoDeEndereco) {
    return Validador()
    .add(Validar.OBRIGATORIO, msg: "Campo obrigatório")
    .valido(tipoDeEndereco);
  } 
  
  String _validarEstado(String estado) {
     return Validador()
    .add(Validar.OBRIGATORIO, msg: "Campo obrigatório")
    .valido(estado);
  } 

  String _validarMunicipio(String estado) {
    return Validador()
    .add(Validar.OBRIGATORIO, msg: "Campo obrigatório")
    .valido(estado);
  } 

  String _validarEndereco(String endereco) {
     return Validador()
    .add(Validar.OBRIGATORIO, msg: "Campo obrigatório")
    .valido(endereco);
  }

  String _validarNumero(String numero) {
     return Validador()
    .add(Validar.OBRIGATORIO, msg: "Campo obrigatório")
    .valido(numero);
  }

    String _validarDataDoFato(String dataDoFato) {
    return Validador()
    .add(Validar.OBRIGATORIO, msg: "Campo obrigatório")
    .valido(dataDoFato);
  } 
  
  String _validarHoraDoFato(String horaDoFato) {
     return Validador()
    .add(Validar.OBRIGATORIO, msg: "Campo obrigatório")
    .valido(horaDoFato);
  } 

  String _validarRelatoDoFato(String relatoDoFato) {
     return Validador()
    .add(Validar.OBRIGATORIO, msg: "Campo obrigatório")
    .valido(relatoDoFato);
  } 

  String _validarTipoDeCrime(String tipoDeCrime) {
    return Validador()
    .add(Validar.OBRIGATORIO, msg: "Campo obrigatório")
    .valido(tipoDeCrime);
  }

  String _validarClassificacaoDoAnimal(String classificacaoDoAnimal) {
     return Validador()
    .add(Validar.OBRIGATORIO, msg: "Campo obrigatório")
    .valido(classificacaoDoAnimal);
  }

  String _validarPorte(String porte) {
    return Validador()
    .add(Validar.OBRIGATORIO, msg: "Campo obrigatório")
    .valido(porte);
  }

  String _validarQuantidade(String quantidade) {
     return Validador()
    .add(Validar.OBRIGATORIO, msg: "Campo obrigatório")
    .valido(quantidade);
  }

  String _validarNomeDenunciante(String nomeDenunciante) {
     return Validador()
    .add(Validar.OBRIGATORIO, msg: "Campo obrigatório")
    .valido(nomeDenunciante);
  }

  String _validarCpf(String cpf) {
     return Validador()
    .add(Validar.OBRIGATORIO, msg: "Campo obrigatório")
    .add(Validar.CPF, msg: "CPF inválido")
    .minLength(11)
    .maxLength(11)
    .valido(cpf);
  }

  String _validarTelefone(String telefone) {
     return Validador()
    .add(Validar.OBRIGATORIO, msg: "Campo obrigatório")
    .valido(telefone);
  }

  String _validarEmail(String email) {
   return Validador()
    .add(Validar.OBRIGATORIO, msg: "Campo obrigatório")
    .add(Validar.EMAIL, msg: "E-mail inválido")
    .valido(email);
  } 

  String _validarEstadoDenunciante(String estadoDenunciante) {
    return Validador()
    .add(Validar.OBRIGATORIO, msg: "Campo obrigatório")
    .valido(estadoDenunciante);
  } 

  String _validarMunicipioDenunciante(String municipioDenunciante) {
    return Validador()
    .add(Validar.OBRIGATORIO, msg: "Campo obrigatório")
    .valido(municipioDenunciante);
  } 

  String _validarEnderecoDenunciante(String enderecoDenunciante) {
     return Validador()
    .add(Validar.OBRIGATORIO, msg: "Campo obrigatório")
    .valido(enderecoDenunciante);
  }

  String _validarNumeroDenunciante(String numeroDenunciante) {
    return Validador()
    .add(Validar.OBRIGATORIO, msg: "Campo obrigatório")
    .valido(numeroDenunciante);
  }

}