import 'package:ecommerce_template/pages/compra_finalizada_page.dart';
import 'package:flutter/material.dart';

class ResumoCompraPage extends StatefulWidget {
  @override
  _ResumoCompraPageState createState() => _ResumoCompraPageState();
}

class _ResumoCompraPageState extends State<ResumoCompraPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        title: Text("Resumo da compra", style: TextStyle(color: Colors.orange)),
      ),
      body: Container(),
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
                child: Text("Finalizar",style: TextStyle(color: Colors.white),),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>CompraFinalizadaPage()));
                }
            ))
          ],
        ),
      ),

    );
  }
}
