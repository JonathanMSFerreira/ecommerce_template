import 'package:ecommerce_template/componets/lista_carrinho.dart';
import 'package:ecommerce_template/pages/endereco_page.dart';
import 'package:flutter/material.dart';

class CarrinhoPage extends StatefulWidget {
  @override
  _CarrinhoPageState createState() => _CarrinhoPageState();
}

class _CarrinhoPageState extends State<CarrinhoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(
            color: Colors.orange
        ),
        elevation: 1,
        title: Text("Meu Carrinho", style: TextStyle(color: Colors.orange),),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Expanded(child: ListTile(
              title: Text("Total", style: TextStyle(color: Colors.grey, fontSize: 20, fontWeight: FontWeight.bold),),
              subtitle: Text("R\$ 230",style: TextStyle(color: Colors.red, fontSize: 20, fontWeight: FontWeight.bold), ),
            )),
            Expanded(child: MaterialButton(

              color: Colors.orange,
                child: Text("Check out",style: TextStyle(color: Colors.white),),
                onPressed: (){
                     Navigator.push(context, MaterialPageRoute(builder: (context)=>EnderecoPage()));
                }
            ))
          ],
        ),
      ),
      body: ListaCarrinho()
    );
  }
}
