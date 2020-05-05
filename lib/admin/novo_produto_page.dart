import 'dart:convert';
import 'dart:io';
import 'package:ecommerce_template/admin/cor_tam_produto_page.dart';
import 'package:ecommerce_template/admin/produtos_page.dart';
import 'package:ecommerce_template/model/categoria.dart';
import 'package:ecommerce_template/model/categoria_produto.dart';
import 'package:ecommerce_template/model/produto.dart';
import 'package:ecommerce_template/model/status.dart';
import 'package:ecommerce_template/repository/categoria_produto_repository.dart';
import 'package:ecommerce_template/repository/categoria_repository.dart';
import 'package:ecommerce_template/repository/produto_repository.dart';
import 'package:ecommerce_template/repository/status_repository.dart';
import 'package:ecommerce_template/utils/constants.dart';
import 'package:ecommerce_template/widgets/custom_containers.dart';
import 'package:ecommerce_template/widgets/custom_loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  bool _btnPressed = false;
  final _formKey = GlobalKey<FormState>();
  final _precoCompra = TextEditingController();
  final _precoVenda = TextEditingController();
  final _titulo  = TextEditingController();
  final _descricao = TextEditingController();
  final _precoPromocional = TextEditingController();
  Categoria _categoria;
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
          ? CustomLoading.container("Carregando dados...", Colors.orange)
          : _buildFormNovoProduto(context),
    );
  }

  _buildFormNovoProduto(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                flex: 1,
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

          _foto == null && _btnPressed ==  true ?
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:8.0),
            child: Text('Inclua uma imagem para o produto', style: TextStyle(color: Colors.red[800], fontSize: 12),),
          ): Container(),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _titulo,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: 'Título *',
              ),
              onSaved: (String value) {
                setState(() {
                  _titulo.text = value;
                });

              },
              validator: (String value) {
                return value == '' ? 'Campo obrigatório' : null;
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _descricao,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: 'Descrição *',
              ),
              onSaved: (String value) {
                setState(() {
                  _descricao.text = value;
                });

              },
              validator: (String value) {
                return value == '' ? 'Campo obrigatório' : null;
              },
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Categoria *"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: DropdownButton(
                    
                    isExpanded: true,
                    items: _categorias.map((Categoria cat) {
                      return DropdownMenuItem<Categoria>(
                        value: cat,
                        child: Text(cat.titulo),
                      );
                    }).toList(),
                    hint: Text('Escolha a categoria '),
                    
                    value: _categoria,
                    onChanged: (value) {
                      setState(() {
                        _categoria = value;

                      });
                    },
                  ),
                ),
              ),
              _categoria ==  null && _btnPressed == true ?
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:8.0),
                child: Text('Campo obrigatório', style: TextStyle(color: Colors.red[800], fontSize: 12),),
              ): Container(),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [


              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 170,
                  child: TextFormField(
                    controller: _precoCompra,
                    keyboardType: TextInputType.numberWithOptions(
                        signed: false, decimal: true),
                    decoration: const InputDecoration(
                      labelText: 'Preço compra *',
                    ),
                    onSaved: (String value) {
                      setState(() {
                        _precoCompra.text = value;
                      });

                    },
                    validator: (String value) {
                      return value == '' ? 'Campo obrigatório' : null;
                    },
                  ),
                ),
              ),


              SizedBox(
                width: 5,
              ),
              Flexible(
                  child:  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _precoVenda,
                      keyboardType: TextInputType.numberWithOptions(
                          signed: false, decimal: true),
                      decoration: const InputDecoration(
                        labelText: 'Preço venda *',
                      ),
                      onSaved: (String value) {
                        setState(() {
                          _precoVenda.text = value;
                        });

                      },
                      validator: (String value) {
                        return value == '' ? 'Campo obrigatório' : null;
                      },
                    ),
                  ),

              ),
            ],
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
               isChecked == true ? Flexible(
                  child:  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _precoPromocional,
                      keyboardType: TextInputType.numberWithOptions(
                          signed: false, decimal: true),
                      decoration: const InputDecoration(
                        labelText: 'Preço Promocional *',
                      ),
                      onSaved: (String value) {
                        setState(() {
                          _precoPromocional.text = value;
                        });

                      },

                      validator: (String value) {
                        return value == '' ? 'Campo obrigatório' : null;
                      },
                    ),
                  ),
                ): Container(),
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
    );
  }

  void _selecionaFoto(Future<File> pickImage, int imageNumber) async {
    File tempImg = await pickImage;
    setState(() => _foto = tempImg);
  }

  void toggleCheckbox(bool value) {
    if (isChecked == false) {
      setState(() {
        _precoPromocional.text = "";
        isChecked = true;
      });
    } else {
      setState(() {
        _precoPromocional.text = "";
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


    setState(() {
      _btnPressed = true;
    });


    if (_formKey.currentState.validate()) {

      Produto produto = new Produto();
      produto.titulo = _titulo.text;
      produto.descricao = _descricao.text;
      produto.precoCompra = double.parse(_precoCompra.text);
      produto.precoVenda = double.parse(_precoVenda.text);
      List<int> imageBytes = _foto.readAsBytesSync();
      String base64Image = base64Encode(imageBytes);
      produto.fotoPrincipal = base64Image;
      produto.emPromocao = isChecked;
      //Status de pendente de opções
      produto.qtdTotal = 0;
      produto.status = _status.elementAt(0);

      produto.precoPromocao =  isChecked == true ? double.parse(_precoPromocional.text) : null;

      ProdutoRepository.setNovoProduto(produto).then((prod) {

      CategoriaProduto cp = new CategoriaProduto();
      cp.categoria = _categoria;
      cp.produto = prod;

      CategoriaProdutoRepository.setNovaCategoriaProduto(cp).then((value){
          _dialogOpcoesProduto(prod);
        });

      });
    }
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


                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => CorTamProdutoPage(produto) ));


              },
            ),
          ],
        );
      },
    );
  }



}
