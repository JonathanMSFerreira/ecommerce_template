import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class CustomContainer {

  static fotoCircular(String foto, double width, double height, double radius, Color color) {
    return Container(

        width: width,
        height: height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(color: color)
        ),

        child: CircleAvatar(

          radius: radius,
          backgroundImage: MemoryImage(
            base64Decode(foto),
          ),
        )
    );
  }

  static semInformacao(String info, double fontSize, IconData icon, double iconSize) {

    return Center(child: Column(

      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[

        Icon(icon, size: iconSize, color: Colors.grey),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(info, style: TextStyle(fontSize: fontSize, color: Colors.grey),),
        ),




      ],
    ));

  }
}