class ProcedimentoAgendaMedica {
  String? idEmp;
  String? idUni;
  int? procedimentoCodigo;
  String? procedimentoNome;
  String? idAgendaMedica;
  String? idUsuInc;
  String? idUsuAlt;
  String? id;
  int? codigo;
  String? dtInc;
  String? dtAlt;

  ProcedimentoAgendaMedica({
    this.idEmp,
    this.idUni,
    this.procedimentoCodigo,
    this.procedimentoNome,
    this.idAgendaMedica,
    this.idUsuInc,
    this.idUsuAlt,
    this.id,
    this.codigo,
    this.dtInc,
    this.dtAlt,
  });

  ProcedimentoAgendaMedica.fromJson(Map<String, dynamic> json) {
    idEmp = json['idEmp'];
    idUni = json['idUni'];
    procedimentoCodigo = json['procedimentoCodigo'];
    procedimentoNome = json['procedimentoNome'];
    idAgendaMedica = json['idAgendaMedica'];
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
    data['procedimentoCodigo'] = procedimentoCodigo;
    data['procedimentoNome'] = procedimentoNome;
    data['idAgendaMedica'] = idAgendaMedica;
    data['idUsuInc'] = idUsuInc;
    data['idUsuAlt'] = idUsuAlt;
    data['id'] = id;
    data['codigo'] = codigo;
    data['dtInc'] = dtInc;
    data['dtAlt'] = dtAlt;
    return data;
  }
}
