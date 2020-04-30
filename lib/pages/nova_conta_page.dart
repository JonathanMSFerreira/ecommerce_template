import 'package:ecommerce_template/animations/FadeAnimation.dart';
import 'package:ecommerce_template/pages/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NovaContaPage extends StatefulWidget {
  @override
  _NovaContaPageState createState() => _NovaContaPageState();
}

class _NovaContaPageState extends State<NovaContaPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();

  bool loading = false;
  bool isLogedin = false;

  @override
  void initState() {
    super.initState();
    isSignedIn();
  }

  void isSignedIn() async {
    setState(() {
      loading = true;
    });

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                      FadeAnimation(1, Container(

                          child: Image.asset(
                            'assets/images/logotipo-empresa.png',
                            width: 100.0,

                          ))),

                      SizedBox(height: 15,),
                      Form(
                          key: _formKey,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 30.0),
                            child: Column(
                              children: <Widget>[
                                Material(
                         //         borderRadius: BorderRadius.circular(15.0),
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
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          Pattern pattern =
                                              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                          RegExp regex = new RegExp(pattern);
                                          if (!regex.hasMatch(value))
                                            return 'Please make sure your email address is valid';
                                          else
                                            return null;
                                        }
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Material(
                              //    borderRadius: BorderRadius.circular(15.0),
                                  color: Colors.white.withOpacity(0.8),
                                  elevation: 0.0,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 12.0),
                                    child: TextFormField(
                                      controller: _passwordTextController,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Senha",
                                        icon: Icon(Icons.lock_outline),
                                      ),
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return "O campo de senha não pode estar vazio";
                                        } else if (value.length < 6) {
                                          return "A senha deve ter mais de 5 caracteres";
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ),

                                SizedBox(
                                  height: 10,
                                ),

                                Material(
                               //   borderRadius: BorderRadius.circular(15.0),
                                  color: Colors.white.withOpacity(0.8),
                                  elevation: 0.0,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 12.0),
                                    child: TextFormField(
                                      controller: _passwordTextController,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Confirmar Senha",
                                        icon: Icon(Icons.lock_outline),
                                      ),
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return "O campo de senha não pode estar vazio";
                                        } else if (value.length < 6) {
                                          return "A senha deve ter mais de 5 caracteres";
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ),





                                SizedBox(
                                  height: 18,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 50.0,
                                  child: RaisedButton(
                                    onPressed: () {
//                                      Navigator.push(
//                                          context,
//                                          MaterialPageRoute(
//                                              builder: (context) =>
//                                                  HomePage()));
                                    },
//                                    shape: RoundedRectangleBorder(
//                                        borderRadius:
//                                            BorderRadius.circular(80.0)),
                                    padding: EdgeInsets.all(0.0),
                                    child: Ink(
                                      decoration: BoxDecoration(
                                        // Box decoration takes a gradient
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Colors.orange[900].withOpacity(0.9),
                                            Colors.orange[800].withOpacity(0.8),

                                          ],
                                        ),
                                      ),
                                      child: Container(
                                        constraints: BoxConstraints(
                                            maxWidth: MediaQuery.of(context)
                                                .size
                                                .width,
                                            minHeight: 50.0),
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Criar conta",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 25,
                                ),


                                Container(
                                  color: Colors.transparent,
                                  width: MediaQuery.of(context).size.width,
                                  height: 50.0,
                                  child: FlatButton(

                                    color: Colors.transparent,
                                    shape: RoundedRectangleBorder(

                                        side: BorderSide(color: Colors.white)
                                    ),


                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginPage()));
                                    },
                                    padding: EdgeInsets.all(0.0),
                                    child: Text(
                                      "Já possuo conta",
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
}
