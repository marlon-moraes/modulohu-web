class Telefone {
  String? ddd;
  String? numero;
  int? pessoa;
  String? inicioVigencia;
  String? telosRgUs;
  String? telosRgDt;
  String? telosUpUs;
  String? telosUpDt;
  int? autoId;

  Telefone({this.ddd, this.numero, this.pessoa, this.inicioVigencia, this.telosRgUs, this.telosRgDt, this.telosUpUs, this.telosUpDt, this.autoId});

  Telefone.fromJson(Map<String, dynamic> json) {
    ddd = json['ddd'];
    numero = json['numero'];
    pessoa = json['pessoa'];
    inicioVigencia = json['inicioVigencia'];
    telosRgUs = json['telosRgUs'];
    telosRgDt = json['telosRgDt'];
    telosUpUs = json['telosUpUs'];
    telosUpDt = json['telosUpDt'];
    autoId = json['autoId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ddd'] = ddd;
    data['numero'] = numero;
    data['pessoa'] = pessoa;
    data['inicioVigencia'] = inicioVigencia;
    data['telosRgUs'] = telosRgUs;
    data['telosRgDt'] = telosRgDt;
    data['telosUpUs'] = telosUpUs;
    data['telosUpDt'] = telosUpDt;
    data['autoId'] = autoId;
    return data;
  }
}
