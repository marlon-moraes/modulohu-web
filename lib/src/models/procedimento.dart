class Procedimento {
  int? codigo;
  String? nome;
  String? telosRgUs;
  String? telosRgDt;
  String? telosUpUs;
  String? telosUpDt;
  int? autoId;

  Procedimento({this.codigo, this.nome, this.telosRgUs, this.telosRgDt, this.telosUpUs, this.telosUpDt, this.autoId});

  Procedimento.fromJson(Map<String, dynamic> json) {
    codigo = json['codigo'];
    nome = json['nome'];
    telosRgUs = json['telosRgUs'];
    telosRgDt = json['telosRgDt'];
    telosUpUs = json['telosUpUs'];
    telosUpDt = json['telosUpDt'];
    autoId = json['autoId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['codigo'] = codigo;
    data['nome'] = nome;
    data['telosRgUs'] = telosRgUs;
    data['telosRgDt'] = telosRgDt;
    data['telosUpUs'] = telosUpUs;
    data['telosUpDt'] = telosUpDt;
    data['autoId'] = autoId;
    return data;
  }
}
