import 'dart:convert';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:ecommerce_template/model/foto_produto.dart';
import 'package:ecommerce_template/model/produto.dart';
import 'package:ecommerce_template/pages/carrinho_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProdutoPage extends StatefulWidget {

  Produto item;
  ProdutoPage(this.item);

  @override
  _ProdutoPageState createState() => _ProdutoPageState();
}

class _ProdutoPageState extends State<ProdutoPage> {


  int _corSelecionada;

  bool _corInserido = false;

  int _tamanhoSelecionado;

  bool _tamanhoInserido = false;

  @override
  void initState() {

    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  ListView _buildBody(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        Container(

          color: Colors.white.withOpacity(0.9),
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
        children: <Widget>[

          _buildStackImages(context, widget.item),


          Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Text(
              'Selecione uma cor',
              style: TextStyle(color: Colors.grey, fontSize: 20, fontWeight: FontWeight.bold,)
            ),
          ),
          carregaCores(),


          Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Text(
              'Selecione um tamanho',
              style: TextStyle(color: Colors.grey, fontSize: 20, fontWeight: FontWeight.bold,)
            ),
          ),
          carregaTamanhos(),

          Row(
            children: [


              Material(
                //    borderRadius: BorderRadius.circular(15.0),
                  color: Colors.white,
                  elevation: 0.0,
                  child: MaterialButton(
                    onPressed: () {},
                    minWidth: 24,
                    child: Padding(
                      padding: const EdgeInsets.only(right:8.0),
                      child: Icon(Icons.favorite_border, color: Colors.red,),
                    ),
                  )),

              Material(
                //    borderRadius: BorderRadius.circular(15.0),
                  color: Colors.orangeAccent,
                  elevation: 0.0,
                  child: MaterialButton(
                    onPressed: () {},
                    minWidth: 24,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.add_shopping_cart, color: Colors.white,),
                    ),
                  )),
              Flexible(
                child: Material(
                  //    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.blue,
                    elevation: 0.0,
                    child: MaterialButton(
                      onPressed: () {},
                    
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right:8.0),
                            child: Icon(Icons.check, color: Colors.white,),
                          ),

                          Text(
                            "Comprar",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0),
                          ),
                        ],
                      ),
                    )),
              ),

            ],
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text('Descrição', style:  TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold,)),
                            Text('Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry standard dummy text ever since the 1500s  Lorem Ipsum has been the industry standard dummy text ever since the 1500s ', textAlign: TextAlign.justify ,style: TextStyle(color: Colors.black)),

                          ],
                        ),
                      ),
                    ),

        ],
          ),
        ),
      ],
    );
  }



  Widget carregaTamanhos() {

    return Container(
      height: 50,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: widget.item.corTamProdutos.length,

          itemBuilder: (context, index) {
            return Padding(
                padding: EdgeInsets.all(8.0),
                child: GestureDetector(
                  child: Stack(
                    children: [
                      Center(
                        child: Container(
                          width: 35.0,
                          height: 35.0,
                          child: Center(child: Text(widget.item.corTamProdutos[index].tamanho.tamanho)),
                          decoration: new BoxDecoration(

                            color: Colors.grey.withOpacity(0.5),



                          ),
                        ),
                      ),
                      _tamanhoSelecionado == index
                          ? Center(
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 30.0,
                          ))
                          : Container()
                    ],
                  ),
                  onTap: () {
                    setState(() {
                      _tamanhoSelecionado = index;
                      //tmpDisciplina.cor = cores[index].value;
                      _tamanhoInserido = true;
                    });
                  },
                ));
          }),
    );
  }


  Color _listaCores(String cor) {


    switch (cor) {

      case 'Azul':
        return Colors.blue;
      case 'Vermelha':
        return Colors.red;
      case 'Preta':
        return Colors.black;
      case 'Rosa':
        return Colors.pink;
      case 'Amarela':
        return Colors.yellow;
      case 'Branca':
        return Colors.white;
      case 'Verde':
        return Colors.green;
      case 'Cinza':
        return Colors.grey;
      case 'Marrom':
        return Colors.brown;
      case 'Laranja':
        return Colors.orange;
      case 'Roxo':
        return Colors.purple;


    }

  }

  Widget carregaCores() {
    return Container(
      height: 50,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: widget.item.corTamProdutos.length,

          itemBuilder: (context, index) {
            return Padding(
                padding: EdgeInsets.all(8.0),
                child: GestureDetector(
                  child: Stack(
                    children: [
                      Center(
                        child: Container(
                          width: 35.0,
                          height: 35.0,
                          decoration: new BoxDecoration(
                            color: _listaCores(widget.item.corTamProdutos[index].cor.cor),

                          ),
                        ),
                      ),
                      _corSelecionada == widget.item.corTamProdutos[index].cor.id
                          ? Center(
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 30.0,
                          ))
                          : Container()
                    ],
                  ),
                  onTap: () {
                    setState(() {
                      _corSelecionada = widget.item.corTamProdutos[index].cor.id;
                      //tmpDisciplina.cor = cores[index].value;
                      _corInserido = true;
                    });
                  },
                ));
          }),
    );
  }



  AppBar _buildAppBar(BuildContext context) {
    return AppBar(

      iconTheme: IconThemeData(
          color: Colors.orange
      ),
      elevation: 1,
      title:  Container(
        height: 40,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.orange),
            color: Colors.white),
        child: TextField(
          cursorColor: Colors.orange,
          decoration: InputDecoration(
            hintStyle: TextStyle(fontSize: 15, color: Colors.grey[300]),
            hintText: ' Encontre na loja',
            fillColor: Colors.orange,
            suffixIcon: Icon(
              Icons.search,
              color: Colors.orange,
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(12),
          ),
        ),
      ),

      actions: <Widget>[

        GestureDetector(
          onTap: (){

            Navigator.push(context, MaterialPageRoute(builder: (context) => CarrinhoPage()));

          },
          child: Padding(
              padding: const EdgeInsets.all(4),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.shopping_cart, color: Colors.orange,),
              )
          ),
        ),

      ],
    );
  }


//  List<Image> _carregaFotosProduto(){
//
//    List<Image> images = new List<Image>();
//
//    for(FotoProduto f in widget.item.fotos ){
//
//     images.add(Image.memory(
//
//        base64Decode(f.foto),
//        //  color: Colors.orange,
//        fit: BoxFit.contain,
//        height: 200,
//        width: double.infinity,
//      ));
//
//  }
//
//
//      return images;
//
//
//
//  }


  Stack _buildStackImages(BuildContext context, Produto item) {
    return Stack(

        children: <Widget>[

//        Container(
//            height: 300.0,
//            child: new Carousel(
//              boxFit: BoxFit.cover,
//              images: _carregaFotosProduto(),
//              animationCurve: Curves.fastOutSlowIn,
//              animationDuration: Duration(milliseconds: 1000),
//              dotSize: 4.0,
//              indicatorBgPadding: 2.0,
//              dotBgColor: Colors.transparent,
//            ),
//          ),

          Align(
            alignment: Alignment.topCenter,
            child: Container(
                height: 80,
                decoration: BoxDecoration(
                  // Box decoration takes a gradient
                  gradient: LinearGradient(
                    // Where the linear gradient begins and ends
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    // Add one stop for each color. Stops should increase from 0 to 1
                    colors: [
                      // Colors are easy thanks to Flutter's Colors class.

                      Colors.white.withOpacity(0.3),
                      Colors.white.withOpacity(0.1),
                      Colors.white.withOpacity(0.025),
                    ],
                  ),
                ),

                child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Container()
                )),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[


              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(

                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.3),

                    ),

                      child: Text("1/10",
                        style: TextStyle(color: Colors.white),))
              ),

            ],
          ),

//          Align(
//            alignment: Alignment.bottomCenter,
//            child: Container(
//                height: 200,
//                decoration: BoxDecoration(
//                  // Box decoration takes a gradient
//                  gradient: LinearGradient(
//                    // Where the linear gradient begins and ends
//                    begin: Alignment.bottomCenter,
//                    end: Alignment.topCenter,
//                    // Add one stop for each color. Stops should increase from 0 to 1
//                    colors: [
//                      // Colors are easy thanks to Flutter's Colors class.
//                      Colors.white.withOpacity(0.8),
//                      Colors.white.withOpacity(0.6),
//                      Colors.white.withOpacity(0.6),
//                      Colors.white.withOpacity(0.4),
//                      Colors.white.withOpacity(0.07),
//                      Colors.white.withOpacity(0.05),
//                      Colors.white.withOpacity(0.025),
//                    ],
//                  ),
//                ),
//
//                child: Padding(
//                    padding: const EdgeInsets.only(top: 8.0),
//                    child: Container()
//                )
//            ),
//          ),


     
          Positioned(
              bottom: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text('Blazer', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w300,fontSize: 20),),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text('R\$ 35.99', textAlign: TextAlign.end,style: TextStyle(color: Colors.black, fontSize: 26, fontWeight: FontWeight.bold),),
                    ),
                  ],
                ),
              )),




        ],
      );
  }
}