
import 'package:ecommerce_template/model/cor.dart';
import 'package:ecommerce_template/model/foto_produto.dart';
import 'package:ecommerce_template/model/produto.dart';
import 'package:ecommerce_template/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;


class FotosProdutoRepository{


  static Future<List<FotoProduto>> getFotosProduto(Produto produto) async {

   // Usuario user = await Usuario.get();

    Map<String, String> headers = {

      "Content-Type": "application/json",
    //  "Authorization": "Bearer ${user.token}"

    };


    var url = URL_BASE+'/fotoProdutos/produto/${produto.id}';
    var response = await http.get(url, headers: headers);

    String json = response.body;

    print(json);



    List list = convert.json.decode(json);

    return list.map<FotoProduto>((map) => FotoProduto.fromJson(map)).toList();


  }


  static Future<FotoProduto> setFotoProduto(FotoProduto fotoProduto) async {

    // Usuario user = await Usuario.get();

    Map<String, String> headers = {

      "Content-Type": "application/json",
      //  "Authorization": "Bearer ${user.token}"

    };

    Map data = fotoProduto.toJson();

    var body = convert.json.encode(data);
    var url = URL_BASE+'/fotoProdutos';
    var response = await http.post(url, headers: headers, body: body);

    Map dat = convert.json.decode(response.body);

    FotoProduto fp = FotoProduto.fromJson(dat);

    return fp;


  }

  static Future<String> removeFotoProduto(int id) async {

    // Usuario user = await Usuario.get();

    Map<String, String> headers = {

      "Content-Type": "application/json",
      //  "Authorization": "Bearer ${user.token}"

    };

    var url = URL_BASE+'/fotoProdutos/$id';


    var response = await http.delete(url, headers: headers);


    return response.body;

  }





}