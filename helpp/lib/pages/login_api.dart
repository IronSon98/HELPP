import 'package:http/http.dart' as http;

class LoginApi {
  static Future<bool> login(String cpf, String senha) async {

    var url = 'http://livrowebservices.com.br/rest/login';

    Map parametros = {
      'login' : cpf,
      'senha' : senha,
    };

    var response = await http.post(url, body: parametros);

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    return true;
  }
}