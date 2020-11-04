import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helpp/models/maustratos.dart';

class DetailsComplaintAnimals extends StatefulWidget {
  Maustratos denuncia;
  DetailsComplaintAnimals(this.denuncia);

  @override
  _DetailsComplaintAnimalsState createState() => _DetailsComplaintAnimalsState();
}

class _DetailsComplaintAnimalsState extends State<DetailsComplaintAnimals> {

  Maustratos _denuncia;

  List<Widget> _getListaImagens() {
    List<String> listaUrlImagens = _denuncia.fotos;
    return listaUrlImagens.map((url){
      return Container(
        height: 250,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(url),
            fit: BoxFit.fill
          )
        ),
      );
    }).toList();
  }

  @override
  void initState() {
    super.initState();

    _denuncia = widget.denuncia;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HELPP"),
        centerTitle: true,
      ),
      body: Stack(children: <Widget>[

        ListView(children: <Widget>[

          if(_denuncia.fotos.length > 0)
            SizedBox(
              height: 250,
              child: Carousel (
                images: _getListaImagens(),
                dotSize: 8,
                dotBgColor: Colors.transparent,
                dotColor: Colors.white,
                autoplay: false,
                dotIncreasedColor: Color(0xFF2196F3),
              ),
            ),
            
          if(_denuncia.fotos.isEmpty)
            SizedBox(
                width: 250,
                height: 250,
                child: Image.asset(
                  "imagens/sem_foto.JPG",
                  fit: BoxFit.cover,
                ),
              ),

          Container(
            padding: EdgeInsets.all(16),
            child: Column (
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
              Text(
                "${_denuncia.tipoDeCrime}",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2196F3)
                ),
              ),

              Text(
                "${_denuncia.dataDoFato}",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Divider(),
              ),

              Text(
                "Endereço da ocorrência",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Text(
                "Tipo de endereço: ${_denuncia.tipoDeEndereco}\n" + 
                "Estado: ${_denuncia.estado}\n" +
                "Município: ${_denuncia.municipio}\n" +
                "Endereço: ${_denuncia.endereco}\n" +
                "Número: ${_denuncia.numero}",
                style: TextStyle(
                  fontSize: 18
                ),
              ),

              if (_denuncia.cep.length > 0)
                Text(
                  "CEP: ${_denuncia.cep}",
                  style: TextStyle(
                    fontSize: 18
                  ),
                ),
        
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Divider(),
              ),

              Text(
                "Informações da ocorrência",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Text(
                "Data do fato: ${_denuncia.dataDoFato}\n" +
                "Hora aproximada: ${_denuncia.horaDoFato}\n" +
                "Relato do fato: ${_denuncia.relatoDoFato}\n" +
                "Classificação do animal: ${_denuncia.classificacaoDoAnimal}\n" +
                "Porte do animal: ${_denuncia.porte}\n" +
                "Quantidade de animais: ${_denuncia.quantidade}\n",
                style: TextStyle(
                  fontSize: 18
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Divider(),
              ),

              Text(
                "Informações do denunciante",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Text(
                "Nome: ${_denuncia.nomeDenunciante}\n" +
                "CPF: ${_denuncia.cpf}\n" +
                "Telefone: ${_denuncia.telefone}\n" +
                "E-mail: ${_denuncia.email}\n" +
                "Estado: ${_denuncia.estadoDenunciante}\n" +
                "Município: ${_denuncia.municipioDenunciante}\n" +
                "Endereço: ${_denuncia.enderecoDenunciante}\n" +
                "Número: ${_denuncia.numeroDenunciante}",
                style: TextStyle(
                  fontSize: 18
                ),
              ),

              if (_denuncia.cepDenunciante.length > 0)
                Text(
                  "CEP: ${_denuncia.cepDenunciante}",
                  style: TextStyle(
                    fontSize: 18
                  ),
                ),

              if (_denuncia.nomeDenunciado.length > 0 || _denuncia.descricao.length > 0)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Divider(),
                ),

              if (_denuncia.nomeDenunciado.length > 0 || _denuncia.descricao.length > 0)
                Text(
                  "Informações do infrator",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                if (_denuncia.nomeDenunciado.length > 0)
                  Text(
                    "Nome: ${_denuncia.nomeDenunciado}",
                    style: TextStyle(
                      fontSize: 18
                    ),
                  ),

                 if (_denuncia.descricao.length > 0)
                  Text(
                    "Descrição: ${_denuncia.descricao}",
                    style: TextStyle(
                      fontSize: 18
                    ),
                  ),

              if(_denuncia.informacoesAdicionais.length > 0) 
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Divider(),
                ),

              if(_denuncia.informacoesAdicionais.length > 0) 
                Text(
                  "Informações adicionais",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "${_denuncia.informacoesAdicionais}\n",
                  style: TextStyle(
                    fontSize: 18
                  ),
                ),
              

            ],),
          )
        ],),
      ],),
    );
  }
}