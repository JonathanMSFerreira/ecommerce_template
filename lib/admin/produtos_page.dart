import 'dart:convert';

import 'package:ecommerce_template/admin/admin_page.dart';
import 'package:ecommerce_template/admin/novo_produto_page.dart';
import 'package:ecommerce_template/admin/produto_opcoes_page.dart';
import 'package:ecommerce_template/model/produto.dart';
import 'package:ecommerce_template/repository/produto_repository.dart';
import 'package:ecommerce_template/widgets/custom_containers.dart';
import 'package:ecommerce_template/widgets/custom_loading.dart';
import 'package:ecommerce_template/widgets/custom_texts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class ProdutosPage extends StatefulWidget {

  @override
  _ProdutosPageState createState() => _ProdutosPageState();
}

class _ProdutosPageState extends State<ProdutosPage> {


  List<Produto> _produtos;


  @override
  void initState() {
    _carregaDados();
    super.initState();
  }


  _carregaDados() async {
    _produtos = await ProdutoRepository.getProdutos();
    setState(() {

    });

  }


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: (){


          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AdminPage()));


        }),
        centerTitle: true,
        title: Text("Produtos", style: TextStyle(color: Colors.orange),),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => NovoProdutoPage(null)));
        },

        child: Icon(Icons.add, color: Colors.white,),

      ),
      body: _body(),

    );
  }


  _body() {

     if( _produtos == null ){

     return  CustomLoading.container("Buscando Produtos...", Colors.orange);

     }

     if(_produtos.isEmpty){

         return CustomContainer.semInformacao("Nenhum produto cadastrado!", 15, Icons.remove_shopping_cart, 50);

     }
     
     return _bodyContent();

  }

  ListView _bodyContent() {
    return ListView.builder(

       shrinkWrap: true,

       itemCount: _produtos.length,
       itemBuilder: (context,index){

         return Card(
           child: Padding(
             padding: const EdgeInsets.all(5.0),
             child:
             Row(

               children: <Widget>[
                 Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: <Widget>[
                     Container(

                       width: 80.0,
                       height: 60.0,
                       child: Image.memory(
                         base64Decode(_produtos[index].fotoPrincipal),
                         fit: BoxFit.contain,
                       ),
                     ),

                   ],
                 ),

                 Expanded(
                   child: Container(
                     child: Column(

                       crossAxisAlignment: CrossAxisAlignment.start,
                       mainAxisAlignment: MainAxisAlignment.start,
                       children: <Widget>[

                         Text(_produtos[index].titulo, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 20),),


                         CustomTexts.subTitulo("Preço compra: ", "R\$ ${ _produtos[index].precoCompra.toString()}",  14,  Colors.black,  Colors.grey ),


                         CustomTexts.subTitulo("Preço venda: ", "R\$ ${ _produtos[index].precoVenda.toString()}",  14,  Colors.black,  Colors.grey ),


                         CustomTexts.subTitulo("Estoque: ", _produtos[index].qtdTotal.toString(),  14,  Colors.black,  Colors.grey ),

                         CustomTexts.subTitulo("",_produtos[index].status.status,  14,  Colors.black,   Colors.red),


                         Row(

                           mainAxisAlignment: MainAxisAlignment.end,
                           children: [


                             FlatButton(onPressed: (){

                               Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ProdutoOpcoesPage(_produtos[index])));

                             },
                                 child: Text("Detalhes",style: TextStyle(color: Colors.orange),)
                             ),



                             FlatButton(onPressed: (){

                               _dialogRemoverProduto(_produtos[index]);

                             },
                                 child: Text("Remover", style: TextStyle(color: Colors.grey),)
                             )

                           ],

                         )

                       ],
                     ),
                   ),
                 ),

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
              CustomContainer.fotoCircular(produto.fotoPrincipal, 40, 40, 40, Colors.orange),
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

                Navigator.of(context).pop();

                ProdutoRepository.removeProduto(produto.id).then((value){
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
