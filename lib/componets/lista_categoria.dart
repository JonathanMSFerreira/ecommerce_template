
import 'package:ecommerce_template/model/categoria.dart';
import 'package:ecommerce_template/model/produto.dart';
import 'package:ecommerce_template/pages/categoria_page.dart';
import 'package:ecommerce_template/widgets/custom_containers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListaCategoria extends StatelessWidget {


  List<Categoria> categorias;
  List<Produto> produtos;
  Axis orientacao;

  ListaCategoria(this.categorias, this.produtos, this.orientacao);


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
             context, categorias, produtos
            ));

  }
}

 cardCategoria(int id, String titulo, String foto, BuildContext context, List<Categoria> categorias, List<Produto> produtos)  {

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) =>  CategoriaPage( produtos,categorias)));
        },
        child: Column(
          children: <Widget>[

            CustomContainer.fotoCircular(foto, 80, 80, 40, Colors.orange),

            Text(titulo, style: new TextStyle(fontSize: 12.0, color: Colors.orange),),

          ],
        ),
      ),
    );

}
