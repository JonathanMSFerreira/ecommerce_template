
import 'package:ecommerce_template/admin/categorias_page.dart';
import 'package:ecommerce_template/admin/clientes_page.dart';
import 'package:ecommerce_template/admin/produtos_page.dart';
import 'package:ecommerce_template/model/categoria.dart';
import 'package:ecommerce_template/model/produto.dart';
import 'package:ecommerce_template/model/usuario.dart';
import 'package:ecommerce_template/repository/categoria_repository.dart';
import 'package:ecommerce_template/repository/cliente_repository.dart';
import 'package:ecommerce_template/repository/produto_repository.dart';
import 'package:ecommerce_template/utils/constants.dart';
import 'package:ecommerce_template/widgets/custom_loading.dart';
import 'package:flutter/material.dart';


enum Page { dashboard, manage }

class AdminPage extends StatefulWidget {


  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {



  var _countProdutos;
  var _countCategorias;
  var _countClientes;

  Page _selectedPage = Page.dashboard;



  @override
  void initState() {
    _getDadosAdmin();
    super.initState();
  }

  _getDadosAdmin()  async {

    _countClientes =   await ClienteRepository.count();

    _countProdutos = await ProdutoRepository.count();

    _countCategorias = await CategoriaRepository.count();

    setState(() {

    });


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: <Widget>[
              Expanded(
                  child: FlatButton.icon(
                      onPressed: () {
                        setState(() => _selectedPage = Page.dashboard);
                      },
                      icon: Icon(
                        Icons.dashboard,
                        color: _selectedPage == Page.dashboard
                            ? active
                            : notActive,
                      ),
                      label: Text('Dashboard'))),
              Expanded(
                  child: FlatButton.icon(
                      onPressed: () {
                        setState(() => _selectedPage = Page.manage);
                      },
                      icon: Icon(
                        Icons.sort,
                        color:
                            _selectedPage == Page.manage ? active : notActive,
                      ),
                      label: Text('Gestão'))),
            ],
          ),
          elevation: 0.0,
          backgroundColor: Colors.white,
        ),
        body: _countCategorias == null  || _countProdutos == null || _countClientes == null
        ? CustomLoading.container("Carregando...", Colors.orange)
        : _body());
  }

  Widget _body() {
    switch (_selectedPage) {
      case Page.dashboard:
        return Column(
          children: <Widget>[
            ListTile(
              subtitle:  Text('R\$ 12.000,00',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 30.0, color: Colors.green)),

              title: Text(
                'Receita',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24.0, color: Colors.grey),
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
//                        Navigator.push(
//                            context,
//                            MaterialPageRoute(
//                                builder: (context) =>
//                                    NovoProduto(widget.categorias)));
                      },
                      child: Card(
                        color: Colors.orange,
                        child: ListTile(
                            title: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(Icons.shopping_cart, color: Colors.white,),
                                  Text("Pedidos", style: TextStyle(color: Colors.white),),
                                ],
                              ),
                            ),
                            subtitle: Text(
                              '12',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white, fontSize: 60.0),
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
                                    ClientesPage()));
                      },
                      child: Card(
                        child: ListTile(
                            title: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(Icons.group),
                                  Text("Clientes"),
                                ],
                              ),
                            ),
                            subtitle: Text(
                              _countClientes.toString(),
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    CategoriasPage()));
                      },
                      child: Card(
                        child: ListTile(
                            title: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(Icons.category),
                                  Text("Categorias"),
                                ],
                              ),
                            ),
                            subtitle: Text(
                              _countCategorias.toString(),
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
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => ProdutosPage()));
                      },
                      child: Card(
                        child: ListTile(
                            title: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(Icons.track_changes),
                                  Text("Produtos"),
                                ],
                              ),
                            ),
                            subtitle: Text(

                              _countProdutos.toString(),

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
                                  Icon(Icons.tag_faces),
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




                ],
              ),
            ),
          ],
        );
        break;
      case Page.manage:
        return ListView(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.add),
              title: Text("Novo produto"),
              onTap: () {},
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.change_history),
              title: Text("Listar produtos"),
              onTap: () {},
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.add_circle),
              title: Text("Nova categoria"),
              onTap: () {

              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.category),
              title: Text("Listar categorias"),
              onTap: () {},
            ),

            Divider(),
          ],
        );
        break;
      default:
        return Container();
    }
  }

_cardOpcoes(String titulo, list, navigator) {
    return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {

                      navigator;

                    },
                    child: Card(
                      child: ListTile(
                          title: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(Icons.people_outline),
                                Text(titulo),
                              ],
                            ),
                          ),
                          subtitle:

                          Text(
                            list.length.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(color: active, fontSize: 60.0),
                          )
                      ),
                    ),
                  ),
                );
  }



}
