class Especialidade {
  int? codigo;
  int? codigoExterno;
  String? nome;
  String? sexoPermitido;
  String? telosRgUs;
  String? telosRgDt;
  String? telosUpUs;
  String? telosUpDt;
  int? autoId;

  Especialidade({
    this.codigo,
    this.codigoExterno,
    this.nome,
    this.sexoPermitido,
    this.telosRgUs,
    this.telosRgDt,
    this.telosUpUs,
    this.telosUpDt,
    this.autoId,
  });

  Especialidade.fromJson(Map<String, dynamic> json) {
    codigo = json['codigo'];
    codigoExterno = json['codigoExterno'];
    nome = json['nome'];
    sexoPermitido = json['sexoPermitido'];
    telosRgUs = json['telosRgUs'];
    telosRgDt = json['telosRgDt'];
    telosUpUs = json['telosUpUs'];
    telosUpDt = json['telosUpDt'];
    autoId = json['autoId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['codigo'] = codigo;
    data['codigoExterno'] = codigoExterno;
    data['nome'] = nome;
    data['sexoPermitido'] = sexoPermitido;
    data['telosRgUs'] = telosRgUs;
    data['telosRgDt'] = telosRgDt;
    data['telosUpUs'] = telosUpUs;
    data['telosUpDt'] = telosUpDt;
    data['autoId'] = autoId;
    return data;
  }
}
