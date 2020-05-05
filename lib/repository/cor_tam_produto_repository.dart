
import 'package:ecommerce_template/model/categoria.dart';
import 'package:ecommerce_template/model/categoria_produto.dart';
import 'package:ecommerce_template/model/cor.dart';
import 'package:ecommerce_template/model/cor_tam_produto.dart';
import 'package:ecommerce_template/model/produto.dart';
import 'package:ecommerce_template/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;


class CorTamanhoProdutoRepository{


  static Future<List<CorTamProdutos>> getCorTamProdutos() async {

   // Usuario user = await Usuario.get();

    Map<String, String> headers = {

      "Content-Type": "application/json",
    //  "Authorization": "Bearer ${user.token}"

    };


    var url = URL_BASE+'/corTamProdutos';

    var response = await http.get(url, headers: headers);

    String json = response.body;


    List list = convert.json.decode(json);

    return list.map<CorTamProdutos>((map) => CorTamProdutos.fromJson(map)).toList();


  }

  static Future<List<CorTamProdutos>> getCorTamProdutosByProduto(Produto produto) async {

    // Usuario user = await Usuario.get();

    Map<String, String> headers = {

      "Content-Type": "application/json",
      //  "Authorization": "Bearer ${user.token}"

    };


    var url = URL_BASE+'/corTamProdutos/produto/${produto.id}';

    var response = await http.get(url, headers: headers);

    String json = response.body;


    List list = convert.json.decode(json);

    return list.map<CorTamProdutos>((map) => CorTamProdutos.fromJson(map)).toList();


  }


  static Future<List<CorTamProdutos>> getCorTamProdutosByProdutoAndCor(Produto produto, Cor cor) async {

    // Usuario user = await Usuario.get();

    Map<String, String> headers = {

      "Content-Type": "application/json",
      //  "Authorization": "Bearer ${user.token}"

    };


    var url = URL_BASE+'/corTamProdutos/produto/${produto.id}/cor/${cor.id}';

    var response = await http.get(url, headers: headers);

    String json = response.body;


    List list = convert.json.decode(json);

    return list.map<CorTamProdutos>((map) => CorTamProdutos.fromJson(map)).toList();


  }




  static Future<String> setNovaCorTamProduto(CorTamProdutos  corTamProdutos) async {

    // Usuario user = await Usuario.get();

    Map<String, String> headers = {

      "Content-Type": "application/json",
      //  "Authorization": "Bearer ${user.token}"

    };

    Map data = corTamProdutos.toJson();

    var body = convert.json.encode(data);

    var url = URL_BASE+'/corTamProdutos';

    var response = await http.post(url, headers: headers, body: body);


    return response.body;


  }


  static Future<String> removeCorTamProduto(int id) async {

    // Usuario user = await Usuario.get();

    Map<String, String> headers = {

      "Content-Type": "application/json",
      //  "Authorization": "Bearer ${user.token}"

    };



    var url = URL_BASE+'/corTamProdutos/$id';

    // var response = await http.get(url, headers: headers);

    var response = await http.delete(url, headers: headers);


    //String json = response.body;

    return response.body;

  }
}