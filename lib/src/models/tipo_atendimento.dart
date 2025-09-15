class TipoAtendimento {
  String? idEmp;
  String? idUni;
  String? nome;
  int? prazo;
  String? idUsuInc;
  String? idUsuAlt;
  String? id;
  int? codigo;
  bool? ativo;
  bool? fixo;
  String? dtInc;
  String? dtAlt;

  TipoAtendimento({
    this.idEmp,
    this.idUni,
    this.nome,
    this.prazo,
    this.idUsuInc,
    this.idUsuAlt,
    this.id,
    this.codigo,
    this.ativo,
    this.fixo,
    this.dtInc,
    this.dtAlt,
  });

  TipoAtendimento.fromJson(Map<String, dynamic> json) {
    idEmp = json['idEmp'];
    idUni = json['idUni'];
    nome = json['nome'];
    prazo = json['prazo'];
    idUsuInc = json['idUsuInc'];
    idUsuAlt = json['idUsuAlt'];
    id = json['id'];
    codigo = json['codigo'];
    ativo = json['ativo'];
    fixo = json['fixo'];
    dtInc = json['dtInc'];
    dtAlt = json['dtAlt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idEmp'] = idEmp;
    data['idUni'] = idUni;
    data['nome'] = nome;
    data['prazo'] = prazo;
    data['idUsuInc'] = idUsuInc;
    data['idUsuAlt'] = idUsuAlt;
    data['id'] = id;
    data['codigo'] = codigo;
    data['ativo'] = ativo;
    data['fixo'] = fixo;
    data['dtInc'] = dtInc;
    data['dtAlt'] = dtAlt;
    return data;
  }
}
