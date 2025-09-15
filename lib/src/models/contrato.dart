class Contrato {
  int? codigoContrato;
  String? nomeContratante;
  String? linhaModuloOperadora;
  String? codModuloOperadora;
  String? nomeModuloOperadora;
  String? cpfCnpjContratante;
  String? codPessoaCardioConta;
  String? modeloContrato;
  String? inicioVigencia;
  String? abrangencia;
  String? segmentacao;
  String? tipoContratacao;
  String? status;
  String? codClasse;
  String? nomeClasse;

  Contrato({
    this.codigoContrato,
    this.nomeContratante,
    this.linhaModuloOperadora,
    this.codModuloOperadora,
    this.nomeModuloOperadora,
    this.cpfCnpjContratante,
    this.codPessoaCardioConta,
    this.modeloContrato,
    this.inicioVigencia,
    this.abrangencia,
    this.segmentacao,
    this.tipoContratacao,
    this.status,
    this.codClasse,
    this.nomeClasse,
  });

  Contrato.fromJson(Map<String, dynamic> json) {
    codigoContrato = json['codigoContrato'];
    nomeContratante = json['nomeContratante'];
    linhaModuloOperadora = json['linhaModuloOperadora'];
    codModuloOperadora = json['codModuloOperadora'];
    nomeModuloOperadora = json['nomeModuloOperadora'];
    cpfCnpjContratante = json['cpfCnpjContratante'];
    codPessoaCardioConta = json['codPessoaCardioConta'];
    modeloContrato = json['modeloContrato'];
    inicioVigencia = json['inicioVigencia'];
    abrangencia = json['abrangencia'];
    segmentacao = json['segmentacao'];
    tipoContratacao = json['tipoContratacao'];
    status = json['status'];
    codClasse = json['codClasse'];
    nomeClasse = json['nomeClasse'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['codigoContrato'] = codigoContrato;
    data['nomeContratante'] = nomeContratante;
    data['linhaModuloOperadora'] = linhaModuloOperadora;
    data['codModuloOperadora'] = codModuloOperadora;
    data['nomeModuloOperadora'] = nomeModuloOperadora;
    data['cpfCnpjContratante'] = cpfCnpjContratante;
    data['codPessoaCardioConta'] = codPessoaCardioConta;
    data['modeloContrato'] = modeloContrato;
    data['inicioVigencia'] = inicioVigencia;
    data['abrangencia'] = abrangencia;
    data['segmentacao'] = segmentacao;
    data['tipoContratacao'] = tipoContratacao;
    data['status'] = status;
    data['codClasse'] = codClasse;
    data['nomeClasse'] = nomeClasse;
    return data;
  }
}
