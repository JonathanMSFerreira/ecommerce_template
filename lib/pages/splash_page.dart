import 'package:ecommerce_template/model/categoria.dart';
import 'package:ecommerce_template/model/produto.dart';
import 'package:ecommerce_template/pages/loja_page.dart';
import 'package:ecommerce_template/repository/categoria_repository.dart';
import 'package:ecommerce_template/repository/produto_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {



  List<Produto> _itens;
  List<Categoria> _categorias;

  bool loading = false;


  @override
  void initState() {

    Future futureTimer = Future.delayed(Duration(seconds: 3));
    Future.wait([futureTimer,_carregaDadosLoja() ]).then((List values){

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LojaPage(_itens, _categorias)));

    });

    super.initState();
  }

   Future<Null> _carregaDadosLoja() async{

    _itens = await ProdutoRepository.getProdutos();
    _categorias = await CategoriaRepository.getCategorias();

  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        body: ListView(
          children: <Widget>[
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    // Box decoration takes a gradient
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.orange[900].withOpacity(0.9),
                        Colors.orange[800].withOpacity(0.8),
                        Colors.orange[700].withOpacity(0.7),
                        Colors.orange.withOpacity(0.6),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[

                          Container(
                              child: Image.asset(
                                'assets/images/logotipo-empresa.png',
                                width: 100.0,
                              )),
                      SizedBox(
                        height: 45,
                      ),


                      CircularProgressIndicator(

                        backgroundColor: Colors.white,

                      )

                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}
