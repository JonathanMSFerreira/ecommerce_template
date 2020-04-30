import 'package:ecommerce_template/animations/FadeAnimation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ListaCarrinho extends StatefulWidget {
  @override
  _ListaCarrinhoState createState() => _ListaCarrinhoState();
}

class _ListaCarrinhoState extends State<ListaCarrinho> {
  var products = [
    {
      "name": "Blazer Black",
      "picture": "assets/images/products/blazer1.jpeg",
      "price": 85,
      "size": "M",
      "color": "Vermelho",
      "quantity": 1
    } ,{
      "name": "Blazer Black",
      "picture": "assets/images/products/blazer1.jpeg",
      "price": 85,
      "size": "M",
      "color": "Azul",
      "quantity": 10000
    },{
      "name": "Blazer Black",
      "picture": "assets/images/products/blazer1.jpeg",
      "price": 85,
      "size": "M",
      "color": "Red",
      "quantity": 10000
    },{
      "name": "Blazer Black",
      "picture": "assets/images/products/blazer1.jpeg",
      "price": 85,
      "size": "M",
      "color": "Red",
      "quantity": 10000
    },{
      "name": "Blazer Black",
      "picture": "assets/images/products/blazer1.jpeg",
      "price": 85,
      "size": "M",
      "color": "Red",
      "quantity": 10000
    },{
      "name": "Blazer Black",
      "picture": "assets/images/products/blazer1.jpeg",
      "price": 85,
      "size": "M",
      "color": "Red",
      "quantity": 10000
    }
  ];

  @override
  Widget build(BuildContext context) {
    double fadeTime = 1.0;
    return ListView.separated(

        separatorBuilder: (BuildContext context, int index) => Divider(),

        itemCount: products.length,
        itemBuilder: (context, index) {

          fadeTime = fadeTime + 0.2;

          return _itemProduct(
              products[index]["name"],
              products[index]["picture"],
              products[index]["price"],
              products[index]["size"],
              products[index]["color"],
              products[index]["quantity"],
              fadeTime

          );
        });
  }

  _itemProduct(name, picture, price, size, color, quantity, fadeTime) {
    return FadeAnimation(fadeTime,  Padding(
      padding: const EdgeInsets.only(top:8),
      child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Padding(
            padding: const EdgeInsets.only(left:8.0),
            child: Image.asset(picture, fit: BoxFit.cover,width: 100, height: 150,),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8.0,8.0,8.0,0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Text(name, style: TextStyle(fontSize: 20,),overflow: TextOverflow.fade,),
                     Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Icon(Icons.delete_outline, color: Colors.grey,),
                     )],
                 ),
                  Row(
                    children: [
                      Text("Cor: ",),
                      Text(color, style: TextStyle(color: Colors.deepOrange)),
                    ],
                  ),
                  Row(
                    children: [
                      Text("Tamanho: ",),
                      Text(
                        size,
                        style: TextStyle(color: Colors.deepOrange),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      Text("Preço Unitário:",),
                      Text("R\$ $price", style: TextStyle( color: Colors.red))],

                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [

                          Text("Sub Total:",style: TextStyle(fontWeight: FontWeight.bold),),

                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              "R\$ $price",
                              style: TextStyle(

                                  fontWeight: FontWeight.bold,
                                  color: Colors.red),
                            ),
                          )
                        ],
                      ),

                       
                         Row(
                            mainAxisAlignment: MainAxisAlignment.end,

                            children: [
                              IconButton(icon: Icon(Icons.remove), onPressed: () {}),
                              Text(quantity.toString()),
                              IconButton(icon: Icon(Icons.add), onPressed: () {}),
                            ],
                          ),

                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      )),
    ));
  }
}
