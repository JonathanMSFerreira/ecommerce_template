import 'dart:convert';

import 'package:flutter/material.dart';

circleFotoCategoria(String foto){

  return Container(

    width: 80,
    height: 80,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(80),
        border: Border.all(color: Colors.orange)
    ),


    child: CircleAvatar(

      radius: 40,
      backgroundImage: MemoryImage(
        base64Decode(foto),
      ),
    )
  );

}
