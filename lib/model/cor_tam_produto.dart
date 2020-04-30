import 'package:ecommerce_template/model/cor.dart';
import 'package:ecommerce_template/model/foto_produto.dart';
import 'package:ecommerce_template/model/produto.dart';
import 'package:ecommerce_template/model/tamanho.dart';

class CorTamProdutos {

 int id;
  Cor cor;
  Tamanho tamanho;
  Produto produto;
  int qtdEstoque;
  List<FotoProduto> fotos;

  CorTamProdutos(
      {this.id, this.cor, this.tamanho, this.produto, this.fotos, this.qtdEstoque});

  CorTamProdutos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cor = json['cor'] != null ? new Cor.fromJson(json['cor']) : null;
    tamanho =
    json['tamanho'] != null ? new Tamanho.fromJson(json['tamanho']) : null;
    produto = json['produto'] != null ? new Produto.fromJson(json['produto']) : null;
    qtdEstoque = json['qtdEstoque'];
    if (json['fotos'] != null) {
      fotos = new List<FotoProduto>();
      json['fotos'].forEach((v) {
        fotos.add(new FotoProduto.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.cor != null) {
      data['cor'] = this.cor.toJson();
    }
    if (this.tamanho != null) {
      data['tamanho'] = this.tamanho.toJson();
    }
    if (this.produto != null) {
      data['produto'] = this.produto.toJson();
    }
    data['qtdEstoque'] = this.qtdEstoque;
    if (this.fotos != null) {
      data['fotos'] = this.fotos.map((v) => v.toJson()).toList();
    }
    return data;
  }
}