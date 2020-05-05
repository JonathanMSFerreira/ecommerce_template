import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:ecommerce_template/model/foto_produto.dart';
import 'package:ecommerce_template/model/produto.dart';
import 'package:ecommerce_template/repository/foto_produto_repository.dart';
import 'package:ecommerce_template/utils/constants.dart';
import 'package:ecommerce_template/widgets/custom_containers.dart';
import 'package:ecommerce_template/widgets/custom_texts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class FotosProdutoPage extends StatefulWidget {


  Produto produto;


  FotosProdutoPage(this.produto);

  @override
  _FotosProdutoPageState createState() => _FotosProdutoPageState();
}

class _FotosProdutoPageState extends State<FotosProdutoPage> {


  bool isChecked = false;

  File _foto;
  List<FotoProduto> _fotos;



  @override
  void initState() {
    _getFotosProduto();
    super.initState();



  }

  _getFotosProduto()  {

    FotosProdutoRepository.getFotosProduto(widget.produto).then((value) {
      setState(() {
        _fotos = value;
        _foto = null;
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
          "Imagens do Produto",
          style: TextStyle(color: Colors.orange),
        ),
      ),


      body:

      _fotos == null
          ? Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(),
                  Text("Carregando dados...", style: TextStyle(color: Colors.orange),)
                ],
              ),
            )
          :

      _buildFormNovoProduto(context),
    );
  }

  _buildFormNovoProduto(BuildContext context) {
    return ListView(

      shrinkWrap: true,
      children: <Widget>[

        Padding(
          padding: const EdgeInsets.all(8.0),

          child: Card(

            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: ListTile(

                title: Text(widget.produto.titulo),
                subtitle: CustomTexts.subTitulo("Status: ",widget.produto.status.status, 14, Colors.black, Colors.grey),
                leading: CustomContainer.fotoCircular(widget.produto.fotoPrincipal, 50, 50, 50, Colors.orange),


              ),

            ),
          ),
        ),
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

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Imagens Adicionadas", style: TextStyle(color: Colors.orange,fontSize: 15),),
        ),


        Expanded(
          flex: 1,
          child: GridView.builder(
            physics: NeverScrollableScrollPhysics(),

            shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(

                  crossAxisCount: 2

              ),

              itemCount: _fotos.length,

              itemBuilder: (context,index){

                return Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Card(

                    child: Column(

                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.all(2),
                          height: 130,
                          child: Image.memory(
                            base64Decode(_fotos[index].foto),
                            fit: BoxFit.cover,
                          ),
                        ),
                        FlatButton(onPressed: (){

                          _dialogRemoveFoto(_fotos[index]);


                        }, child: Text("Remover", style: TextStyle(color: Colors.red),))



                      ],
                    ),
                  ),
                );


              }),
        )

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
        child: Container(
          height: 80,
          child: Column(
            children: <Widget>[
              Icon(
                Icons.photo_camera,
                color: grey,
              ),
              Text("Selecione uma Imagem", style: TextStyle(color: grey))
            ],
          ),
        ),
      );
    } else {
      return Column(
        children: <Widget>[
          Container(
            height: 130,
            child: Image.file(
              _foto,
              fit: BoxFit.contain,
              width: double.infinity,
            ),
          ),

          RaisedButton(
           onPressed: (){

             _buttonNovaFoto();


           },
            color: Colors.orange,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.add, color: Colors.white,),
                Text("Adicionar",style: TextStyle(color: Colors.white),),
              ],
            ),
          )


        ],
      );
    }
  }

  void _buttonNovaFoto() {
    FotoProduto fp = new FotoProduto();
    List<int> imageBytes = _foto.readAsBytesSync();
    String base64Image = base64Encode(imageBytes);
    fp.foto  = base64Image;
    fp.produto = widget.produto;
    FotosProdutoRepository.setFotoProduto(fp).then((fotoProduto) {

      _getFotosProduto();

    });
  }

  void _dialogRemoveFoto(FotoProduto fotoProduto) {
    showDialog(context: context,
      builder: (BuildContext context) {

        return AlertDialog(

          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
          CustomContainer.fotoCircular(fotoProduto.foto, 40, 40, 40, Colors.orange),

              Divider(),
              Text("Remover essa imagem do produto?",textAlign: TextAlign.center,),
            ],
          ),
          actions: <Widget>[

            new FlatButton(

              child: new Text("Cancelar", style: TextStyle(color: Colors.grey),),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            new FlatButton(

              child: new Text("Remover"),
              onPressed: () {

                Navigator.pop(context);

                FotosProdutoRepository.removeFotoProduto(fotoProduto.id).then((fotoProduto) {
                  _getFotosProduto();

                });


              },
            ),
          ],
        );
      },
    );
  }



}
