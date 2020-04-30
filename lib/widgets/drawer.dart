import 'package:ecommerce_template/admin/admin_page.dart';
import 'package:ecommerce_template/model/categoria.dart';
import 'package:ecommerce_template/model/produto.dart';
import 'package:ecommerce_template/pages/carrinho_page.dart';
import 'package:ecommerce_template/pages/categoria_page.dart';
import 'package:ecommerce_template/pages/cliente_page.dart';
import 'package:ecommerce_template/pages/favoritos_page.dart';
import 'package:ecommerce_template/pages/login_page.dart';
import 'package:flutter/material.dart';

buildDrawer(BuildContext context, List<Categoria> categorias, List<Produto> itens, ) {
  return SafeArea(
    child: new  Drawer(
      child: new ListView(
        children: <Widget>[
           UserAccountsDrawerHeader(
            accountName: Text('Cliente'),
            accountEmail: Text('cliente@gmail.com'),
            currentAccountPicture: GestureDetector(
              child: new CircleAvatar(
                backgroundColor: Colors.grey,
                child: Icon(Icons.person, color: Colors.white,),
              ),
            ),
          ),
          InkWell(
            onTap: (){

              Navigator.pop(context);
//              Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));

            },
            child: ListTile(
              title: Text('Início'),
              leading: Icon(Icons.home),
            ),
          ),

          InkWell(
            onTap: (){

              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => ClientePage()));

            },
            child: ListTile(
              title: Text('Minha conta'),
              leading: Icon(Icons.person),
            ),
          ),

          InkWell(
            onTap: (){

              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => AdminPage()));

            },
            child: ListTile(
              title: Text('Administração'),
              leading: Icon(Icons.border_color),
            ),
          ),

          InkWell(
            onTap: (){

              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => CarrinhoPage()));

            },
            child: ListTile(
              title: Text('Minhas compras'),
              leading: Icon(Icons.shopping_basket),
            ),
          ),

          InkWell(
            onTap: (){

              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => CategoriaPage(categorias, itens)));
            },
            child: ListTile(
              title: Text('Categorias'),
              leading: Icon(Icons.dashboard),
            ),
          ),

          InkWell(
            onTap: (){

              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => FavoritosPage()));

            },
            child: ListTile(
              title: Text('Favoritos'),
              leading: Icon(Icons.favorite),
            ),
          ),


          Divider(),

          InkWell(
            onTap: (){

              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
            },
            child: ListTile(
              title: Text('Sair'),
              leading: Icon(Icons.transit_enterexit, color: Colors.grey,),
            ),
          ),

        ],
      ),
    ),
  );
}