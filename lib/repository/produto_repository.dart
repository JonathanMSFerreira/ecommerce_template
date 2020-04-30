import 'package:ecommerce_template/model/produto.dart';
import 'package:ecommerce_template/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;


class ProdutoRepository{


  static Future<List<Produto>> getProdutos() async {

   // Usuario user = await Usuario.get();

    Map<String, String> headers = {

      "Content-Type": "application/json",
    //  "Authorization": "Bearer ${user.token}"
    };

    var url = URL_BASE + '/produtos';
    var response = await http.get(url, headers: headers);
    String json = response.body;
    List list = convert.json.decode(json);
    return list.map<Produto>((map) => Produto.fromJson(map)).toList();

  }

  static Future<String> setNovoProduto(Produto item) async {

    // Usuario user = await Usuario.get();

    Map<String, String> headers = {

      "Content-Type": "application/json",
      //  "Authorization": "Bearer ${user.token}"

    };

    Map data = item.toJson();

    var body = convert.json.encode(data);
    var url = URL_BASE+'/produtos';

    var response = await http.post(url, headers: headers, body: body);

    return response.body;


  }


  static Future<String> removeProduto(int id) async {

    // Usuario user = await Usuario.get();

    Map<String, String> headers = {

      "Content-Type": "application/json",
      //  "Authorization": "Bearer ${user.token}"

    };



    var url = URL_BASE+'/produtos/$id';

    // var response = await http.get(url, headers: headers);

    var response = await http.delete(url, headers: headers);


    //String json = response.body;

    return response.body;

  }





}