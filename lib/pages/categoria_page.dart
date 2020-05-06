import 'package:ecommerce_template/componets/lista_categoria.dart';
import 'package:ecommerce_template/componets/lista_produtos.dart';
import 'package:ecommerce_template/model/categoria.dart';
import 'package:ecommerce_template/model/produto.dart';
import 'package:ecommerce_template/pages/carrinho_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class CategoriaPage extends StatefulWidget {

  List<Categoria> categorias;
  List<Produto> itens;
  CategoriaPage(this.itens,this.categorias);

  @override
  _CategoriaPageState createState() => _CategoriaPageState();
}

class _CategoriaPageState extends State<CategoriaPage> {
  @override
  Widget build(BuildContext context) {


    return  Scaffold(


        appBar: _buildAppBar(context),
        body:  _buildBody(),


    );
  }

   _buildBody() {
    return Row(

         mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
//           Container(
//                    width: 95,
//                    color: Colors.white,
//                    child: ListView(
//                      children: [
//                           ListaCategoria(widget.categorias,widget.itens, Axis.vertical),
//                      ],
//                    ),
//                  ),

            Expanded(
              flex: 1,
              child:  ListaProduto(widget.itens, horizontal: false,)
              ),



      ],
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(

      iconTheme: IconThemeData(
          color: Colors.orange
      ),
      elevation: 1,
      title:  Container(
        height: 40,
        decoration: BoxDecoration(

            border: Border.all(color: Colors.orange),
            color: Colors.white),
        child: TextField(
          cursorColor: Colors.orange,
          decoration: InputDecoration(
            hintStyle: TextStyle(fontSize: 15, color: Colors.grey[300]),
            hintText: ' Encontre na loja',
            fillColor: Colors.orange,
            suffixIcon: Icon(
              Icons.search,
              color: Colors.orange,
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(12),
          ),
        ),
      ),


    );
  }


}