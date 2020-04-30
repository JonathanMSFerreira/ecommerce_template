import 'package:flutter/material.dart';
import 'package:ecommerce_template/animations/FadeAnimation.dart';
import 'package:flutter/cupertino.dart';


class CompraFinalizadaPage extends StatefulWidget {
  @override
  _CompraFinalizadaPageState createState() => _CompraFinalizadaPageState();
}

class _CompraFinalizadaPageState extends State<CompraFinalizadaPage> {


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

                      SizedBox(height: 45,),

                      Text("Parabéns!", style: TextStyle(color: Colors.white, fontSize: 30),),
                      SizedBox(height: 30,),
                      Text("Você acabou de adquirir um excelente produto!", style: TextStyle(color: Colors.white, fontSize: 15),),


                      SizedBox(height: 15,),
                      Text("Nós agradecemos, e esperamos vê-lo(a) em breve!",style: TextStyle(color: Colors.white,)),


                      SizedBox(height: 45,),
                      Container(
                        width: MediaQuery.of(context).size.width/2,
                        height: 50.0,
                        child: RaisedButton(
                          onPressed: () {
                    //        Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                          },
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
                              constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width, minHeight: 50.0),
                              alignment: Alignment.center,
                              child: Text(
                                "Voltar para Loja",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

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
