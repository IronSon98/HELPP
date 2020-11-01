import 'package:flutter/material.dart';
import 'package:helpp/models/maustratos.dart';

class ItemComplaintAnimals extends StatelessWidget {

  Maustratos denuncia;
  VoidCallback onTapItem;

  ItemComplaintAnimals(
    {
      @required this.denuncia,
      this.onTapItem,
    }
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onTapItem,
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Row(children: <Widget>[
            SizedBox(
              width: 120,
              height: 120,
              child: Image.network(
                denuncia.fotos[0],
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                  Text(
                    denuncia.tipoDeCrime,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Text(
                    denuncia.dataDoFato
                  ),
                ],)
              )
            ),
          ],)
        )
      )
    );
  }
}