import 'dart:convert';
import 'dart:io';
import 'package:ecommerce_template/admin/produtos_page.dart';
import 'package:ecommerce_template/model/cor.dart';
import 'package:ecommerce_template/model/cor_tam_produto.dart';
import 'package:ecommerce_template/model/produto.dart';
import 'package:ecommerce_template/model/status.dart';
import 'package:ecommerce_template/model/tamanho.dart';
import 'package:ecommerce_template/repository/cor_tam_produto_repository.dart';
import 'package:ecommerce_template/repository/cores_repository.dart';
import 'package:ecommerce_template/repository/produto_repository.dart';
import 'package:ecommerce_template/repository/status_repository.dart';
import 'package:ecommerce_template/repository/tamanhos_repository.dart';
import 'package:ecommerce_template/utils/constants.dart';
import 'package:ecommerce_template/widgets/custom_colors.dart';
import 'package:ecommerce_template/widgets/custom_containers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:groovin_widgets/outline_dropdown_button.dart';




class CorTamProdutoPage extends StatefulWidget {


  Produto produto;




  CorTamProdutoPage(this.produto);

  @override
  _CorTamProdutoPageState createState() => _CorTamProdutoPageState();


}

class _CorTamProdutoPageState extends State<CorTamProdutoPage> {


  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  final _formKey = GlobalKey<FormState>();
  final _estoque = TextEditingController();
  bool _btnCorPressed = false;
  bool _btnTamanhoPressed = false;

  Tamanho tamanho;
  Cor cor;

  List<Cor> _cores;
  List<Status> _status;
  List<Tamanho> _tamanhos;
  List<CorTamProdutos> _corTamprodutos;

  @override
  void initState() {
    _carregaOpcoesProduto();
    super.initState();
  }

  _carregaOpcoesProduto() async{
      _cores = await CoresRepository.getCores();
     _tamanhos = await TamanhosRepository.getTamanhos();
     _status = await StatusRepository.getStatus();
     _corTamprodutos = await CorTamanhoProdutoRepository.getCorTamProdutosByProduto(widget.produto);

      setState(() {
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: (){

          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProdutosPage()));

        }),
        elevation: 1,
        backgroundColor: white,
        title: Text("Opções do Produto", style: TextStyle(color: Colors.orange),)
      ),
      body: _cores == null || _tamanhos == null || _corTamprodutos == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : _buildOpcoesProduto(context),
    );
  }

  void _buttonNovoItem(context) {

    setState(() {
      _btnCorPressed = true;
      _btnTamanhoPressed = true;
    });

    if (_formKey.currentState.validate() && cor != null  && tamanho != null) {



      for(CorTamProdutos ctp in _corTamprodutos){
        if( cor.id == ctp.cor.id && tamanho.id == ctp.tamanho.id){


          var snackbar = new SnackBar(content: new Text("Cor e tamanho já cadastrados!"));
          _scaffoldKey.currentState.showSnackBar(snackbar);
          return;

        }

      }





      CorTamProdutos ctp = new CorTamProdutos();
      ctp.tamanho = tamanho;
      ctp.cor = cor;
      ctp.produto = widget.produto;
      ctp.qtdEstoqueInicial = int.parse(_estoque.text);
      ctp.qtdEstoqueAtual = int.parse(_estoque.text);

      CorTamanhoProdutoRepository.setNovaCorTamProduto(ctp).then((value) {

        widget.produto.status = _status.elementAt(1);


        CorTamanhoProdutoRepository.getCorTamProdutosByProduto(widget.produto).then((value) {

          ProdutoRepository.setNovoProduto(widget.produto).then((prod) {

          setState(() {
            _corTamprodutos = value;

            _btnCorPressed = false;
            _btnTamanhoPressed = false;

            tamanho = null;
            cor = null;
            _estoque.text = "";





          });
        });
        });
      });
    }
  }


  _buildOpcoesProduto(context) {
    return Form(
        key: _formKey,
        child:ListView(
    shrinkWrap: true,
    children: <Widget>[




    Padding(
      padding: const EdgeInsets.all(5.0),
      child: Text("Cadastre uma opção", style: TextStyle(color: Colors.orange),),
    ),


    Card(

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[

          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: DropdownButton(

                isExpanded: true,
                items: _cores.map((Cor c) {
                  return DropdownMenuItem<Cor>(
                    value: c,
                    child: Text(c.cor),
                  );
                }).toList(),
                hint: Text('Escolha uma cor'),
                value: cor,
                onChanged: (value) {
                  setState(() {
                    cor = value;

                  });

                },
              ),
            ),
          ),
          cor ==  null && _btnCorPressed == true ?
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:5.0),
            child: Text('Campo obrigatório', style: TextStyle(color: Colors.red[800], fontSize: 12),),
          ): Container(),


          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: DropdownButton(

                isExpanded: true,
                items: _tamanhos.map((Tamanho t) {
                  return DropdownMenuItem<Tamanho>(
                    value: t,
                    child: Text(t.tamanho),
                  );
                }).toList(),
                hint: Text('Escolha um tamanho'),
                value: tamanho,
                onChanged: (value) {
                  setState(() {
                    tamanho = value;

                  });
                },
              ),
            ),
          ),
          tamanho ==  null && _btnTamanhoPressed == true ?
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:8.0),
            child: Text('Campo obrigatório', style: TextStyle(color: Colors.red[800], fontSize: 12),),
          ): Container(),




          Padding(
            padding: const EdgeInsets.all(5),
            child: TextFormField(
              controller: _estoque,
              keyboardType: TextInputType.numberWithOptions(
                  signed: false, decimal: false),
              decoration: const InputDecoration(
                labelText: 'Estoque Inicial*',
              ),
              onSaved: (String value) {
                setState(() {
                  _estoque.text = value;
                });

              },
              validator: (String value) {
                return value == '' ? 'Campo obrigatório' : null;
              },
            ),
          ),




          Row(
            mainAxisAlignment:  MainAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  height: 40,

                  child: FlatButton(
                    color: Colors.orange,
                    textColor: white,
                    child: Text('Adicionar'),
                    onPressed: () {
                      _buttonNovoItem(context);
                    },),),),
            ],
          ),
        ],
      )

    ),

      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text("Opções cadastradas", style: TextStyle(color: Colors.orange),),
      ),


      _corTamprodutos.isEmpty || _corTamprodutos == null ?

       Container(
         height: 100,
         child: Center(child: Text("Nenhuma opção cadastrada!",style: TextStyle(color: Colors.grey))),)
      :

      ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: _corTamprodutos.length,
        itemBuilder: (context,index){

           return Container(

             height: 100,
             child: Card(
               child: Column(
                 mainAxisSize: MainAxisSize.min,
                 children: <Widget>[
                   Row(
                     crossAxisAlignment: CrossAxisAlignment.start,

                     mainAxisAlignment: MainAxisAlignment.start,
                     children: <Widget>[

                       Container(


                         color:  CustomColors.convert(_corTamprodutos[index].cor.cor) ,

                         width: 30,
                         height: 30,



                       ),


                       Padding(
                         padding: const EdgeInsets.all(5.0),
                         child: Row(
                           children: <Widget>[
                             Text("Cor: ", style: TextStyle(fontWeight: FontWeight.bold),),
                             Text(_corTamprodutos[index].cor.cor),
                           ],
                         ),
                       ),


               //        _getTamQuantidadeByCor(_corTamprodutos[index], _corTamprodutos[index].cor.id);




                       Padding(
                         padding: const EdgeInsets.all(5.0),
                         child: Row(
                           children: <Widget>[
                             Text("Tam: ", style: TextStyle(fontWeight: FontWeight.bold),),
                             Text(_corTamprodutos[index].tamanho.tamanho),
                           ],
                         ),
                       ),

                       Padding(
                         padding: const EdgeInsets.all(5.0),
                         child: Row(
                           children: <Widget>[
                             Text("Estoque: ", style: TextStyle(fontWeight: FontWeight.bold),),
                             Text(_corTamprodutos[index].qtdEstoqueInicial.toString()),
                           ],
                         ),
                       ),
                     ],
                   ),

                   Row(
                     mainAxisAlignment: MainAxisAlignment.end,
                       children: [
                         FlatButton(
                            onPressed: (){
                              _dialogRemoverOpcao(_corTamprodutos[index]);
                            },
                           child: Text("Remover", style: TextStyle(color: Colors.red),),
                         )
                       ],
                   )


                 ],



               ),
             ),
           );}

      )]));
  }


  void _dialogRemoverOpcao(CorTamProdutos ctp) {
    showDialog(
      context: context,
      builder: (BuildContext context) {

        return AlertDialog(

          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[

              Text(ctp.produto.titulo),
              Text(ctp.cor.cor),
              Text(ctp.tamanho.tamanho),
              Divider(),
              Text("Deseja remover essa opção?",textAlign: TextAlign.center,),
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

                CorTamanhoProdutoRepository.removeCorTamProduto(ctp.id).then((value){
                  Navigator.of(context).pop();
                 _carregaOpcoesProduto();
                });
              },
            ),
          ],
        );
      },
    );
  }





  }




