import 'dart:convert';
import 'dart:io';

import 'package:ecommerce_template/admin/novo_produto_page.dart';
import 'package:ecommerce_template/model/categoria.dart';
import 'package:ecommerce_template/model/produto.dart';
import 'package:ecommerce_template/model/usuario.dart';
import 'package:ecommerce_template/repository/categoria_repository.dart';
import 'package:ecommerce_template/repository/cliente_repository.dart';
import 'package:ecommerce_template/repository/produto_repository.dart';
import 'package:ecommerce_template/widgets/custom_containers.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class ClientesPage extends StatefulWidget {




  @override
  _ClientesPageState createState() => _ClientesPageState();
}

class _ClientesPageState extends State<ClientesPage> {


  List<Usuario> _clientes;


  @override
  void initState() {
    _carregaDados();
    super.initState();
  }


  _carregaDados() async {

    _clientes = await ClienteRepository.getAllClientes();


  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Clientes", style: TextStyle(color: Colors.orange),),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
        //  Navigator.push(context, MaterialPageRoute(builder: (context) => NovoProdutoPage(_categorias)));
        },

        child: Icon(Icons.add, color: Colors.white,),

      ),
      body: _clientes == null ? Center(child: CircularProgressIndicator()) : _carregaPagina(),

    );
  }


  ListView _carregaPagina() {

    return ListView.separated(

      separatorBuilder: (context, index) => Divider(
        color: Colors.orange,
      ),
      itemCount: _clientes.length,
      itemBuilder: (context,index){

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[


                  Container(
                    width: 100.0,
                    height: 40.0,
//                    child: Image.memory(
//                      base64Decode(_clientes[index].fotoPrincipal),
//
//                      fit: BoxFit.cover,
//                    ),
                  ),



                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Nome do cliente", style: TextStyle(fontSize: 20),),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("email@email.com",),
                      ),
                    ],)
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FlatButton(
                      color: Colors.orange,
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.edit, color: Colors.white,),
                          Text("Editar", style: TextStyle(color: Colors.white),)
                        ],
                      ),
                      onPressed: (){

                  //      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>NovaCategoriaPage(_categorias[index])));

                      },
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FlatButton(
                      color: Colors.orange,
                      child: Row(

                        children: <Widget>[
                          Icon(Icons.delete_outline, color: Colors.white,),
                          Text("Remover", style: TextStyle(color: Colors.white),)
                        ],
                      ),
                      onPressed: (){
//                       _dialogRemoverItem(_clientes[index]);

                      },
                    ),
                  )
                ],
              )
            ],
          ),
        );

      },);
  }



//  void _dialogRemoverItem(Produto prod) {
//    showDialog(
//      context: context,
//      builder: (BuildContext context) {
//
//        return AlertDialog(
//
//          content: Column(
//            mainAxisSize: MainAxisSize.min,
//            children: <Widget>[
//          CustomContainer.fotoCircular(prod.fotoPrincipal, 40, 40, 40, Colors.orange),
//              Text(prod.titulo),
//              Divider(),
//              Text("Deseja remover este produto?",textAlign: TextAlign.center,),
//            ],
//          ),
//          actions: <Widget>[
//
//            new FlatButton(
//
//              child: new Text("Cancelar", style: TextStyle(color: Colors.grey),),
//              onPressed: () {
//                Navigator.of(context).pop();
//              },
//            ),
//            new FlatButton(
//
//              child: new Text("Remover"),
//              onPressed: () {
//
//                ProdutoRepository.removeProduto(prod.id).then((value){
//                  Navigator.of(context).pop();
//                  _carregaDados();
//                });
//              },
//            ),
//          ],
//        );
//      },
//    );
//  }

}
