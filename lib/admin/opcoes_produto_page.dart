import 'dart:convert';
import 'dart:io';
import 'package:ecommerce_template/model/cor.dart';
import 'package:ecommerce_template/model/cor_tam_produto.dart';
import 'package:ecommerce_template/model/produto.dart';
import 'package:ecommerce_template/model/tamanho.dart';
import 'package:ecommerce_template/repository/cor_tam_produto_repository.dart';
import 'package:ecommerce_template/repository/cores_repository.dart';
import 'package:ecommerce_template/repository/tamanhos_repository.dart';
import 'package:ecommerce_template/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:groovin_widgets/outline_dropdown_button.dart';




class OpcoesProdutoPage extends StatefulWidget {


  Produto produto;


  OpcoesProdutoPage(this.produto);

  @override
  _OpcoesProdutoPageState createState() => _OpcoesProdutoPageState();
}

class _OpcoesProdutoPageState extends State<OpcoesProdutoPage> {




  var quantidade;

  Tamanho tamanho;
  Cor cor;

  List<Cor> _cores;
  List<Tamanho> _tamanhos;
  List<CorTamProdutos> _corTamprodutos;

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

      CorTamanhoProdutoRepository.getCorTamProdutosByProduto(widget.produto).then((ctp) {
        setState(() {
          _corTamprodutos = ctp;


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

        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[

            Container(

              width: 30.0,
              height: 30.0,
              child: Image.memory(
                base64Decode(widget.produto.fotoPrincipal),
                fit: BoxFit.contain,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:8.0),
              child: Text(widget.produto.titulo),
            ),

          ],
        ),
      ),
      body: _cores == null || _tamanhos == null || _corTamprodutos == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : _buildOpcoesProduto(context),
    );
  }


  void _buttonNovoItem() {

    CorTamProdutos ctp = new CorTamProdutos();

    ctp.tamanho = tamanho;
    ctp.cor = cor;
    ctp.produto = widget.produto;
    ctp.qtdEstoqueInicial = int.parse(quantidade);
    ctp.qtdEstoqueAtual = int.parse(quantidade);

    CorTamanhoProdutoRepository.setNovaCorTamProduto(ctp).then((value) {
      CorTamanhoProdutoRepository.getCorTamProdutosByProduto(widget.produto).then((value){
        setState(() {
          _corTamprodutos = value;

          tamanho = null;
          cor = null;
          quantidade = null;

        });
      });
    });
  }



  _buildOpcoesProduto(context) {
    return Column(
      children: <Widget>[



        ListView(
        shrinkWrap: true,
        children: <Widget>[

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Cadastre uma opção", style: TextStyle(color: Colors.orange),),
        ),


        Card(

          child: Column(
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
                  items: _cores.map((Cor c) {
                    return DropdownMenuItem<Cor>(
                      value: c,
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
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Tamanho"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: OutlineDropdownButton(
                  isDense: true,
                  items: _tamanhos.map((Tamanho t) {
                    return DropdownMenuItem<Tamanho>(
                      value: t,
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
              ),

              Row(

                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 150,
                      height: 50,
                      child: TextField(
                        decoration: new InputDecoration(
                          labelText: 'Qtd Estoque',
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

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 50,

                      child: FlatButton(
                        color: Colors.orange,
                        textColor: white,
                        child: Text('Adicionar Opção'),
                        onPressed: () {
                          _buttonNovoItem();
                        },),),),],),
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
            shrinkWrap: true,
            itemCount: _corTamprodutos.length,
            itemBuilder: (context,index){

               return Container(

                 height: 90,
                 child: Card(
                   child: Column(
                     mainAxisSize: MainAxisSize.min,
                     children: <Widget>[
                       Row(
                         crossAxisAlignment: CrossAxisAlignment.start,

                         mainAxisAlignment: MainAxisAlignment.start,
                         children: <Widget>[

                           Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Row(
                               children: <Widget>[
                                 Text("Cor: ", style: TextStyle(fontWeight: FontWeight.bold),),
                                 Text(_corTamprodutos[index].cor.cor),
                               ],
                             ),
                           ),

                           Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Row(
                               children: <Widget>[
                                 Text("Tam: ", style: TextStyle(fontWeight: FontWeight.bold),),
                                 Text(_corTamprodutos[index].tamanho.tamanho),
                               ],
                             ),
                           ),

                           Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Row(
                               children: <Widget>[
                                 Text("Estoque: ", style: TextStyle(fontWeight: FontWeight.bold),),
                                 Text(_corTamprodutos[index].qtdEstoqueInicial.toString()),
                               ],
                             ),
                           ),
                         ],
                       ),

                     ],
                   ),
                 ),
               );}

          )]),
      ],
    );
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

//                ProdutoRepository.removeProduto(produto.id).then((value){
//                  Navigator.of(context).pop();
//                  _carregaDados();
//                });
              },
            ),
          ],
        );
      },
    );
  }



}
