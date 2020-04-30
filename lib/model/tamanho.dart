class Tamanho {
  int id;
  String tamanho;
  String altura;
  String largura;

  Tamanho({this.id, this.tamanho, this.altura, this.largura});

  Tamanho.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tamanho = json['tamanho'];
    altura = json['altura'];
    largura = json['largura'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tamanho'] = this.tamanho;
    data['altura'] = this.altura;
    data['largura'] = this.largura;
    return data;
  }
}
