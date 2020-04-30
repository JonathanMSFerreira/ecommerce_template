import 'package:ecommerce_template/componets/lista_favorito.dart';
import 'package:flutter/material.dart';


class FavoritosPage extends StatefulWidget {
  @override
  _FavoritosPageState createState() => _FavoritosPageState();
}

class _FavoritosPageState extends State<FavoritosPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        title: Text('Favoritos', style: TextStyle(color: Colors.orange),),

        actions: [

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.shopping_cart),
          ),
        ],
      ),

      body: Container(

          child: ListaFavorito()),
    );
  }
}