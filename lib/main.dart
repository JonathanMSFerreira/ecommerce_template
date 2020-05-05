import 'package:ecommerce_template/admin/admin_page.dart';
import 'package:ecommerce_template/pages/login_page.dart';
import 'package:ecommerce_template/pages/loja_page.dart';
import 'package:ecommerce_template/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:load/load.dart';


//MerchantId: 118eea49-14fb-4836-b6bb-bcbe28c65db0
//MerchantKey: FKPRUFGLXKIWGONQFUGGYORXKSHEZRPKKGELQWJH

//paymentId 9af8f9ae-6ba7-46f3-8b25-079b4f0d474e


void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ecommerce Template',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        primaryIconTheme: const IconThemeData.fallback().copyWith(
          color: Colors.orange,
        ),
        iconTheme: IconThemeData(
            color: Colors.orange
        ),
        appBarTheme: AppBarTheme(
            color: Colors.white
        ),
        fontFamily: 'OpenSans',
      ),
      home: SplashPage(),


  ));


}


  





