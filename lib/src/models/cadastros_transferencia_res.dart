class CadastrosTransferenciaRes {
  String? id;
  int? codigo;
  String? idEmp;
  String? idUni;
  String? nome;
  String? dtInc;
  String? idUsuInc;
  String? dtAlt;
  String? idUsuAlt;

  CadastrosTransferenciaRes({this.id, this.codigo, this.idEmp, this.idUni, this.nome, this.dtInc, this.idUsuInc, this.dtAlt, this.idUsuAlt});

  CadastrosTransferenciaRes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    codigo = json['codigo'];
    idEmp = json['idEmp'];
    idUni = json['idUni'];
    nome = json['nome'];
    dtInc = json['dtInc'];
    idUsuInc = json['idUsuInc'];
    dtAlt = json['dtAlt'];
    idUsuAlt = json['idUsuAlt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['codigo'] = codigo;
    data['idEmp'] = idEmp;
    data['idUni'] = idUni;
    data['nome'] = nome;
    data['dtInc'] = dtInc;
    data['idUsuInc'] = idUsuInc;
    data['dtAlt'] = dtAlt;
    data['idUsuAlt'] = idUsuAlt;
    return data;
  }
}
