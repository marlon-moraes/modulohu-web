class Empresa {
  String? idUniLocal;
  String? nome;
  String? cnpj;
  String? email;
  String? logradouro;
  String? numero;
  String? bairro;
  String? cidade;
  String? uf;
  String? cep;
  String? complemento;
  String? fones;
  String? id;
  int? codigo;
  String? dtInc;
  String? dtAlt;

  Empresa({
    this.idUniLocal,
    this.nome,
    this.cnpj,
    this.email,
    this.logradouro,
    this.numero,
    this.bairro,
    this.cidade,
    this.uf,
    this.cep,
    this.complemento,
    this.fones,
    this.id,
    this.codigo,
    this.dtInc,
    this.dtAlt,
  });

  Empresa.fromJson(Map<String, dynamic> json) {
    idUniLocal = json['idUniLocal'];
    nome = json['nome'];
    cnpj = json['cnpj'];
    email = json['email'];
    logradouro = json['logradouro'];
    numero = json['numero'];
    bairro = json['bairro'];
    cidade = json['cidade'];
    uf = json['uf'];
    cep = json['cep'];
    complemento = json['complemento'];
    fones = json['fones'];
    id = json['id'];
    codigo = json['codigo'];
    dtInc = json['dtInc'];
    dtAlt = json['dtAlt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idUniLocal'] = idUniLocal;
    data['nome'] = nome;
    data['cnpj'] = cnpj;
    data['email'] = email;
    data['logradouro'] = logradouro;
    data['numero'] = numero;
    data['bairro'] = bairro;
    data['cidade'] = cidade;
    data['uf'] = uf;
    data['cep'] = cep;
    data['complemento'] = complemento;
    data['fones'] = fones;
    data['id'] = id;
    data['codigo'] = codigo;
    data['dtInc'] = dtInc;
    data['dtAlt'] = dtAlt;
    return data;
  }
}
