class Assunto {
  String? idEmp;
  String? idUni;
  String? nome;
  String? idUsuInc;
  String? idUsuAlt;
  String? id;
  int? codigo;
  String? dtInc;
  String? dtAlt;

  Assunto({this.idEmp, this.idUni, this.nome, this.idUsuInc, this.idUsuAlt, this.id, this.codigo, this.dtInc, this.dtAlt});

  Assunto.fromJson(Map<String, dynamic> json) {
    idEmp = json['idEmp'];
    idUni = json['idUni'];
    nome = json['nome'];
    idUsuInc = json['idUsuInc'];
    idUsuAlt = json['idUsuAlt'];
    id = json['id'];
    codigo = json['codigo'];
    dtInc = json['dtInc'];
    dtAlt = json['dtAlt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idEmp'] = idEmp;
    data['idUni'] = idUni;
    data['nome'] = nome;
    data['idUsuInc'] = idUsuInc;
    data['idUsuAlt'] = idUsuAlt;
    data['id'] = id;
    data['codigo'] = codigo;
    data['dtInc'] = dtInc;
    data['dtAlt'] = dtAlt;
    return data;
  }
}
