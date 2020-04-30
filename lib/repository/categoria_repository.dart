
import 'package:ecommerce_template/model/categoria.dart';
import 'package:ecommerce_template/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;


class CategoriaRepository{


  static Future<List<Categoria>> getCategorias() async {

   // Usuario user = await Usuario.get();

    Map<String, String> headers = {

      "Content-Type": "application/json",
    //  "Authorization": "Bearer ${user.token}"

    };


    var url = URL_BASE+'/categorias';

    var response = await http.get(url, headers: headers);

    String json = response.body;


    List list = convert.json.decode(json);

    return list.map<Categoria>((map) => Categoria.fromJson(map)).toList();


  }

  static Future<String> setNovaCategoria(Categoria categoria) async {

    // Usuario user = await Usuario.get();

    Map<String, String> headers = {

      "Content-Type": "application/json",
      //  "Authorization": "Bearer ${user.token}"

    };

    Map data = {
      'titulo': categoria.titulo,
      'foto': categoria.foto
    };

    var body = convert.json.encode(data);


    var url = URL_BASE+'/categorias';

    // var response = await http.get(url, headers: headers);

    var response = await http.post(url, headers: headers, body: body);


    return response.body;


  }


  static Future<String> removeCategoria(int id) async {

    // Usuario user = await Usuario.get();

    Map<String, String> headers = {

      "Content-Type": "application/json",
      //  "Authorization": "Bearer ${user.token}"

    };
//
//    Map data = {
//      'titulo': categoria.titulo,
//      'foto': categoria.foto
//    };

   // var body = convert.json.encode(data);


    var url = URL_BASE+'/categorias/$id';

    // var response = await http.get(url, headers: headers);

    var response = await http.delete(url, headers: headers);


    //String json = response.body;

    return response.body;

  }
}