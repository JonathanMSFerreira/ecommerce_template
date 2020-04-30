import 'package:ecommerce_template/animations/FadeAnimation.dart';
import 'package:ecommerce_template/componets/lista_categoria.dart';
import 'package:ecommerce_template/componets/lista_produtos.dart';
import 'package:ecommerce_template/model/categoria.dart';
import 'package:ecommerce_template/model/produto.dart';
import 'package:ecommerce_template/pages/carrinho_page.dart';
import 'package:ecommerce_template/pages/categoria_page.dart';
import 'package:ecommerce_template/pages/favoritos_page.dart';
import 'package:ecommerce_template/widgets/drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';


class LojaPage extends StatefulWidget {

  List<Produto> itens;
  List<Categoria> categorias;

  LojaPage(this.itens, this.categorias);

  @override
  _LojaPageState createState() => _LojaPageState();



}

class _LojaPageState extends State<LojaPage> {

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
          AssetImage('assets/images/w3.jpeg'),
          AssetImage('assets/images/m1.jpeg'),
          AssetImage('assets/images/w4.jpeg'),
        ],
        autoplay: true,
        animationCurve: Curves.fastOutSlowIn,
        animationDuration: Duration(milliseconds: 1000),
        dotSize: 4.0,
        indicatorBgPadding: 2.0,
        dotBgColor: Colors.transparent,
      ),
    );

    return SafeArea(
        child: Scaffold(
      drawer: buildDrawer(context, widget.categorias, widget.itens),
      body: _buildBody(imageCarousel),
    ));
  }

  _buildBody(Widget imageCarousel) {
    return CustomScrollView(

      slivers: [
        SliverAppBar(
            title: Container(
              height: 40,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.orange),
                  //   borderRadius: BorderRadius.circular(25),
                  color: Colors.white),
              child: TextField(
                cursorColor: Colors.orange,
                decoration: InputDecoration(
                  hintStyle: TextStyle(fontSize: 15, color: Colors.grey[400]),
                  hintText: ' Encontre na loja',
                  fillColor: Colors.orange,
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.orange,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(12),
                ),
              ),
            ),
            actions: [

              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => FavoritosPage()));
                },
                child: Container(
                    child: Icon(
                      Icons.favorite_border,
                      color: Colors.grey,
                    )),
              ),

              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CarrinhoPage()));
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 4),
                    child: Icon(
                  Icons.shopping_cart,
                  color: Colors.orange,
                )),
              ),
            ],
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
                       Navigator.of(context).push(MaterialPageRoute(builder: (context)=> CategoriaPage(widget.categorias,widget.itens)));
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

          Container(height: 110, child: ListaCategoria(widget.categorias, widget.itens, Axis.horizontal)),


          new Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                Container(
                    alignment: Alignment.centerLeft,
                    child: new Text('Novidades',
                        style: TextStyle(fontSize: 20, color: Colors.orange, fontWeight: FontWeight.bold))),
           ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(height: 290, child: ListaProduto(widget.itens, horizontal: true,)),
              ),


          new Padding(
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
            child: Container(height: 290, child: ListaProduto(widget.itens, horizontal: true,)),
          ),




          new Padding(
                padding: const EdgeInsets.all(8.0),
                child: FadeAnimation(
                    1.7,
                    Container(
                        alignment: Alignment.centerLeft,
                        child: new Text('Mais Pequisados',
                            style: TextStyle(fontSize: 20, color: Colors.orange, fontWeight: FontWeight.bold)))),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(height: 310, child: ListaProduto(widget.itens, horizontal: true,)),
              ),

            ]))
      ],
    );
  }

}
