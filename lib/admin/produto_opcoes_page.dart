
import 'package:ecommerce_template/admin/categorias_page.dart';
import 'package:ecommerce_template/admin/clientes_page.dart';
import 'package:ecommerce_template/admin/cor_tam_produto_page.dart';
import 'package:ecommerce_template/admin/fotos_produto_page.dart';
import 'package:ecommerce_template/admin/novo_produto_page.dart';
import 'package:ecommerce_template/admin/produtos_page.dart';
import 'package:ecommerce_template/model/categoria.dart';
import 'package:ecommerce_template/model/foto_produto.dart';
import 'package:ecommerce_template/model/produto.dart';
import 'package:ecommerce_template/model/usuario.dart';
import 'package:ecommerce_template/repository/categoria_repository.dart';
import 'package:ecommerce_template/repository/cliente_repository.dart';
import 'package:ecommerce_template/repository/foto_produto_repository.dart';
import 'package:ecommerce_template/repository/produto_repository.dart';
import 'package:ecommerce_template/utils/constants.dart';
import 'package:ecommerce_template/widgets/custom_containers.dart';
import 'package:ecommerce_template/widgets/custom_texts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class ProdutoOpcoesPage extends StatefulWidget {


  Produto produto;
  ProdutoOpcoesPage(this.produto);



  @override
  _ProdutoOpcoesPageState createState() => _ProdutoOpcoesPageState();
}

class _ProdutoOpcoesPageState extends State<ProdutoOpcoesPage> {

  List<FotoProduto> _fotos;

  @override
  void initState() {
    _getDadosAdmin();
    super.initState();
  }

  _getDadosAdmin()  {

    FotosProdutoRepository.getFotosProduto(widget.produto).then((value) {
      setState(() {
        _fotos = value;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Detalhes do Produto", style: TextStyle(color: Colors.orange),),
          elevation: 1.0,
          backgroundColor: Colors.white,
        ),
        body: _fotos == null
        ?
        Center(child: CircularProgressIndicator(),) : _body());
  }

  Widget _body() {

    
        return Column(
          children: <Widget>[


            Padding(
              padding: const EdgeInsets.all(8.0),

              child: Card(

                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ListTile(

                    title: Text(widget.produto.titulo),
                    subtitle: CustomTexts.subTitulo("Status: ",widget.produto.status.status, 14, Colors.black, Colors.grey),
                    leading: CustomContainer.fotoCircular(widget.produto.fotoPrincipal, 60, 60, 60, Colors.orange),
                    trailing: IconButton(icon: Icon(Icons.edit), onPressed: (){

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    NovoProdutoPage(widget.produto)));


                    }),

                  ),

                ),
              ),
            ),


            Expanded(
              child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                children: <Widget>[


                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    CorTamProdutoPage(widget.produto)));

                      },
                      child: Card(
                        child: ListTile(
                            title: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(Icons.autorenew, color: Colors.grey,),
                                  Text("Opções"),
                                ],
                              ),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.autorenew, size: 60,),
                            )),
                      ),
                    ),
                  ),



                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    FotosProdutoPage(widget.produto)));
                      },
                      child: Card(
                        child: ListTile(
                            title: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(Icons.camera_alt, color: Colors.grey,),
                                  Text("Fotos"),
                                ],
                              ),
                            ),
                            subtitle: Text(
                              _fotos.length.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(color: active, fontSize: 60.0),
                            )),
                      ),
                    ),
                  ),






                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
//                        Navigator.push(
//                            context,
//                            MaterialPageRoute(
//                                builder: (context) =>
//                                    NovoProduto(widget.categorias)));
                      },
                      child: Card(
                        child: ListTile(
                            title: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(Icons.tag_faces,color: Colors.grey,),
                                  Text("Vendas"),
                                ],
                              ),
                            ),
                            subtitle: Text(
                              '43',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: active, fontSize: 60.0),
                            )),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
//                        Navigator.push(
//                            context,
//                            MaterialPageRoute(
//                                builder: (context) =>
//                                    NovoProduto(widget.categorias)));
                      },
                      child: Card(
                        child: ListTile(
                            title: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(Icons.shopping_cart,color: Colors.grey,),
                                  Text("Pedidos"),
                                ],
                              ),
                            ),
                            subtitle: Text(
                              '12',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: active, fontSize: 60.0),
                            )),
                      ),
                    ),
                  ),


                ],
              ),
            ),
          ],
        );
       
    
  }

}
