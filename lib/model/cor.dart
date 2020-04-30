class Cor {
  int id;
  String cor;

  Cor({this.id, this.cor});

  Cor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cor = json['cor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cor'] = this.cor;
    return data;
  }
}
