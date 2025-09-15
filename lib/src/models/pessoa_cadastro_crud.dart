class PessoaCadastroCRUD {
  String? idEmp;
  String? nome;
  String? cpf;
  String? dddCelular;
  String? celular;
  String? email;
  bool? prestador;
  UsuAlt? usuAlt;

  PessoaCadastroCRUD({this.idEmp, this.nome, this.cpf, this.dddCelular, this.celular, this.email, this.prestador, this.usuAlt});

  PessoaCadastroCRUD.fromJson(Map<String, dynamic> json) {
    idEmp = json['idEmp'];
    nome = json['nome'];
    cpf = json['cpf'];
    dddCelular = json['dddCelular'];
    celular = json['celular'];
    email = json['email'];
    prestador = json['prestador'];
    usuAlt = json['usuAlt'] != null ? UsuAlt.fromJson(json['usuAlt']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idEmp'] = idEmp;
    data['nome'] = nome;
    data['cpf'] = cpf;
    data['dddCelular'] = dddCelular;
    data['celular'] = celular;
    data['email'] = email;
    data['prestador'] = prestador;
    if (usuAlt != null) data['usuAlt'] = usuAlt!.toJson();
    return data;
  }
}

class UsuAlt {
  String? id;

  UsuAlt({this.id});

  UsuAlt.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    return data;
  }
}
