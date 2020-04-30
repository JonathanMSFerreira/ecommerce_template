import 'package:ecommerce_template/model/categoria.dart';
import 'package:ecommerce_template/model/produto.dart';

class CategoriaProduto {


  int id;
  Categoria categoria;
  Produto produto;

  CategoriaProduto({this.id, this.categoria, this.produto});

  CategoriaProduto.fromJson(Map<String, dynamic> json) {

    id = json['id'];
    produto = json['produto'] != null ? new Produto.fromJson(json['produto']) : null;
    categoria = json['categoria'] != null ? new Categoria.fromJson(json['categoria']) : null;
  }

  Map<String, dynamic> toJson() {

    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id'] = this.id;
    if (this.produto != null) {
      data['produto'] = this.produto.toJson();
    }
    if (this.categoria != null) {
      data['categoria'] = this.categoria.toJson();
    }
    return data;
  }

}
