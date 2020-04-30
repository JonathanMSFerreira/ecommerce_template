import 'dart:convert';
import 'dart:convert' as convert;
import 'package:ecommerce_template/model/usuario.dart';
import 'package:ecommerce_template/repository/response_repository.dart';
import 'package:ecommerce_template/utils/constants.dart';
import 'package:http/http.dart' as http;


class ClienteRepository{


  static Future<ResponseRepository<Usuario>> login(String login, String senha) async {


    try{

       var url =  URL_BASE + '/api/v1/login';
       Map<String, String> headers = {
        "Content-Type": "application/json"
      };

      Map params = {
        "username": login,
        "password" : senha
      };

      String s = json.encode(params);
      var response = await http.post(url, body: s, headers: headers);

      Map mapResponse = json.decode(response.body);

      if(response.statusCode == 200){
        final user =  Usuario.fromJson(mapResponse);

        return ResponseRepository.ok(user);
      }

      return ResponseRepository.error(mapResponse["error"]);

    }catch(e){
      return ResponseRepository.error("Erro ao fazer login!");
    }

}

  static Future<List<Usuario>> getAllClientes() async {

    // Usuario user = await Usuario.get();

    Map<String, String> headers = {

      "Content-Type": "application/json",
      //  "Authorization": "Bearer ${user.token}"

    };


    var url = URL_BASE+'/clientes';


    var response = await http.get(url, headers: headers);

    String json = response.body;

    List list = convert.json.decode(json);

    return list.map<Usuario>((map) => Usuario.fromJson(map)).toList();

  }





}