class TipoContratacao {
  String? nome;
  String? telosRgUs;
  String? telosRgDt;
  String? telosUpUs;
  String? telosUpDt;
  int? codigo;

  TipoContratacao({this.nome, this.telosRgUs, this.telosRgDt, this.telosUpUs, this.telosUpDt, this.codigo});

  TipoContratacao.fromJson(Map<String, dynamic> json) {
    nome = json['nome'];
    telosRgUs = json['telosRgUs'];
    telosRgDt = json['telosRgDt'];
    telosUpUs = json['telosUpUs'];
    telosUpDt = json['telosUpDt'];
    codigo = json['codigo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nome'] = nome;
    data['telosRgUs'] = telosRgUs;
    data['telosRgDt'] = telosRgDt;
    data['telosUpUs'] = telosUpUs;
    data['telosUpDt'] = telosUpDt;
    data['codigo'] = codigo;
    return data;
  }
}
