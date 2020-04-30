
import 'package:ecommerce_template/pages/pagamento_page.dart';
import 'package:ecommerce_template/service/address_service.dart';
import 'package:flutter/material.dart';

class EnderecoPage extends StatefulWidget {
  @override
  _EnderecoPageState createState() => _EnderecoPageState();
}

class _EnderecoPageState extends State<EnderecoPage> {
  var _searchCepController = TextEditingController();
  bool _loading = false;
  bool _enableField = true;
  String _result;

  @override
  void dispose() {
    super.dispose();
    _searchCepController.clear();
  }

  @override
  Widget build(BuildContext context) {


    bool _value2 = false;


    void _value2Changed(bool value) => setState(() => _value2 = value);


    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        title: Text('Endereço de entrega', style: TextStyle(color: Colors.orange),),
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
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>PagamentoPage()));
                }
            ))
          ],
        ),
      ),


      body: SingleChildScrollView(

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[

            Padding(
              padding: const EdgeInsets.fromLTRB(15,15,15,5),
              child: Text("Informe o CEP, e tentaremos localizar o endereço", style: TextStyle(color:Colors.grey),),
            ),
            _inputTextField(autofocus: false, keyboardType: TextInputType.number, labelText:"CEP"),

            Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Checkbox(
                value: _value2,
                onChanged: _value2Changed,
              ),

              Text("Não sei informar o CEP no momento",style: TextStyle(color:Colors.grey),),
            ],
           ),
            Divider(),

            Padding(
              padding: const EdgeInsets.fromLTRB(15,0,15,0),
              child: Text("Vamos tentar com algumas informações", style: TextStyle(color:Colors.grey),),
            ),

            _inputTextField(autofocus: false, keyboardType: TextInputType.text, labelText:"UF"),
            _inputTextField(autofocus: false, keyboardType: TextInputType.text, labelText:"Cidade"),
            _inputTextField(autofocus: false, keyboardType: TextInputType.text, labelText:"Logradouro"),


            Divider(),
            Padding(
              padding: const EdgeInsets.fromLTRB(15,0,15,0),
              child: Text("Endereços cadastrados", style: TextStyle(fontSize: 18),),
            ),

            Card(
              elevation: 1,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.home),
                    title: Text('Logradouro: Avenida Beta, S/N, Parque Athenas'),
                    subtitle: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Cidade:  São Luís'),
                          Text('UF:  MA'),
                          Text('CEP: 65072-120'),
                        ],
                      ),
                    ),
                  ),
                  ButtonBar(
                    children: <Widget>[
                      FlatButton(
                        child: const Text('Editar'),
                        onPressed: () { /* ... */ },
                      ),
                      FlatButton(
                        child: const Text('Selecionar'),
                        onPressed: () { /* ... */ },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            //_buildSearchCepButton(),
            //_buildResultForm()
          ],
        ),
      ),
    );
  }

  Widget _inputTextField({autofocus=false, keyboardType, labelText,}) {


    return Padding(
      padding: const EdgeInsets.fromLTRB(15,0,15,5),
      child: TextField(
        autofocus: autofocus,
        keyboardType: keyboardType,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(labelText: labelText),
        controller: _searchCepController,
        enabled: _enableField,
      ),
    );
  }

  Widget _buildSearchCepButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: RaisedButton(
        onPressed: _searchCep,
        child: _loading ? _circularLoading() : Text('Consultar'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }

  void _searching(bool enable) {
    setState(() {
      _result = enable ? '' : _result;
      _loading = enable;
      _enableField = !enable;
    });
  }

  Widget _circularLoading() {
    return Container(
      height: 15.0,
      width: 15.0,
      child: CircularProgressIndicator(),
    );
  }

  Future _searchCep() async {
    _searching(true);

    final cep = _searchCepController.text;

    final resultCep = await ViaCepService.fetchCep(cep: cep);
    print(resultCep.localidade); // Exibindo somente a localidade no terminal

    setState(() {
      _result = resultCep.toJson();
    });

    _searching(false);
  }

  Widget _buildResultForm() {
    return Container(
      padding: EdgeInsets.only(top: 20.0),
      child: Text(_result ?? ''),
    );
  }
}