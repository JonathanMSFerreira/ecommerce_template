import 'package:ecommerce_template/model/produto.dart';
import 'package:ecommerce_template/pages/produto_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';


class ListaProduto extends StatelessWidget {

  List<Produto> produtos;
  bool horizontal;

  ListaProduto(this.produtos, {this.horizontal = true} );

  @override
  Widget build(BuildContext context) {
    return  this.horizontal == true ?

      ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: produtos.length,
        itemBuilder: (BuildContext context, int index) => cardProdutoHorizontal(context,
            produtos[index])) :


       ListView.builder(

        shrinkWrap: true,
        itemCount: produtos.length,

        itemBuilder: (BuildContext context, int index) => cardProdutoVertical(context,
            produtos[index]));

  }
}


/*
  CARD UTILIZADO NAS LISTAS VERTICAIS
  EXEMPLO: CATEGORIAPAGE
 */
 cardProdutoVertical(context, Produto item) {

  return InkWell(

    onTap: (){
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProdutoPage(item)));
    },
    child: Container(

        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.all(1),
        decoration: BoxDecoration(border: Border.all(color: Colors.orange.withOpacity(0.1))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: <Widget>[
                Container(
                  width: 110,
                  height: 140,
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Image.memory(
                      base64Decode(item.fotoPrincipal),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Icon(Icons.favorite_border, color: Colors.grey,),
                )

              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    item.titulo ?? '',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        item.precoCompra == null ? '' : "R\$ ${item.precoCompra}",
                        style:
                        TextStyle(color: Colors.red, fontWeight: FontWeight.w800),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        item.precoVenda == null ? '' : "R\$ ${item.precoVenda}",
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w800,
                            decoration: TextDecoration.lineThrough),
                      ),
                    ],
                  ),
                ),




                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.star_border,
                        size: 18,
                        color: Colors.grey,
                      ),
                      Icon(
                        Icons.star_border,
                        size: 18,
                        color: Colors.grey,
                      ),
                      Icon(
                        Icons.star_border,
                        size: 18,
                        color: Colors.grey,
                      ),
                      Icon(
                        Icons.star_border,
                        size: 18,
                        color: Colors.grey,
                      ),
                      Icon(
                        Icons.star_border,
                        size: 18,
                        color: Colors.grey,
                      ),
                      Text(
                        " (123)",
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      )
                    ],
                  ),
                )


              ],
            ),

          ],
        )),
  );
}





/*
  CARD UTILIZADO NAS LISTAS HORIZONTAIS
  EXEMPLOS: LISTAS DE NOVIDADES E PROMOÇÕES DA HOMEPAGE
 */

 cardProdutoHorizontal(context, Produto item) {

  return InkWell(

      onTap: (){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProdutoPage(item)));
  },
   child:Container(


      decoration: BoxDecoration(border: Border.all(color: Colors.orange.withOpacity(0.1))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: <Widget>[
              Container(

                width: 180,
                height: 200,
                child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Image.memory(
                    base64Decode(item.fotoPrincipal),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Icon(Icons.favorite_border, color: Colors.grey,),
              )

            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              item.titulo ?? '',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  item.precoCompra == null ? '' : "R\$ ${item.precoCompra}",
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.w800),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  item.precoVenda == null ? '' : "R\$ ${item.precoVenda}",
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w800,
                      decoration: TextDecoration.lineThrough),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.star_border,
                  size: 18,
                  color: Colors.grey,
                ),
                Icon(
                  Icons.star_border,
                  size: 18,
                  color: Colors.grey,
                ),
                Icon(
                  Icons.star_border,
                  size: 18,
                  color: Colors.grey,
                ),
                Icon(
                  Icons.star_border,
                  size: 18,
                  color: Colors.grey,
                ),
                Icon(
                  Icons.star_border,
                  size: 18,
                  color: Colors.grey,
                ),
                Text(
                  " (123)",
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                )
              ],
            ),
          )
        ],
      )));
}
