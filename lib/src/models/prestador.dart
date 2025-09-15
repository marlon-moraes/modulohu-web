class Prestador {
  String? id;
  int? codigo;
  String? idEmp;
  String? idUni;
  String? nome;
  String? idUsuAlt;

  Prestador({this.id, this.codigo, this.idEmp, this.idUni, this.nome, this.idUsuAlt});

  Prestador.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    codigo = json['codigo'];
    idEmp = json['idEmp'];
    idUni = json['idUni'];
    nome = json['nome'];
    idUsuAlt = json['idUsuAlt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['codigo'] = codigo;
    data['idEmp'] = idEmp;
    data['idUni'] = idUni;
    data['nome'] = nome;
    data['idUsuAlt'] = idUsuAlt;
    return data;
  }
}
