class Status {
  String? idEmp;
  String? idUni;
  String? nome;
  bool? ativo;
  bool? fixo;
  String? idUsuInc;
  String? idUsuAlt;
  String? id;
  int? codigo;
  String? dtInc;
  String? dtAlt;

  Status({this.idEmp, this.idUni, this.nome, this.ativo, this.fixo, this.idUsuInc, this.idUsuAlt, this.id, this.codigo, this.dtInc, this.dtAlt});

  Status.fromJson(Map<String, dynamic> json) {
    idEmp = json['idEmp'];
    idUni = json['idUni'];
    nome = json['nome'];
    ativo = json['ativo'];
    fixo = json['fixo'];
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
    data['ativo'] = ativo;
    data['fixo'] = fixo;
    data['idUsuInc'] = idUsuInc;
    data['idUsuAlt'] = idUsuAlt;
    data['id'] = id;
    data['codigo'] = codigo;
    data['dtInc'] = dtInc;
    data['dtAlt'] = dtAlt;
    return data;
  }
}
