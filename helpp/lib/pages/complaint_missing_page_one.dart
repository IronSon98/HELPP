import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:helpp/models/desaparecidos.dart';
import 'package:helpp/pages/complaint_missing_page_two.dart';
import 'package:helpp/widgets/app_button.dart';
import 'package:helpp/widgets/app_text.dart';
import 'package:helpp/utils/nav.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:validadores/validadores.dart';
import 'package:helpp/utils/config.dart';

class ComplaintMissingPageOne extends StatefulWidget {
  @override
  _ComplaintMissingPageOneState createState() => _ComplaintMissingPageOneState();
}

class _ComplaintMissingPageOneState extends State<ComplaintMissingPageOne> {

  Desaparecidos _denuncia;
  final _formKey = GlobalKey<FormState>();

  //Informações do declarante
  final _tNome = TextEditingController();
  final _tCpf = TextEditingController();
  final _tTelefone = TextEditingController();
  final _tEmail = TextEditingController();
  final _tCidade = TextEditingController();

  //Informações do desaparecido
  final _tNomeDoPai = TextEditingController();
  final _tNomeDaMae = TextEditingController();
  final _tNomeDesaparecido = TextEditingController();
  final _tSexo = TextEditingController();
  final _tIdade = TextEditingController();
  final _tDataDoNascimento = TextEditingController();
  final _tCidadeDesaparecido = TextEditingController();

  //Informações do desaparecimento
  final _tLocalDesaparecimento = TextEditingController();
  final _tHoraDesaparecimento = TextEditingController();
  final _tDataDesaparecimento = TextEditingController();

  //Características físicas do desaparecido
  final _tAltura = TextEditingController();
  final _tCorOlhos = TextEditingController();
  final _tCorPele = TextEditingController();
  final _tCorCabelo = TextEditingController();
  final _tOutras = TextEditingController();

  //Informações adicionais
  final _tInformacoesAdicionais  = TextEditingController();

  //Focus
  final _focusCpf = FocusNode();
  final _focusTelefone = FocusNode();
  final _focusEmail = FocusNode();
  final _focusNomeDoPai = FocusNode();
  final _focusNomeDaMae = FocusNode();
  final _focusNomeDesaparecido = FocusNode();
  final _focusSexo = FocusNode();
  final _focusIdade = FocusNode();
  final _focusDataDoNascimento = FocusNode();
  final _focusLocalDesaparecimento = FocusNode();
  final _focusHoraDesaparecimento = FocusNode();
  final _focusDataDesaparecimento = FocusNode();
  final _focusAltura = FocusNode();
  final _focusCorOlhos = FocusNode();
  final _focusCorPele = FocusNode();
  final _focusCorCabelo = FocusNode();
  final _focusOutras = FocusNode();
  final _focusInformacoesAdicionais = FocusNode();

  //Listas
  List<DropdownMenuItem<String>> _listaItensEstado = List();
  String _estadoSelecionado;
  String _estadoDesaparecidoSelecionado;

  @override
  void initState() {
    super.initState();
    _denuncia = Desaparecidos.gerarId();
    _listaItensEstado = Config.getEstados();
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
                        "Informações do declarante",
                        style: TextStyle(
                          color: Color(0xFF2196F3),
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                        )
                      ),

                  SizedBox(height: 30),

                  AppText("Nome*", 
                  "Digite o seu nome", 
                  controller: _tNome, 
                  sizeText: 18,
                  validator: _validarNome,
                  keyboardType: TextInputType.text,
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
                  controller: _tCidade, 
                  sizeText: 18,
                  validator: _validarCidade,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next, 
                  nextFocus: _focusNomeDoPai),
                  
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Divider(
                      color: Color(0xFF2196F3),
                      thickness: 2,
                    ),
                  ),

                  Text(
                        "Informações do desaparecido",
                        style: TextStyle(
                          color: Color(0xFF2196F3),
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                        )
                      ),

                  SizedBox(height: 30),

                  AppText("Nome do pai", 
                  "Digite o nome do pai do desaparecido", 
                  controller: _tNomeDoPai, 
                  sizeText: 18,
                  keyboardType: TextInputType.text,
                  focusNode: _focusNomeDoPai,
                  textInputAction: TextInputAction.next, 
                  nextFocus: _focusNomeDaMae),

                  SizedBox(height: 12,),

                  AppText("Nome da mãe", 
                  "Digite o nome da mãe do desaparecido", 
                  controller: _tNomeDaMae, 
                  sizeText: 18,
                  keyboardType: TextInputType.text,
                  focusNode: _focusNomeDaMae,
                  textInputAction: TextInputAction.next, 
                  nextFocus: _focusNomeDesaparecido),

                  SizedBox(height: 12,),

                  AppText("Nome do desaparecido*", 
                  "Digite o nome do desaparecido", 
                  controller: _tNomeDesaparecido, 
                  sizeText: 18,
                  validator: _validarNomeDesaparecido,
                  keyboardType: TextInputType.text,
                  focusNode: _focusNomeDesaparecido,
                  textInputAction: TextInputAction.next, 
                  nextFocus: _focusSexo),

                  SizedBox(height: 12,),

                  AppText("Sexo*", 
                  "Digite o sexo do desaparecido", 
                  controller: _tSexo, 
                  sizeText: 18,
                  validator: _validarSexo, 
                  keyboardType: TextInputType.text,
                  focusNode: _focusSexo,
                  textInputAction: TextInputAction.next, 
                  nextFocus: _focusIdade),

                  SizedBox(height: 12,),

                  AppText("Idade*", 
                  "Digite a idade do desaparecido", 
                  controller: _tIdade, 
                  sizeText: 18,
                  validator: _validarIdade,
                  keyboardType: TextInputType.number,
                  focusNode: _focusIdade,
                  textInputAction: TextInputAction.next, 
                  nextFocus: _focusDataDoNascimento),

                  SizedBox(height: 12,),

                  AppText("Data de nascimento*", 
                  "Digite a data de nascimento do desaparecido", 
                  controller: _tDataDoNascimento,
                  sizeText: 18,
                  validator: _validarDataDoNascimento,
                  keyboardType: TextInputType.datetime,
                  inputFormatters: [
                    WhitelistingTextInputFormatter.digitsOnly,
                    DataInputFormatter()
                  ],
                  focusNode: _focusDataDoNascimento),

                  SizedBox(height: 12,),

                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: DropdownButtonFormField(
                            value: _estadoDesaparecidoSelecionado,
                            hint: Text("Estado*"),
                            style: TextStyle (
                              color: Color(0xFF2196F3),
                              fontSize: 18
                            ),
                            items: _listaItensEstado,
                            validator: _validarEstadoDesaparecido,
                            onChanged: (valor) {
                              setState(() {
                                _estadoDesaparecidoSelecionado = valor;
                              });
                            }
                          ),
                        ),
                      ),
                    ],
                  ),
         
                  SizedBox(height: 12,),

                  AppText("Município*", 
                  "Digite a cidade natal do desaparecido", 
                  controller: _tCidadeDesaparecido, 
                  sizeText: 18,
                  validator: _validarCidadeDesaparecido,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next, 
                  nextFocus: _focusLocalDesaparecimento),
                  
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Divider(
                      color: Color(0xFF2196F3),
                      thickness: 2,
                    ),
                  ),

                  Text(
                        "Informações do desaparecimento",
                        style: TextStyle(
                          color: Color(0xFF2196F3),
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                        )
                      ),

                  SizedBox(height: 30),

                  AppText("Local do desaparecimento*", 
                  "Digite o local do desaparecimento", 
                  controller: _tLocalDesaparecimento, 
                  sizeText: 18,
                  validator: _validarLocalDesaparecimento,
                  keyboardType: TextInputType.text,
                  focusNode: _focusLocalDesaparecimento,
                  textInputAction: TextInputAction.next, 
                  nextFocus: _focusHoraDesaparecimento),
                  
                  SizedBox(height: 12,),

                   AppText("Hora do desaparecimento*", 
                  "Digite a hora do desaparecimento", 
                  controller: _tHoraDesaparecimento,
                  sizeText: 18,
                  validator: _validarHoraDesaparecimento,
                  keyboardType: TextInputType.datetime,
                  inputFormatters: [
                    WhitelistingTextInputFormatter.digitsOnly,
                    HoraInputFormatter()
                  ],
                  focusNode: _focusHoraDesaparecimento,
                  textInputAction: TextInputAction.next, 
                  nextFocus: _focusDataDesaparecimento),

                  SizedBox(height: 12,),

                  AppText("Data do desaparecimento*", 
                  "Digite a data do desaparecimento", 
                  controller: _tDataDesaparecimento,
                  sizeText: 18,
                  validator: _validarDataDesaparecimento,
                  keyboardType: TextInputType.datetime,
                  inputFormatters: [
                    WhitelistingTextInputFormatter.digitsOnly,
                    DataInputFormatter()
                  ],
                  focusNode: _focusDataDesaparecimento,
                  textInputAction: TextInputAction.next, 
                  nextFocus: _focusAltura),

                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Divider(
                      color: Color(0xFF2196F3),
                      thickness: 2,
                    ),
                  ),

                  Text(
                        "Características físicas do desaparecido",
                        style: TextStyle(
                          color: Color(0xFF2196F3),
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                        )
                      ),

                  SizedBox(height: 30),

                  AppText("Altura", 
                  "Digite a altura do desaparecido", 
                  controller: _tAltura,
                  sizeText: 18,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    WhitelistingTextInputFormatter.digitsOnly,
                    AlturaInputFormatter()
                  ],
                  focusNode: _focusAltura,
                  textInputAction: TextInputAction.next, 
                  nextFocus: _focusCorOlhos),

                  SizedBox(height: 12,),

                  AppText("Cor dos olhos", 
                  "Digite a cor dos olhos do desaparecido", 
                  controller: _tCorOlhos, 
                  sizeText: 18,
                  keyboardType: TextInputType.text,
                  focusNode: _focusCorOlhos,
                  textInputAction: TextInputAction.next, 
                  nextFocus: _focusCorPele),

                  SizedBox(height: 12,),

                  AppText("Cor da pele", 
                  "Digite a cor da pele do desaparecido", 
                  controller: _tCorPele, 
                  sizeText: 18,
                  keyboardType: TextInputType.text,
                  focusNode: _focusCorPele,
                  textInputAction: TextInputAction.next, 
                  nextFocus: _focusCorCabelo),

                  SizedBox(height: 12,),

                  AppText("Cor do cabelo", 
                  "Digite a cor do cabelo do desaparecido", 
                  controller: _tCorCabelo, 
                  sizeText: 18,
                  keyboardType: TextInputType.text,
                  focusNode: _focusCorCabelo,
                  textInputAction: TextInputAction.next, 
                  nextFocus: _focusOutras),

                  SizedBox(height: 12,),

                  AppText("Outras", 
                  "Digite outras características físicas do desaparecido", 
                  controller: _tOutras, 
                  sizeText: 18,
                  keyboardType: TextInputType.text,
                  maxLines: null,
                  focusNode: _focusOutras,
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

    _denuncia.nome = _tNome.text;
    _denuncia.cpf = _tCpf.text.toString();
    _denuncia.telefone = _tTelefone.text.toString();
    _denuncia.email = _tEmail.text;
    _denuncia.estado = _estadoSelecionado;
    _denuncia.cidade = _tCidade.text;
    _denuncia.nomeDoPai = _tNomeDoPai.text;
    _denuncia.nomeDaMae = _tNomeDaMae.text;
    _denuncia.nomeDesaparecido = _tNomeDesaparecido.text;
    _denuncia.sexo = _tSexo.text;
    _denuncia.idade = _tIdade.text;
    _denuncia.dataDoNascimento = _tDataDoNascimento.text.toString();
    _denuncia.estadoDesaparecido = _estadoDesaparecidoSelecionado;
    _denuncia.cidadeDesaparecido = _tCidadeDesaparecido.text;
    _denuncia.localDesaparecimento = _tLocalDesaparecimento.text;
    _denuncia.horaDesaparecimento = _tHoraDesaparecimento.text.toString();
    _denuncia.dataDesaparecimento = _tDataDesaparecimento.text.toString();
    _denuncia.altura = _tAltura.text.toString();
    _denuncia.corOlhos = _tCorOlhos.text;
    _denuncia.corPele = _tCorPele.text;
    _denuncia.corCabelo = _tCorCabelo.text;
    _denuncia.outras = _tOutras.text;
    _denuncia.informacoesAdicionais = _tInformacoesAdicionais.text;
    
    push(context, ComplaintMissingPageTwo(_denuncia));
  }

  String _validarNome(String nome) {
     return Validador()
    .add(Validar.OBRIGATORIO, msg: "Campo obrigatório")
    .valido(nome);
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

  String _validarEstado(String estado) {
     return Validador()
    .add(Validar.OBRIGATORIO, msg: "Campo obrigatório")
    .valido(estado);
  } 

  String _validarCidade(String cidade) {
    return Validador()
    .add(Validar.OBRIGATORIO, msg: "Campo obrigatório")
    .valido(cidade);
  } 

  String _validarNomeDesaparecido(String nomeDesaparecido) {
     return Validador()
    .add(Validar.OBRIGATORIO, msg: "Campo obrigatório")
    .valido(nomeDesaparecido);
  } 

  String _validarSexo(String sexo) {
     return Validador()
    .add(Validar.OBRIGATORIO, msg: "Campo obrigatório")
    .valido(sexo);
  } 

  String _validarIdade(String idade) {
     return Validador()
    .add(Validar.OBRIGATORIO, msg: "Campo obrigatório")
    .valido(idade);
  }

  String _validarDataDoNascimento(String dataDoNascimento) {
     return Validador()
    .add(Validar.OBRIGATORIO, msg: "Campo obrigatório")
    .valido(dataDoNascimento);
  }

  String _validarEstadoDesaparecido(String estadoDesaparecido) {
     return Validador()
    .add(Validar.OBRIGATORIO, msg: "Campo obrigatório")
    .valido(estadoDesaparecido);
  } 

  String _validarCidadeDesaparecido(String cidadeDesaparecido) {
    return Validador()
    .add(Validar.OBRIGATORIO, msg: "Campo obrigatório")
    .valido(cidadeDesaparecido);
  }

  String _validarLocalDesaparecimento(String localDesaparecimento) {
    return Validador()
    .add(Validar.OBRIGATORIO, msg: "Campo obrigatório")
    .valido(localDesaparecimento);
  }  

  String _validarHoraDesaparecimento(String horaDesaparecimento) {
    return Validador()
    .add(Validar.OBRIGATORIO, msg: "Campo obrigatório")
    .valido(horaDesaparecimento);
  }  

  String _validarDataDesaparecimento(String dataDesaparecimento) {
    return Validador()
    .add(Validar.OBRIGATORIO, msg: "Campo obrigatório")
    .valido(dataDesaparecimento);
  }    

}