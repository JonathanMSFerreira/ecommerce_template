class Categoria {

  int id;
  String titulo;
  String foto;


  Categoria({this.id, this.titulo, this.foto});

  Categoria.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    titulo = json['titulo'];
    foto = json['foto'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['titulo'] = this.titulo;
    data['foto'] = this.foto;

    return data;
  }
}