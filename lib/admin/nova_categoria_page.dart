import 'dart:convert' ;
import 'dart:io';
import 'dart:io' as Io;
import 'package:ecommerce_template/model/categoria.dart';
import 'package:ecommerce_template/repository/categoria_repository.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NovaCategoriaPage extends StatefulWidget {

  Categoria categoria;
  NovaCategoriaPage(this.categoria);



  @override
  _NovaCategoriaPageState createState() => _NovaCategoriaPageState();
}

class _NovaCategoriaPageState extends State<NovaCategoriaPage> {

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController categoriaController = TextEditingController();
  File _image1;
 Categoria _categoria;


  @override
  void initState() {

    _getDadosCategoria();
    super.initState();
  }


  _getDadosCategoria(){

    setState(() {

      if(widget.categoria != null) {
        _categoria = widget.categoria;
        categoriaController.text = _categoria.titulo;

      }else{
        _categoria = new Categoria();

      }
    });

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        title: Text("Nova Categoria", style: TextStyle(color: Colors.orange),),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[

              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                  controller: categoriaController,
                  decoration: InputDecoration(
                      hintText: 'Título da Categoria'
                  ),
                  validator: (value){
                    if(value.isEmpty){
                      return 'Insira o nome da categoria';
                    }else if(value.length > 10){
                      return 'O nome da categoria não pode ter mais que dez letras';
                    }
                    
                  },
                ),
              ),


              Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: OutlineButton(
                          borderSide: BorderSide(color: Colors.grey.withOpacity(
                              0.5), width: 2.5),
                          onPressed: () {
                            _selectImage(ImagePicker.pickImage(source: ImageSource.gallery), 1);
                          },
                          child: _displayChild1()
                      ),
                    ),
                  ),

                ],
              ),


              SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: FlatButton(
                    color: Colors.orange,
                    textColor: Colors.white,
                    child: Text('Adicionar Categoria'),
                    onPressed: () {
                     validateAndUpload();
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }



  void _selectImage(Future<File> pickImage, int imageNumber) async{

    File tempImg = await pickImage;

    setState(() => _image1 = tempImg);


  }

  Widget _displayChild1() {

    if(_categoria.foto !=  null) {

      return CircleAvatar(

        radius: 100,
        backgroundImage: MemoryImage(
          base64Decode(widget.categoria.foto),
        ),
      );

    }else{
    if(_image1 == null){
      return Padding(
        padding: const EdgeInsets.fromLTRB(14, 70, 14, 70),
        child: Column(
          children: <Widget>[
            Text("Selecione a Imagem",style: TextStyle(color: Colors.grey),),
            Icon(Icons.add, color: Colors.grey,),
          ],
        ),
      );
    }else{
      return Image.file(_image1, fit: BoxFit.fill, width: double.infinity,);
    }
  }}


  void validateAndUpload() {
    if(_formKey.currentState.validate()){
      if(_image1 != null ){

          _categoria.titulo = categoriaController.text;

          List<int> imageBytes = _image1.readAsBytesSync();
          _categoria.foto = base64.encode(imageBytes);

          CategoriaRepository.setNovaCategoria(_categoria).then((value){

            Fluttertoast.showToast(msg: 'Categoria adicionada com sucesso!' );
            Navigator.pop(context);


          });

      }else{
        Fluttertoast.showToast(msg: 'Adicione uma foto!');
      }
    }
  }
}
