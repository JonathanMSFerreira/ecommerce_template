import 'package:ecommerce_template/model/produto.dart';

class FotoProduto{


  int id;

  String foto;

  Produto produto;

  FotoProduto({this.id, this.foto, this.produto});

  FotoProduto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    foto = json['foto'];
    produto = json['produto'] != null ? new Produto.fromJson(json['produto']) : null;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['foto'] = this.foto;
    if (this.produto != null) {
      data['produto'] = this.produto.toJson();
    }
    return data;
  }
}
