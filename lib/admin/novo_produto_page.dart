import 'dart:convert';
import 'dart:io';
import 'package:ecommerce_template/admin/opcoes_produto_page.dart';
import 'package:ecommerce_template/admin/produtos_page.dart';
import 'package:ecommerce_template/model/categoria.dart';
import 'package:ecommerce_template/model/categoria_produto.dart';
import 'package:ecommerce_template/model/cor.dart';
import 'package:ecommerce_template/model/produto.dart';
import 'package:ecommerce_template/model/status.dart';
import 'package:ecommerce_template/model/tamanho.dart';
import 'package:ecommerce_template/pages/produto_page.dart';
import 'package:ecommerce_template/repository/categoria_produto_repository.dart';
import 'package:ecommerce_template/repository/categoria_repository.dart';
import 'package:ecommerce_template/repository/cores_repository.dart';
import 'package:ecommerce_template/repository/produto_repository.dart';
import 'package:ecommerce_template/repository/status_repository.dart';
import 'package:ecommerce_template/repository/tamanhos_repository.dart';
import 'package:ecommerce_template/utils/constants.dart';
import 'package:ecommerce_template/widgets/custom_containers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:groovin_widgets/outline_dropdown_button.dart';
import 'package:image_picker/image_picker.dart';


class NovoProdutoPage extends StatefulWidget {


  Produto produto;


  NovoProdutoPage(this.produto);

  @override
  _NovoProdutoPageState createState() => _NovoProdutoPageState();
}

class _NovoProdutoPageState extends State<NovoProdutoPage> {


  bool isChecked = false;

  File _foto;
  var quantidade;
  var precoCompra;
  var precoVenda;
  var nome;
  var descricao;
  Categoria categoria;
  String tamanho;
  String cor;

  List<Categoria> _categorias;


  List<Status> _status;



  @override
  void initState() {
    _getDadosNovoProduto();
    super.initState();
  }

  _getDadosNovoProduto()  async{

    _categorias =  await CategoriaRepository.getCategorias();

    _status = await StatusRepository.getStatus();


    setState(() {
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: white,
        centerTitle: true,
        title: Text(
          "Novo produto",
          style: TextStyle(color: Colors.orange),
        ),
      ),
      body: _categorias == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : _buildFormNovoProduto(context),
    );
  }

  _buildFormNovoProduto(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: OutlineButton(
                    borderSide: BorderSide(
                        color: grey.withOpacity(0.5), width: 2.5),
                    onPressed: () {
                      _selecionaFoto(
                          ImagePicker.pickImage(
                              source: ImageSource.gallery),
                          1);
                    },
                    child: _containerFoto()),
              ),
            ),
          ],
        ),
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 50,
              child: TextField(
                decoration: new InputDecoration(
                  labelText: 'Nome',
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(5.0),
                    borderSide: new BorderSide(),
                  ),
                  //fillColor: Colors.green
                ),
                onChanged: (val) {
                  setState(() {
                    nome = val;
                  });
                },
                keyboardType: TextInputType.text,
              ),
            )),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 50,
            child: TextField(
              decoration: new InputDecoration(
                labelText: 'Descricao',
                fillColor: Colors.white,
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(5.0),
                  borderSide: new BorderSide(),
                ),
                //fillColor: Colors.green
              ),
              onChanged: (val) {
                setState(() {
                  descricao = val;
                });
              },
              keyboardType: TextInputType.text,
            ),
          ),
        ),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Categoria"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: OutlineDropdownButton(
                isDense: true,
                items: _categorias.map((Categoria cat) {
                  return DropdownMenuItem<Categoria>(
                    value: cat,
                    child: Text(cat.titulo),
                  );
                }).toList(),
                hint: Text('Escolha a categoria'),
                value: categoria,
                onChanged: (value) {
                  setState(() {
                    categoria = value;

                  });
                },
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: 160,
                height: 50,
                child: TextField(
                  decoration: new InputDecoration(
                    labelText: 'Preço Compra',
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(5.0),
                      borderSide: new BorderSide(),
                    ),
                    //fillColor: Colors.green
                  ),
                  onChanged: (val) {
                    setState(() {
                      precoCompra = val;
                    });
                  },
                  keyboardType: TextInputType.numberWithOptions(
                      signed: false, decimal: true),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Flexible(
                  child: Container(
                height: 50,
                child: TextField(
                  decoration: new InputDecoration(
                    labelText: 'Preço Venda',
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(5.0),
                      borderSide: new BorderSide(),
                    ),
                    //fillColor: Colors.green
                  ),
                  onChanged: (val) {
                    setState(() {
                      precoVenda = val;
                    });
                  },
                  keyboardType: TextInputType.numberWithOptions(
                      signed: false, decimal: true),
                ),
              )),
            ],
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Em promoção',
                  ),
                  Checkbox(
                    value: isChecked,
                    onChanged: (value) {
                      toggleCheckbox(value);
                    },
                    activeColor: Colors.orange,
                    checkColor: Colors.white,
                    tristate: false,
                  ),
                ],
              ),
              SizedBox(
                width: 10,
              ),
              Flexible(
                child: Container(

                  height: 50,
                  child: TextField(
                    decoration: new InputDecoration(
                      labelText: 'Preço promocional',
                      fillColor: Colors.white,
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(5.0),
                        borderSide: new BorderSide(),
                      ),
                      //fillColor: Colors.green
                    ),
                    onChanged: (val) {
                      setState(() {
                        quantidade = val;
                      });
                    },
                    keyboardType: TextInputType.numberWithOptions(
                        signed: false, decimal: false),
                  ),
                ),
              ),
            ],
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: FlatButton(
              color: Colors.orange,
              textColor: white,
              child: Text('Adicionar Produto'),
              onPressed: () {
                _buttonNovoItem();
              },
            ),
          ),
        ),


      ],
    );
  }

  void _selecionaFoto(Future<File> pickImage, int imageNumber) async {
    File tempImg = await pickImage;
    setState(() => _foto = tempImg);
  }

  void toggleCheckbox(bool value) {
    if (isChecked == false) {
      setState(() {
        isChecked = true;
      });
    } else {
      setState(() {
        isChecked = false;
      });
    }
  }

  Widget _containerFoto() {
    if (_foto == null) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(14, 70, 14, 70),
        child: Column(
          children: <Widget>[
            Icon(
              Icons.photo_camera,
              color: grey,
            ),
            Text("Selecione uma foto", style: TextStyle(color: grey))
          ],
        ),
      );
    } else {
      return Image.file(
        _foto,
        fit: BoxFit.fill,
        width: double.infinity,
      );
    }
  }

  void _buttonNovoItem() {

    Produto produto = new Produto();
    produto.titulo = nome;
    produto.descricao = descricao;
    produto.precoCompra = double.parse(precoCompra);
    produto.precoVenda = double.parse(precoVenda);
    List<int> imageBytes = _foto.readAsBytesSync();
    String base64Image = base64Encode(imageBytes);
    produto.fotoPrincipal = base64Image;
    produto.emPromocao = isChecked;
    //Status de pendente de opções
    produto.status = _status.elementAt(0);






    ProdutoRepository.setNovoProduto(produto).then((prod) {

      CategoriaProduto cp = new CategoriaProduto();
      cp.categoria = categoria;
      cp.produto = prod;


      CategoriaProdutoRepository.setNovaCategoriaProduto(cp).then((value){


        _dialogOpcoesProduto(prod);


      });

    });


  }





  void _dialogOpcoesProduto(Produto produto) {
    showDialog(context: context,
      builder: (BuildContext context) {

        return AlertDialog(

          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
          CustomContainer.fotoCircular(produto.fotoPrincipal, 40, 40, 40, Colors.orange),
              Text(produto.titulo),
              Divider(),
              Text("Cadastrar tamanhos e cores deste produto?",textAlign: TextAlign.center,),
            ],
          ),
          actions: <Widget>[

            new FlatButton(

              child: new Text("Agora não", style: TextStyle(color: Colors.grey),),
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ProdutosPage() ));
              },
            ),
            new FlatButton(

              child: new Text("Cadastrar"),
              onPressed: () {


                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => OpcoesProdutoPage(produto) ));


              },
            ),
          ],
        );
      },
    );
  }



}
