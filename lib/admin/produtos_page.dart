import 'dart:convert';
import 'dart:io';

import 'package:ecommerce_template/admin/novo_produto_page.dart';
import 'package:ecommerce_template/model/categoria.dart';
import 'package:ecommerce_template/model/produto.dart';
import 'package:ecommerce_template/repository/categoria_repository.dart';
import 'package:ecommerce_template/repository/produto_repository.dart';
import 'package:ecommerce_template/widgets/container_foto_categoria.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class ProdutosPage extends StatefulWidget {

  @override
  _ProdutosPageState createState() => _ProdutosPageState();
}

class _ProdutosPageState extends State<ProdutosPage> {


  List<Produto> _produtos;
  List<Categoria> _categorias;

  @override
  void initState() {
    _carregaDados();
    super.initState();
  }


  _carregaDados(){
    ProdutoRepository.getProdutos().then((value){
      setState(() {
        _produtos = value;
      });

      CategoriaRepository.getCategorias().then((value){
        setState(() {
          _categorias = value;
        });
      });


    });
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Produtos", style: TextStyle(color: Colors.orange),),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => NovoProdutoPage(null, _categorias)));
        },

        child: Icon(Icons.add, color: Colors.white,),

      ),
      body: _produtos == null ? Center(child: CircularProgressIndicator()) : _body(),

    );
  }


  _body() {

    return GridView.builder(

      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),

      itemCount: _produtos.length,
      itemBuilder: (context,index){

        return Card(
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 100.0,
                  height: 100.0,
                  child: Image.memory(
                    base64Decode(_produtos[index].fotoPrincipal),
                    fit: BoxFit.contain,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text(_produtos[index].titulo, style: TextStyle(fontSize: 20),),
                ),


                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Container(
                        child: FlatButton(onPressed: (){

                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>NovoProdutoPage( _produtos[index], _categorias)));

                        },
                            child: Text("Editar",style: TextStyle(color: Colors.orange),)
                        ),
                      ),
                    ),

                    FlatButton(onPressed: (){

                      _dialogRemoverProduto(_produtos[index]);

                    },
                        child: Text("Remover", style: TextStyle(color: Colors.grey),)
                    )


                  ],
                ),



//              Row(
//                mainAxisAlignment: MainAxisAlignment.end,
//                children: [
//                  FlatButton(
//                    color: Colors.orange,
//                    child: Row(
//                      children: <Widget>[
//                        Icon(Icons.edit, color: Colors.white,),
//                        Text("Editar", style: TextStyle(color: Colors.white),)
//                      ],
//                    ),
//                    onPressed: (){
//
//                  //      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>NovaCategoriaPage(_categorias[index])));
//
//                    },
//                  ),
//
//                  RaisedButton(
//                    color: Colors.orange,
//                    child: Row(
//
//                      children: <Widget>[
//                        Icon(Icons.delete_outline, color: Colors.white,),
//                        Text("Remover", style: TextStyle(color: Colors.white),)
//                      ],
//                    ),
//                    onPressed: (){
//
//
//                    },
//                  )
//                ],
//              )
              ],
            ),
          ),
        );

      },);
  }



  void _dialogRemoverProduto(Produto produto) {
    showDialog(
      context: context,
      builder: (BuildContext context) {

        return AlertDialog(

          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              circleFotoCategoria(produto.fotoPrincipal),
              Text(produto.titulo),
              Divider(),
              Text("Deseja remover este produto?",textAlign: TextAlign.center,),
            ],
          ),
          actions: <Widget>[

            new FlatButton(

              child: new Text("Cancelar", style: TextStyle(color: Colors.grey),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(

              child: new Text("Remover"),
              onPressed: () {

                ProdutoRepository.removeProduto(produto.id).then((value){
                  Navigator.of(context).pop();
                  _carregaDados();
                });
              },
            ),
          ],
        );
      },
    );
  }

}
