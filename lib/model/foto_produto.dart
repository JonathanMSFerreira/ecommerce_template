import 'package:ecommerce_template/model/produto.dart';

class FotoProduto{


  int id;

  String foto;

  Produto produto;

  FotoProduto({this.id, this.foto});

  FotoProduto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    foto = json['foto'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['foto'] = this.foto;
    return data;
  }
}
