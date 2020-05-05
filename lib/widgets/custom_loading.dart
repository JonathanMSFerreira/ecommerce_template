import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class CustomLoading{


  static container(String title, Color color){

   return Center(
     child: Column(
       crossAxisAlignment: CrossAxisAlignment.center,
       mainAxisAlignment: MainAxisAlignment.center,
       children: <Widget>[
         Padding(
           padding: const EdgeInsets.all(8.0),
           child: CircularProgressIndicator(),
         ),
         Text(title, style: TextStyle(color: color),)
       ],
     ),
   );




  }


}