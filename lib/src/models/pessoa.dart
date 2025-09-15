class Pessoa {
  String? nome;
  String? cnp;
  String? dtNascimento;
  String? nomePai;
  String? nomeMae;
  String? sexo;
  String? estadoCivil;
  String? telosRgUs;
  String? telosRgDt;
  String? telosUpUs;
  String? telosUpDt;
  int? autoId;

  Pessoa({
    this.nome,
    this.cnp,
    this.dtNascimento,
    this.nomePai,
    this.nomeMae,
    this.sexo,
    this.estadoCivil,
    this.telosRgUs,
    this.telosRgDt,
    this.telosUpUs,
    this.telosUpDt,
    this.autoId,
  });

  Pessoa.fromJson(Map<String, dynamic> json) {
    nome = json['nome'];
    cnp = json['cnp'];
    dtNascimento = json['dtNascimento'];
    nomePai = json['nomePai'];
    nomeMae = json['nomeMae'];
    sexo = json['sexo'];
    estadoCivil = json['estadoCivil'];
    telosRgUs = json['telosRgUs'];
    telosRgDt = json['telosRgDt'];
    telosUpUs = json['telosUpUs'];
    telosUpDt = json['telosUpDt'];
    autoId = json['autoId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nome'] = nome;
    data['cnp'] = cnp;
    data['dtNascimento'] = dtNascimento;
    data['nomePai'] = nomePai;
    data['nomeMae'] = nomeMae;
    data['sexo'] = sexo;
    data['estadoCivil'] = estadoCivil;
    data['telosRgUs'] = telosRgUs;
    data['telosRgDt'] = telosRgDt;
    data['telosUpUs'] = telosUpUs;
    data['telosUpDt'] = telosUpDt;
    data['autoId'] = autoId;
    return data;
  }
}
