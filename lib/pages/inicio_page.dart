
import 'dart:convert';

import 'package:bottom_navigation_badge/bottom_navigation_badge.dart';
import 'package:ecommerce_template/animations/FadeAnimation.dart';
import 'package:ecommerce_template/componets/lista_categoria.dart';
import 'package:ecommerce_template/componets/lista_produtos.dart';
import 'package:ecommerce_template/model/categoria.dart';
import 'package:ecommerce_template/model/produto.dart';
import 'package:ecommerce_template/pages/carrinho_page.dart';
import 'package:ecommerce_template/pages/categoria_page.dart';
import 'package:ecommerce_template/pages/cliente_page.dart';
import 'package:ecommerce_template/pages/favoritos_page.dart';
import 'package:ecommerce_template/widgets/drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';


class InicioPage extends StatefulWidget {

  List<Produto> produtos;
  List<Categoria> categorias;

  InicioPage(this.produtos, this.categorias);

  @override
  _InicioPageState createState() => _InicioPageState();



}

class _InicioPageState extends State<InicioPage>  {



  List<Produto> _produtosCarrousel;


  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    Widget imageCarousel = new Container(
      height: 300.0,
      child: new Carousel(
        boxFit: BoxFit.cover,


        images: [
          MemoryImage(
              base64Decode(widget.produtos[0].fotoPrincipal)),
          MemoryImage(base64Decode(widget.produtos[1].fotoPrincipal)),
          MemoryImage(base64Decode(widget.produtos[2].fotoPrincipal)),
        ],
        autoplay: true,
        animationCurve: Curves.fastOutSlowIn,
        animationDuration: Duration(milliseconds: 1000),
        dotSize: 4.0,
        indicatorBgPadding: 2.0,
        dotBgColor: Colors.transparent,
      ),
    );

    return Scaffold(
      drawer: buildDrawer(context, widget.categorias, widget.produtos),
      body: _buildBody(imageCarousel),

    );
  }

  _buildBody(Widget imageCarousel) {
    return CustomScrollView(

      slivers: [
        SliverAppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("LuMont Calçados", style: TextStyle(color: Colors.orange),),
                Icon(Icons.notifications)
              ],
            ),

            pinned: true,
            titleSpacing: 10,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: imageCarousel,
            )),
        SliverList( delegate: SliverChildListDelegate(<Widget>[
          Padding(
              padding: const EdgeInsets.all(8.0),

               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: <Widget>[
                   new Text(
                     'Categorias',
                     style: TextStyle(fontSize: 20, color: Colors.orange, fontWeight: FontWeight.bold),
                   ),

                   InkWell(
                     onTap: (){
                       Navigator.of(context).push(MaterialPageRoute(builder: (context)=> CategoriaPage(widget.produtos,widget.categorias)));
                     },
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.end,
                       crossAxisAlignment: CrossAxisAlignment.center,
                       children: <Widget>[
                         new Text(
                           'ver todas',
                           style: TextStyle(fontSize: 15, color: Colors.grey),
                         ),

                         Padding(
                           padding: const EdgeInsets.only(top: 5.0,left: 5),
                           child: Icon(Icons.arrow_forward_ios, size: 15, color: Colors.grey,),
                         ),

                       ],
                     ),
                   ),
                 ],
               ),
              ),

          Container(height: 110, child: ListaCategoria(widget.categorias, widget.produtos, Axis.horizontal)),


           Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                Container(
                    alignment: Alignment.centerLeft,
                    child: new Text('Novidades',
                        style: TextStyle(fontSize: 20, color: Colors.orange, fontWeight: FontWeight.bold))),
           ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(height: 290, child: ListaProduto(widget.produtos, horizontal: true,)),
              ),


           Padding(
            padding: const EdgeInsets.all(8.0),
            child: FadeAnimation(
                1.7,
                Container(
                    alignment: Alignment.centerLeft,
                    child: new Text('Você viu também',
                        style: TextStyle(fontSize: 20, color: Colors.orange, fontWeight: FontWeight.bold)))),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(height: 290, child: ListaProduto(widget.produtos, horizontal: true,)),
          ),

           Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                    Container(
                        alignment: Alignment.centerLeft,
                        child: new Text('Mais Pequisados',
                            style: TextStyle(fontSize: 20, color: Colors.orange, fontWeight: FontWeight.bold))),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(height: 310, child: ListaProduto(widget.produtos, horizontal: true,)),
              ),

            ]))
      ],
    );
  }

}
