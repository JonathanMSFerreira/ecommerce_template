
import 'package:ecommerce_template/admin/nova_categoria_page.dart';
import 'package:ecommerce_template/model/categoria.dart';
import 'package:ecommerce_template/repository/categoria_repository.dart';
import 'package:ecommerce_template/widgets/container_foto_categoria.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';


class CategoriasPage extends StatefulWidget {

  List<Categoria> categorias;

  CategoriasPage(this.categorias);

  @override
  _CategoriasPageState createState() => _CategoriasPageState();
}

class _CategoriasPageState extends State<CategoriasPage> {


  List<Categoria> _categorias;


  @override
  void initState() {

    _carregaDados();
    super.initState();
  }


  _carregaDados(){

    CategoriaRepository.getCategorias().then((value){
      setState(() {
        _categorias = value;
      });
    });
  }




  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Categorias", style: TextStyle(color: Colors.orange),),
      ),
      floatingActionButton: FloatingActionButton(

        onPressed: (){

          Navigator.push(context, MaterialPageRoute(builder: (context) => NovaCategoriaPage(null)));

        },

        child: Icon(Icons.add, color: Colors.white,),


      ),
      body:
     _categorias == null ?
     Center(
       child: CircularProgressIndicator(),
     )  : _carregaPagina()

    );
  }

   _carregaPagina() {
    return GridView.builder(

         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
         padding: EdgeInsets.all(2.0),
         shrinkWrap: true,

         itemCount: _categorias.length,

         itemBuilder: (context,index){

           return Card(



             child: Padding(
               padding: const EdgeInsets.all(4.0),
               child: Column(
                 mainAxisSize: MainAxisSize.min,

                 children: [
                   circleFotoCategoria(_categorias[index].foto),
                   Padding(
                     padding: const EdgeInsets.all(2.0),
                     child: Text(_categorias[index].titulo, style: TextStyle(fontSize: 20),),
                   ),

                   Padding(
                     padding: const EdgeInsets.all(1.0),
                     child: Text("12 produtos",style: TextStyle(color: Colors.grey),),
                   ),

                 Row(
                   children: <Widget>[
                     Padding(
                       padding: const EdgeInsets.all(1.0),
                       child: Container(
                         child: FlatButton(onPressed: (){

                           Navigator.of(context).push(MaterialPageRoute(builder: (context)=>NovaCategoriaPage(_categorias[index])));

                         },
                             child: Text("Editar",style: TextStyle(color: Colors.orange),)
                         ),
                       ),
                     ),

                     FlatButton(onPressed: (){

                       _dialogRemoverCategoria(_categorias[index]);

                     },
                         child: Text("Remover", style: TextStyle(color: Colors.grey),)
                     )


                   ],
                 ),

                 ],
               ),
             ),
           );

         },);
  }

  void _dialogRemoverCategoria(Categoria categoria) {
    showDialog(
      context: context,
      builder: (BuildContext context) {

        return AlertDialog(

          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              circleFotoCategoria(categoria.foto),
              Text(categoria.titulo),
              Divider(),
              Text("Deseja remover esta categoria?",textAlign: TextAlign.center,),
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

                CategoriaRepository.removeCategoria(categoria.id).then((value){
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
