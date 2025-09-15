class Evento {
  String? idEmp;
  String? idUni;
  String? idAtendimentoCRA;
  String? titulo;
  String? descricao;
  String? usuario;
  String? dtEvento;
  String? idUsuInc;
  String? idUsuAlt;
  String? id;
  int? codigo;
  String? dtInc;
  String? dtAlt;

  Evento({
    this.idEmp,
    this.idUni,
    this.idAtendimentoCRA,
    this.titulo,
    this.descricao,
    this.usuario,
    this.dtEvento,
    this.idUsuInc,
    this.idUsuAlt,
    this.id,
    this.codigo,
    this.dtInc,
    this.dtAlt,
  });

  Evento.fromJson(Map<String, dynamic> json) {
    idEmp = json['idEmp'];
    idUni = json['idUni'];
    idAtendimentoCRA = json['idAtendimentoCRA'];
    titulo = json['titulo'];
    descricao = json['descricao'];
    usuario = json['usuario'];
    dtEvento = json['dtEvento'];
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
    data['idAtendimentoCRA'] = idAtendimentoCRA;
    data['titulo'] = titulo;
    data['descricao'] = descricao;
    data['usuario'] = usuario;
    data['dtEvento'] = dtEvento;
    data['idUsuInc'] = idUsuInc;
    data['idUsuAlt'] = idUsuAlt;
    data['id'] = id;
    data['codigo'] = codigo;
    data['dtInc'] = dtInc;
    data['dtAlt'] = dtAlt;
    return data;
  }
}
