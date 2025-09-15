class Cobertura {
  int? idCobertura;
  String? nomeCobertura;
  int? prioridade;
  String? carencia;
  String? carenciaBeneficiario;

  Cobertura({this.idCobertura, this.nomeCobertura, this.prioridade, this.carencia, this.carenciaBeneficiario});

  Cobertura.fromJson(Map<String, dynamic> json) {
    idCobertura = json['idCobertura'];
    nomeCobertura = json['nomeCobertura'];
    prioridade = json['prioridade'];
    carencia = json['carencia'];
    carenciaBeneficiario = json['carenciaBeneficiario'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idCobertura'] = idCobertura;
    data['nomeCobertura'] = nomeCobertura;
    data['prioridade'] = prioridade;
    data['carencia'] = carencia;
    data['carenciaBeneficiario'] = carenciaBeneficiario;
    return data;
  }
}
