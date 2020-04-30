import 'dart:convert';
import 'dart:io';
import 'package:ecommerce_template/model/categoria.dart';
import 'package:ecommerce_template/model/categoria_produto.dart';
import 'package:ecommerce_template/model/cor.dart';
import 'package:ecommerce_template/model/produto.dart';
import 'package:ecommerce_template/model/tamanho.dart';
import 'package:ecommerce_template/repository/cores_repository.dart';
import 'package:ecommerce_template/repository/produto_repository.dart';
import 'package:ecommerce_template/repository/tamanhos_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:groovin_widgets/outline_dropdown_button.dart';
import 'package:image_picker/image_picker.dart';

enum Page { geral, especifico }

class NovoProdutoPage extends StatefulWidget {


  List<Categoria> categorias;
  Produto produto;


  NovoProdutoPage(this.produto, this.categorias);

  @override
  _NovoProdutoPageState createState() => _NovoProdutoPageState();
}

class _NovoProdutoPageState extends State<NovoProdutoPage> {


  Page _selectedPage = Page.geral;
  MaterialColor active = Colors.orange;
  MaterialColor notActive = Colors.grey;

  Color white = Colors.white;
  Color black = Colors.black;
  Color grey = Colors.grey;
  Color red = Colors.red;

  bool isChecked = false;

  File _foto;
  var quantidade;
  var precoCompra;
  var precoVenda;
  var nome;
  var descricao;
  String categoria;
  String tamanho;
  String cor;

  List<Cor> _cores;
  List<Tamanho> _tamanhos;

  @override
  void initState() {
    _getDadosNovoProduto();
    super.initState();
  }

  _getDadosNovoProduto() {
    CoresRepository.getCores().then((c) {
      setState(() {
        _cores = c;
      });

      TamanhosRepository.getTamanhos().then((t) {
        setState(() {
          _tamanhos = t;
        });
      });
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
      body: _cores == null || _tamanhos == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : _mostraPainel(context),
    );
  }

  _buildFormNovoProduto(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          child: Row(
            children: <Widget>[
              Expanded(
                  child: FlatButton.icon(
                      onPressed: () {
                        setState(() => _selectedPage = Page.geral);
                      },
                      icon: Icon(
                        Icons.dashboard,
                        color: _selectedPage == Page.geral ? active : notActive,
                      ),
                      label: Text('Geral'))),
              Expanded(
                  child: FlatButton.icon(
                      onPressed: () {
                        setState(() => _selectedPage = Page.especifico);
                      },
                      icon: Icon(
                        Icons.sort,
                        color: _selectedPage == Page.especifico
                            ? active
                            : notActive,
                      ),
                      label: Text('Específico'))),
            ],
          ),
        ),
        Expanded(
          child: ListView(
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
                      items: widget.categorias.map((cat) {
                        return DropdownMenuItem<String>(
                          value: cat.titulo,
                          child: Text(cat.titulo),
                        );
                      }).toList(),
                      hint: Text('Escolha a categoria'),
                      isExpanded: true,
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
   // CategoriaProduto  cp = new CategoriaProduto();

    produto.titulo = nome;
    produto.descricao = descricao;
    produto.precoCompra = double.parse(precoCompra);
    produto.precoVenda = double.parse(precoVenda);
    List<int> imageBytes = _foto.readAsBytesSync();
    String base64Image = base64Encode(imageBytes);
    produto.fotoPrincipal = base64Image;


//    if(categoria != '' || categoria != null) {
//      for (Categoria c in widget.categorias ){
//        if(c.titulo == categoria){
//          cp.categoria = c;
//
//        }
//      }
//    }

   // cp.produto = produto;

//    if(produto.categorias == null){
//
//      List<CategoriaProduto> lcp = new List<CategoriaProduto>();
//      lcp.add(cp);
//      produto.categorias = lcp;
//
//
//    }else{

  //    produto.categorias.add(cp);

    //}

    print("ok");

    ProdutoRepository.setNovoProduto(produto);

  }

  _mostraPainel(context) {
    switch (_selectedPage) {
      case Page.geral:
        return _buildFormNovoProduto(context);
      case Page.especifico:
        return _buildFormEspecifico(context);
        break;
      default:
        return Container();
    }
  }

  _buildFormEspecifico(context) {
    return Column(children: <Widget>[
      Container(
        child: Row(
          children: <Widget>[
            Expanded(
                child: FlatButton.icon(
                    onPressed: () {
                      setState(() => _selectedPage = Page.geral);
                    },
                    icon: Icon(
                      Icons.dashboard,
                      color: _selectedPage == Page.geral ? active : notActive,
                    ),
                    label: Text('Geral'))),
            Expanded(
                child: FlatButton.icon(
                    onPressed: () {
                      setState(() => _selectedPage = Page.especifico);
                    },
                    icon: Icon(
                      Icons.sort,
                      color:
                          _selectedPage == Page.especifico ? active : notActive,
                    ),
                    label: Text('Especifico'))),
          ],
        ),
      ),
      Expanded(
      child: ListView(
      shrinkWrap: true,
      children: <Widget>[

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Cor"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: OutlineDropdownButton(
                isDense: true,
                items: _cores.map((c) {
                  return DropdownMenuItem<String>(
                    value: c.cor,
                    child: Text(c.cor),
                  );
                }).toList(),
                hint: Text('Escolha a cor'),
                isExpanded: true,
                value: cor,
                onChanged: (value) {
                  setState(() {
                    cor = value;
                  });
                },
              ),
            )
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Tamanho"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: OutlineDropdownButton(
                isDense: true,
                items: _tamanhos.map((t) {
                  return DropdownMenuItem<String>(
                    value: t.tamanho,
                    child: Text(t.tamanho),
                  );
                }).toList(),
                hint: Text('Escolha um tamanho'),
                isExpanded: true,
                value: tamanho,
                onChanged: (value) {
                  setState(() {
                    tamanho = value;
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 150,
                height: 50,
                child: TextField(
                  decoration: new InputDecoration(
                    labelText: 'Quantidade',
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
            ],
          ),
        ),

       ])
      )
    ]);
  }
}
