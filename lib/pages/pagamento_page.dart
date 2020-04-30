import 'package:cielo_ecommerce/cielo_ecommerce.dart';
import 'package:ecommerce_template/pages/resumo_compra_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PagamentoPage extends StatefulWidget {
  @override
  _PagamentoPageState createState() => _PagamentoPageState();
}

class _PagamentoPageState extends State<PagamentoPage> {



    final CieloEcommerce cielo = CieloEcommerce(
        environment: Environment.sandbox,
        merchant: Merchant(
          merchantId: "118eea49-14fb-4836-b6bb-bcbe28c65db0",
          merchantKey: "FKPRUFGLXKIWGONQFUGGYORXKSHEZRPKKGELQWJH",
        ));

    _makePayment() async {

      print("Transação Simples");
      print("Iniciando pagamento....");
      //Objeto de venda
      Sale sale = Sale(
        merchantOrderId: "2020032601", // Numero de identificação do Pedido
        customer: Customer(
          name: "Comprador crédito simples", // Nome do Comprador
        ),
        payment: Payment(
          type: TypePayment.creditCard, // Tipo do Meio de Pagamento
          amount: 9, // Valor do Pedido (ser enviado em centavos)
          installments: 1, // Número de Parcelas
          softDescriptor: "Mensagem", // Descrição que aparecerá no extrato do usuário. Apenas 15 caracteres
          creditCard: CreditCard(
            cardNumber: "4024007153763191", // Número do Cartão do Comprador
            holder: 'Teste accept', // Nome do Comprador impresso no cartão
            expirationDate: '08/2030', // Data de validade impresso no cartão
            securityCode: '123', // Código de segurança impresso no verso do cartão
            brand: 'Visa', // Bandeira do cartão
          ),
        ),
      );

      try {
        var response = await cielo.createSale(sale);

        print('paymentId ${response.payment.paymentId}');

      } on CieloException catch (e) {
        print(e);
        print(e.message);
        print(e.errors[0].message);
        print(e.errors[0].code);
      }
    }

    @override
    Widget build(BuildContext context) {
      return  Scaffold(
         appBar: AppBar(
           elevation: 1,
           centerTitle: true,
           title: Text("Pagamento", style: TextStyle(color: Colors.orange),),),
        floatingActionButton: FloatingActionButton(
          onPressed: _makePayment,
          tooltip: 'Increment',
          child: Icon(Icons.add),
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
                  child: Text("Próximo",style: TextStyle(color: Colors.white),),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ResumoCompraPage()));
                  }
              ))
            ],
          ),
        ),


          body: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
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
                  height: 200,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [


                        SizedBox(height: 10,),
                        Text("Número do cartão", style: TextStyle(color:Colors.white, fontSize: 10), ),
                        Text("XXXX XXXX XXXX XXXX", style: TextStyle(color:Colors.white, fontSize: 20), ),

                        SizedBox(height: 10,),
                        Text("Data de expiração", style: TextStyle(color:Colors.white, fontSize: 10), ),
                        Text("MM/AA", style: TextStyle(color:Colors.white, fontSize: 20), ),

                        SizedBox(height: 10,),


                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Nome do titular", style: TextStyle(color:Colors.white, fontSize: 10), ),
                                Text("JOSE DA SILVA", style: TextStyle(color:Colors.white, fontSize: 20), ),

                              ],

                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("CVV", style: TextStyle(color:Colors.white, fontSize: 10), ),
                                Text("XXX", style: TextStyle(color:Colors.white, fontSize: 20), ),

                              ],

                            ),
                          ],
                        )
                      ],),),
                ),
              ),

              Divider(),

              Material(

                elevation: 0.0,
                child: Padding(
                  padding: const EdgeInsets.all( 12.0),
                  child: TextFormField(
                    //   controller: _emailTextController,
                    decoration: InputDecoration(

                      hintText: "Número do cartão",

                    ),
                    validator: (value) {
                      //   _getEmailValid(value);
                    },
                  ),
                ),
              ),

              Material(

                elevation: 0.0,
                child: Padding(
                  padding: const EdgeInsets.all( 12.0),
                  child: TextFormField(
                    //   controller: _emailTextController,
                    decoration: InputDecoration(

                      hintText: "Data de expiração",

                    ),
                    validator: (value) {
                      //   _getEmailValid(value);
                    },
                  ),
                ),
              ),

              Material(

                elevation: 0.0,
                child: Padding(
                  padding: const EdgeInsets.all( 12.0),
                  child: TextFormField(
                    //   controller: _emailTextController,
                    decoration: InputDecoration(

                      hintText: "Nome do titular",

                    ),
                    validator: (value) {
                      //   _getEmailValid(value);
                    },
                  ),
                ),
              ),

              Material(

                elevation: 0.0,
                child: Padding(
                  padding: const EdgeInsets.all( 12.0),
                  child: TextFormField(
                    //   controller: _emailTextController,
                    decoration: InputDecoration(

                      hintText: "CVV",

                    ),
                    validator: (value) {
                      //   _getEmailValid(value);
                    },
                  ),
                ),
              ),

            ],
          )

      );
    }



}
