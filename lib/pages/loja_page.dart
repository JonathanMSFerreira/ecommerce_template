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
import 'package:ecommerce_template/pages/inicio_page.dart';
import 'package:ecommerce_template/widgets/drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';


class LojaPage extends StatefulWidget {

  List<Produto> itens;
  List<Categoria> categorias;

  LojaPage(this.itens, this.categorias);

  @override
  _LojaPageState createState() => _LojaPageState(itens, categorias);



}

class _LojaPageState extends State<LojaPage> with SingleTickerProviderStateMixin {

   List<Produto> itens;
   List<Categoria> categorias;
   _LojaPageState(this.itens, this.categorias);
   List<Widget> _widgetOptions;



  BottomNavigationBadge badger = new BottomNavigationBadge(
      backgroundColor: Colors.red,
      badgeShape: BottomNavigationBadgeShape.circle,
      textColor: Colors.white,
      position: BottomNavigationBadgePosition.topRight,
      textSize: 8);


   @override
   void initState() {
     _carregaPages(itens, categorias);
     super.initState();
   }

   _carregaPages(itens, categorias){

    _widgetOptions = <Widget> [
       InicioPage(itens, categorias),
       FavoritosPage(),
       CarrinhoPage(),
       CategoriaPage(itens, categorias),
       ClientePage(),
     ];

   }

  List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(icon: Icon(Icons.business), title: Text("Loja")),
    BottomNavigationBarItem(icon: Icon(Icons.favorite), title: Text("Favoritos")),
    BottomNavigationBarItem(icon: Icon(Icons.local_mall), title: Text("Sacola")),
    BottomNavigationBarItem(icon: Icon(Icons.search), title: Text("Pesquisar")),
    BottomNavigationBarItem(icon: Icon(Icons.face), title: Text("Meus Dados"))
  ];
  int dropdownSelected = 0;
  int _current = 0;

  void _change(int index) {
    setState(() {
      _current = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Scaffold(
          drawer: buildDrawer(context, widget.categorias, widget.itens),
          body: _widgetOptions[_current],
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Colors.orange,
            unselectedItemColor: Colors.orange[200],
            elevation: 3,

            currentIndex: _current,
            onTap: _change,
            items: items,
          ),

    ));
  }

}
