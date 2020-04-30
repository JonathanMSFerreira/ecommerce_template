
import 'package:ecommerce_template/model/cor.dart';
import 'package:ecommerce_template/model/tamanho.dart';
import 'package:ecommerce_template/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;


class TamanhosRepository{


  static Future<List<Tamanho>> getTamanhos() async {

   // Usuario user = await Usuario.get();

    Map<String, String> headers = {

      "Content-Type": "application/json",
    //  "Authorization": "Bearer ${user.token}"

    };


    var url = URL_BASE+'/tamanhos';
    var response = await http.get(url, headers: headers);

    String json = response.body;


    List list = convert.json.decode(json);

    return list.map<Tamanho>((map) => Tamanho.fromJson(map)).toList();


  }

}