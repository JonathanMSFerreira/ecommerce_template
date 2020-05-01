
import 'package:ecommerce_template/model/cor.dart';
import 'package:ecommerce_template/model/status.dart';
import 'package:ecommerce_template/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;


class StatusRepository{


  static Future<List<Status>> getStatus() async {

   // Usuario user = await Usuario.get();

    Map<String, String> headers = {

      "Content-Type": "application/json",
    //  "Authorization": "Bearer ${user.token}"

    };


    var url = URL_BASE+'/status';
    var response = await http.get(url, headers: headers);

    String json = response.body;


    List list = convert.json.decode(json);

    return list.map<Status>((map) => Status.fromJson(map)).toList();


  }

}