import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:helpp/models/maustratos.dart';
import 'package:helpp/widgets/app_button.dart';
import 'package:helpp/widgets/app_text.dart';
import 'package:helpp/utils/nav.dart';
import 'package:helpp/models/email.dart';
import 'package:helpp/pages/complaint_animals_page_two.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:validadores/validadores.dart';
import 'package:helpp/utils/config.dart';

class ComplaintAnimalsPageOne extends StatefulWidget {
  @override
  _ComplaintAnimalsPageOneState createState() => _ComplaintAnimalsPageOneState();
}

class _ComplaintAnimalsPageOneState extends State<ComplaintAnimalsPageOne> {

  Maustratos _denuncia;
  
  String _text = '';
  var email = Email('helpp.denuncia@gmail.com', 'Anatnas23111998');
  
  final _formKey = GlobalKey<FormState>();

  //Endereço
  final _tMunicipio = TextEditingController();
  final _tEndereco = TextEditingController();
  final _tNumero = TextEditingController();
  final _tCep = TextEditingController();

  //Informações da ocorrência
  final _tDataDoFato = TextEditingController();
  final _tHoraDoFato = TextEditingController();
  final _tRelatoDoFato = TextEditingController();
  final _tQuantidade = TextEditingController();

  //Informações do denunciante
  final _tNomeDenunciante = TextEditingController();
  final _tCpf = TextEditingController();
  final _tTelefone = TextEditingController();
  final _tEmail = TextEditingController();
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
  final _focusEndereco = FocusNode();
  final _focusNumero = FocusNode();
  final _focusCep = FocusNode();
  final _focusDataDoFato = FocusNode();
  final _focusHoraDoFato = FocusNode();
  final _focusRelatoDoFato = FocusNode();
  final _focusNomeDenunciante = FocusNode();
  final _focusCpf = FocusNode();
  final _focusTelefone = FocusNode();
  final _focusEmail = FocusNode();
  final _focusEnderecoDenunciante = FocusNode();
  final _focusNumeroDenunciante = FocusNode();
  final _focusCepDenunciante = FocusNode();
  final _focusNomeDenunciado = FocusNode();
  final _focusDescricao = FocusNode();
  final _focusInformacoesAdicionais = FocusNode();

  //Listas
  List<DropdownMenuItem<String>> _listaItensEstado = List();
  String _estadoSelecionado;
  String _estadoDenuncianteSelecionado;
  List<DropdownMenuItem<String>> _listaItensTipoDeEndereco = List();
  String _tipoDeEnderecoSelecionado;
  List<DropdownMenuItem<String>> _listaItensPorte = List();
  String _porteSelecionado;
  List<DropdownMenuItem<String>> _listaItensClassificacao = List();
  String _classificacaoSelecionada;
  List<DropdownMenuItem<String>> _listaItensTipoDeCrime = List();
  String _tipoDeCrimeSelecionado;

  @override
  void initState() {
    super.initState();
    _denuncia = Maustratos.gerarId();
    _listaItensEstado = Config.getEstados();
    _listaItensTipoDeEndereco = Config.getTiposDeEnderecos();
    _listaItensPorte = Config.getPortes();
    _listaItensClassificacao = Config.getClassificacoes();
    _listaItensTipoDeCrime = Config.getTiposDeCrimes();
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
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                        )
                      ),

                  SizedBox(height: 12,),

                  Row (
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: DropdownButtonFormField(
                            value: _tipoDeEnderecoSelecionado,
                            hint: Text("Tipo de endereço*"),
                            style: TextStyle (
                              color: Color(0xFF2196F3),
                              fontSize: 18
                            ),
                            items: _listaItensTipoDeEndereco,
                            validator: _validarTipoDeEndereco,
                            onChanged: (valor) {
                              setState(() {
                                _tipoDeEnderecoSelecionado = valor;
                              });
                            }
                          ),
                        ),
                      ),
                    ],),

                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: DropdownButtonFormField(
                            value: _estadoSelecionado,
                            hint: Text("Estado*"),
                            style: TextStyle (
                              color: Color(0xFF2196F3),
                              fontSize: 18
                            ),
                            items: _listaItensEstado,
                            validator: _validarEstado,
                            onChanged: (valor) {
                              setState(() {
                                _estadoSelecionado = valor;
                              });
                            }
                          ),
                        ),
                      ),
                    ],
                  ),
         
                  SizedBox(height: 12,),

                  AppText("Município*", 
                  "Digite o município", 
                  controller: _tMunicipio, 
                  sizeText: 18,
                  validator: _validarMunicipio,
                  keyboardType: TextInputType.text,
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
                  
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Divider(
                      color: Color(0xFF2196F3),
                      thickness: 2,
                    ),
                  ),

                  Text(
                        "Informações da ocorrência",
                        style: TextStyle(
                          color: Color(0xFF2196F3),
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                        )
                      ),

                  SizedBox(height: 30),

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
                  maxLines: null,
                  focusNode: _focusRelatoDoFato),

                  SizedBox(height: 12,),

                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: DropdownButtonFormField(
                            value: _tipoDeCrimeSelecionado,
                            hint: Text("Tipo de crime*"),
                            style: TextStyle (
                              color: Color(0xFF2196F3),
                              fontSize: 18
                            ),
                            items: _listaItensTipoDeCrime,
                            validator: _validarTipoDeCrime,
                            onChanged: (valor) {
                              setState(() {
                                _tipoDeCrimeSelecionado = valor;
                              });
                            }
                          ),
                        ),
                      ),
                    ]
                  ),

                  SizedBox(height: 12,),

                  Row (
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: DropdownButtonFormField(
                            value: _classificacaoSelecionada,
                            hint: Text("Classificação do animal*"),
                            style: TextStyle (
                              color: Color(0xFF2196F3),
                              fontSize: 18
                            ),
                            items: _listaItensClassificacao,
                            validator: _validarClassificacaoDoAnimal,
                            onChanged: (valor) {
                              setState(() {
                                _classificacaoSelecionada = valor;
                              });
                            }
                          ),
                        ),
                      ),
                    ],
                  ),

                  Row (
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: DropdownButtonFormField(
                            value: _porteSelecionado,
                            hint: Text("Porte*"),
                            style: TextStyle (
                              color: Color(0xFF2196F3),
                              fontSize: 18
                            ),
                            items: _listaItensPorte,
                            validator: _validarPorte,
                            onChanged: (valor) {
                              setState(() {
                               _porteSelecionado = valor;
                              });
                            }
                          ),
                        ),
                      ),
                    ]
                  ),

                  SizedBox(height: 12,),

                  AppText("Quantidade*", 
                  "Digite a quantidade de animais", 
                  controller: _tQuantidade,
                  sizeText: 18,
                  validator: _validarQuantidade,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next, 
                  nextFocus: _focusNomeDenunciante),

                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Divider(
                      color: Color(0xFF2196F3),
                      thickness: 2,
                    ),
                  ),

                  Text(
                        "Informações do denunciante",
                        style: TextStyle(
                          color: Color(0xFF2196F3),
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                        )
                      ),

                  SizedBox(height: 30),

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
                  focusNode: _focusEmail),

                  SizedBox(height: 12,),

                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: DropdownButtonFormField(
                            value: _estadoDenuncianteSelecionado,
                            hint: Text("Estado*"),
                            style: TextStyle (
                              color: Color(0xFF2196F3),
                              fontSize: 18
                            ),
                            items: _listaItensEstado,
                            validator: _validarEstadoDenunciante,
                            onChanged: (valor) {
                              setState(() {
                                _estadoDenuncianteSelecionado = valor;
                              });
                            }
                          ),
                        ),
                      ),
                    ]

                  ),

                  SizedBox(height: 12,),

                  AppText("Município*", 
                  "Digite o município que você mora", 
                  controller: _tMunicipioDenunciante, 
                  sizeText: 18,
                  validator: _validarMunicipioDenunciante,
                  keyboardType: TextInputType.text, 
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
                  
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Divider(
                      color: Color(0xFF2196F3),
                      thickness: 2,
                    ),
                  ),

                  Text(
                        "Informações do infrator",
                        style: TextStyle(
                          color: Color(0xFF2196F3),
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                        )
                      ),

                  SizedBox(height: 30),

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

                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Divider(
                      color: Color(0xFF2196F3),
                      thickness: 2,
                    ),
                  ),

                   Text(
                        "Informações adicionais",
                        style: TextStyle(
                          color: Color(0xFF2196F3),
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                        )
                      ),

                  SizedBox(height: 30),


                  AppText("Informações adicionais", 
                  "Digite informações adicionais", 
                  controller: _tInformacoesAdicionais, 
                  sizeText: 18,
                  keyboardType: TextInputType.text,
                  maxLines: null,
                  focusNode: _focusInformacoesAdicionais),
                  
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Divider(
                      color: Color(0xFF2196F3),
                      thickness: 2,
                    ),
                  ),

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

    _denuncia.tipoDeEndereco = _tipoDeEnderecoSelecionado;
    _denuncia.estado = _estadoSelecionado;
    _denuncia.municipio = _tMunicipio.text;
    _denuncia.endereco = _tEndereco.text;
    _denuncia.numero = _tNumero.text;
    _denuncia.cep = _tCep.text.toString();

    _denuncia.dataDoFato = _tDataDoFato.text.toString();
    _denuncia.horaDoFato = _tHoraDoFato.text.toString();
    _denuncia.relatoDoFato = _tRelatoDoFato.text;
    _denuncia.tipoDeCrime = _tipoDeCrimeSelecionado;
    _denuncia.classificacaoDoAnimal = _classificacaoSelecionada;
    _denuncia.porte = _porteSelecionado;
    _denuncia.quantidade = _tQuantidade.text;

    _denuncia.nomeDenunciante = _tNomeDenunciante.text;
    _denuncia.cpf = _tCpf.text.toString();
    _denuncia.telefone = _tTelefone.text.toString();
    _denuncia.email = _tEmail.text;
    _denuncia.estadoDenunciante = _estadoDenuncianteSelecionado;
    _denuncia.municipioDenunciante = _tMunicipioDenunciante.text;
    _denuncia.enderecoDenunciante = _tEnderecoDenunciante.text;
    _denuncia.numeroDenunciante = _tNumeroDenunciante.text;
    _denuncia.cepDenunciante = _tCepDenunciante.text.toString();

    _denuncia.nomeDenunciado = _tNomeDenunciado.text;
    _denuncia.descricao = _tDescricao.text;

    _denuncia.informacoesAdicionais = _tInformacoesAdicionais.text;
    
    push(context, ComplaintAnimalsPageTwo(_denuncia));
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

  String _validarMunicipio(String municipio) {
    return Validador()
    .add(Validar.OBRIGATORIO, msg: "Campo obrigatório")
    .valido(municipio);
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
    .minLength(14)
    .maxLength(14)
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