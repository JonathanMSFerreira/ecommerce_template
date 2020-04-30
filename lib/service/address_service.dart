import 'package:ecommerce_template/model/endereco.dart';
import 'package:http/http.dart' as http;

class ViaCepService {
  static Future<Endereco> fetchCep({String cep}) async {
   // final response = await http.get('https://viacep.com.br/ws/$cep/json/');

    final response = await http.get('https://viacep.com.br/ws/RS/Porto Alegre/Domingos+Jose/json/');
    

    if (response.statusCode == 200) {
      return Endereco.fromJson(response.body);
    } else {
      throw Exception('Requisição inválida!');
    }
  }
}