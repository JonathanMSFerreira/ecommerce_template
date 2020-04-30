import 'package:ecommerce_template/model/categoria_produto.dart';
import 'package:ecommerce_template/model/cor_tam_produto.dart';
import 'package:ecommerce_template/model/foto_produto.dart';

class Produto {
  int id;
  String titulo;
  String descricao;
  String fotoPrincipal;
  double precoCompra;
  double precoVenda;
  bool   emPromocao;
  int    qtdTotal;

  List<CorTamProdutos> corTamProdutos;
//  List<Null> favoritos;
//  List<Null> carrinhos;
  List<CategoriaProduto> categorias;

  Produto(
      {this.id,
        this.titulo,
        this.descricao,
        this.fotoPrincipal,
        this.precoCompra,
        this.emPromocao,
        this.precoVenda,
        this.qtdTotal,
        this.categorias,
        this.corTamProdutos,
//        this.favoritos,
//        this.carrinhos,

      });

  Produto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    titulo = json['titulo'];
    descricao = json['descricao'];
    fotoPrincipal = json['fotoPrincipal'];
    precoCompra = json['precoCompra'];
    emPromocao = json['emPromocao'];
    precoVenda = json['precoVenda'];
    qtdTotal = json['qtdTotal'];


    if (json['corTamProdutos'] != null) {
      corTamProdutos = new List<CorTamProdutos>();
      json['corTamProdutos'].forEach((v) {
        corTamProdutos.add(new CorTamProdutos.fromJson(v));
      });
    }
//    if (json['favoritos'] != null) {
//      favoritos = new List<Null>();
//      json['favoritos'].forEach((v) {
//        favoritos.add(new Null.fromJson(v));
//      });
//    }
//    if (json['carrinhos'] != null) {
//      carrinhos = new List<Null>();
//      json['carrinhos'].forEach((v) {
//        carrinhos.add(new Null.fromJson(v));
//      });
//    }
    if (json['categorias'] != null) {
      categorias = new List<CategoriaProduto>();
      json['categorias'].forEach((v) {
        categorias.add(new CategoriaProduto.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['titulo'] = this.titulo;
    data['descricao'] = this.descricao;
    data['fotoPrincipal'] = this.fotoPrincipal;
    data['precoCompra'] = this.precoCompra;
    data['emPromocao'] = this.emPromocao;
    data['precoVenda'] = this.precoVenda;
    data['qtdTotal'] = this.qtdTotal;


    if (this.corTamProdutos != null) {
      data['corTamProdutos'] =
          this.corTamProdutos.map((v) => v.toJson()).toList();
    }
//    if (this.favoritos != null) {
//      data['favoritos'] = this.favoritos.map((v) => v.toJson()).toList();
//    }
//    if (this.carrinhos != null) {
//      data['carrinhos'] = this.carrinhos.map((v) => v.toJson()).toList();
//    }
    if (this.categorias != null) {
      data['categorias'] = this.categorias.map((v) => v.toJson()).toList();
    }
    return data;
  }
}




