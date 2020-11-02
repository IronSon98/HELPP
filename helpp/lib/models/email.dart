import 'dart:io';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class Email {
  String _username;
  var smtpServer;

  Email(String username, String password) {
    _username = username;
    smtpServer = gmail(_username, password);
  }

  Future<bool> sendMessage(String mensagem, List<File> _listaImagens, String destinatario, String assunto) async {
    
    int i = 0;
    
    final message = Message()
      ..from = Address(_username, 'HELPP')
      ..recipients.add(destinatario)
      ..subject = assunto
      ..text = mensagem;
  
      while(i < _listaImagens.length) {
        message..attachments.add(FileAttachment(_listaImagens[i]));
        i++;
      }

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());

      return true;
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
      return false;
    }
  }
}