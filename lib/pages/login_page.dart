import 'package:ecommerce_template/animations/FadeAnimation.dart';
import 'package:ecommerce_template/model/categoria.dart';
import 'package:ecommerce_template/model/produto.dart';
import 'package:ecommerce_template/model/usuario.dart';
import 'package:ecommerce_template/pages/esqueci_senha_page.dart';
import 'package:ecommerce_template/pages/loja_page.dart';

import 'package:ecommerce_template/pages/nova_conta_page.dart';
import 'package:ecommerce_template/repository/categoria_repository.dart';
import 'package:ecommerce_template/repository/produto_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {


  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();

  List<Produto> _itens;
  List<Categoria> _categorias;

  bool loading = false;


  @override
  void initState() {

    super.initState();
  }


  _carregaDadosLoja() async{

    setState(() {
      loading = true;
    });

   _itens = await ProdutoRepository.getProdutos();

   _categorias = await CategoriaRepository.getCategorias();

    setState(() {

          loading = false;

    });

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LojaPage(_itens, _categorias)));

  }

  @override
  dispose() {
    _emailTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        body: ListView(
          children: <Widget>[
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    // Box decoration takes a gradient
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.orange[900].withOpacity(0.9),
                        Colors.orange[800].withOpacity(0.8),
                        Colors.orange[700].withOpacity(0.7),
                        Colors.orange.withOpacity(0.6),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FadeAnimation(
                          1,
                          Container(
                              child: Image.asset(
                            'assets/images/logotipo-empresa.png',
                            width: 100.0,
                          ))),
                      SizedBox(
                        height: 15,
                      ),
                      Form(
                          key: _formKey,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 30.0),
                            child: Column(
                              children: <Widget>[
                                Material(
                                  color: Colors.white.withOpacity(0.8),
                                  elevation: 0.0,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 12.0),
                                    child: TextFormField(
                                      controller: _emailTextController,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Email",
                                        icon: Icon(Icons.alternate_email),
                                      ),
                                      onSaved: (value) {
                                        setState(() {
                                          _emailTextController.text = value;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Material(
                                  color: Colors.white.withOpacity(0.8),
                                  elevation: 0.0,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 12.0),
                                    child: TextFormField(
                                      obscureText: true,
                                      controller: _passwordTextController,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Senha",
                                        icon: Icon(Icons.lock_outline),
                                      ),
                                      onSaved: (value) {
                                        setState(() {
                                          _passwordTextController.text = value;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 22,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 50.0,
                                  child: RaisedButton(
                                    onPressed: () {

                                       _carregaDadosLoja();






                                     },

//                                      if (_formKey.currentState.validate()) {
//                                         ResponseApi response =  await LoginApi.login("user@user.com", "123");
//                                 //       ResponseApi response = await LoginApi.login(_emailTextController.text, _passwordTextController.text);
//                                        if (response.ok) {
//                                          Usuario user = response.result;
//                                          Navigator.pushReplacement(
//                                            context,
//                                            MaterialPageRoute(
//                                                builder: (context) =>
//                                                    HomePage(_itens)));

                                   //     } else {
                                     //     _displaySnackBar(_scaffoldKey, response.msg);
//                                        }
//                                      } else {
//                                        _displaySnackBar(_scaffoldKey,
//                                          "Forneça seu email e senha!",
//                                        );
//                                      }

                                    padding: EdgeInsets.all(0.0),
                                    child: Ink(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [

                                            Colors.orange[900].withOpacity(0.9),
                                            Colors.orange[800].withOpacity(0.8),

                                          ],
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                        ),
                                        //    borderRadius: BorderRadius.circular(18.0)
                                      ),
                                      child: Container(
                                        constraints: BoxConstraints(
                                            maxWidth: MediaQuery.of(context)
                                                .size
                                                .width,
                                            minHeight: 50.0),
                                        alignment: Alignment.center,
                                        child: loading == false ? Text(
                                          "Entrar",
                                          style:
                                          TextStyle(fontSize: 18.0, color: Colors.white),
                                        ) :


                                        Container(

                                          height: 20,
                                          width: 20,

                                          child: CircularProgressIndicator(

                                            valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),


                                            //  backgroundColor: Colors.white,
                                          ),)





//                                        Text(
//                                          "Entrar na loja",
//                                          textAlign: TextAlign.center,
//                                          style: TextStyle(color: Colors.white),
//                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Container(
                                  color: Colors.transparent,
                                  width: MediaQuery.of(context).size.width,
                                  height: 50.0,
                                  child: FlatButton(
                                    color: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                        side: BorderSide(color: Colors.white)),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  NovaContaPage()));
                                    },
                                    padding: EdgeInsets.all(0.0),
                                    child: Text(
                                      "Criar uma conta",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  color: Colors.transparent,
                                  width: MediaQuery.of(context).size.width,
                                  height: 50.0,
                                  child: FlatButton(
                                    color: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                        side: BorderSide(color: Colors.white)),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  EsqueciSenhaPage()));
                                    },
                                    padding: EdgeInsets.all(0.0),
                                    child: Text(
                                      "Esqueci minha senha",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _getEmailValid(value) {
    if (value.isEmpty) {
      Pattern pattern =
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regex = new RegExp(pattern);
      if (!regex.hasMatch(value))
        return 'Please make sure your email address is valid';
      else
        return null;
    }
  }

  _displaySnackBar( key, response) {
    final snackBar = SnackBar(
      content: Text(response),
      backgroundColor: Colors.red,
      duration: Duration(seconds: 2),

    );

    key.currentState.showSnackBar(snackBar);
  }
}
