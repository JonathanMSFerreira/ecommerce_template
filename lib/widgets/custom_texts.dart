import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class CustomTexts {


static  subTitulo(String label, String info, double fontSize, Color colorLabel, Color colorInfo) {
    return Row(

      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontWeight: FontWeight.bold,
            fontSize: fontSize,
            color: colorLabel),),
        Text(info, style: TextStyle(color: colorInfo),)
      ],

    );
  }


}