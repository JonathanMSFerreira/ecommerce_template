import 'dart:convert';
import 'package:ecommerce_template/model/categoria.dart';
import 'package:ecommerce_template/model/produto.dart';
import 'package:ecommerce_template/pages/categoria_page.dart';
import 'package:ecommerce_template/widgets/container_foto_categoria.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListaCategoria extends StatelessWidget {


  List<Categoria> categorias;
  List<Produto> itens;
  Axis orientacao;

  ListaCategoria(this.categorias, this.itens, this.orientacao);


  @override
  Widget build(BuildContext context) {

    return ListView.builder(
        scrollDirection: orientacao,
        shrinkWrap: true,
        itemCount: categorias.length,
        itemBuilder: (BuildContext context, int index) => cardCategoria(
            categorias[index].id,
            categorias[index].titulo,
            categorias[index].foto,
             context, categorias, itens
            ));

  }
}

 cardCategoria(int id, String titulo, String foto, BuildContext context, List<Categoria> categorias, List<Produto> itens)  {

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) =>  CategoriaPage(categorias, itens)));
        },
        child: Column(
          children: <Widget>[

            circleFotoCategoria(foto),

            Text(titulo, style: new TextStyle(fontSize: 12.0, color: Colors.orange),),

          ],
        ),
      ),
    );

}
