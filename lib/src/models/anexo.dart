class Anexo {
  String? idEmp;
  String? idUni;
  String? idAtendimentoCRA;
  String? idTipoCRA;
  String? maquina;
  String? caminho;
  String? arquivo;
  String? descricao;
  int? idImagem;
  String? idUsuInc;
  String? idUsuAlt;
  String? id;
  int? codigo;
  String? dtInc;
  String? dtAlt;

  Anexo({
    this.idEmp,
    this.idUni,
    this.idAtendimentoCRA,
    this.idTipoCRA,
    this.maquina,
    this.caminho,
    this.arquivo,
    this.descricao,
    this.idImagem,
    this.idUsuInc,
    this.idUsuAlt,
    this.id,
    this.codigo,
    this.dtInc,
    this.dtAlt,
  });

  Anexo.fromJson(Map<String, dynamic> json) {
    idEmp = json['idEmp'];
    idUni = json['idUni'];
    idAtendimentoCRA = json['idAtendimentoCRA'];
    idTipoCRA = json['idTipoCRA'];
    maquina = json['maquina'];
    caminho = json['caminho'];
    arquivo = json['arquivo'];
    descricao = json['descricao'];
    idImagem = json['idImagem'];
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
    data['idTipoCRA'] = idTipoCRA;
    data['maquina'] = maquina;
    data['caminho'] = caminho;
    data['arquivo'] = arquivo;
    data['descricao'] = descricao;
    data['idImagem'] = idImagem;
    data['idUsuInc'] = idUsuInc;
    data['idUsuAlt'] = idUsuAlt;
    data['id'] = id;
    data['codigo'] = codigo;
    data['dtInc'] = dtInc;
    data['dtAlt'] = dtAlt;
    return data;
  }
}
