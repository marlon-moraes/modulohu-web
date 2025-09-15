class Perfil {
  String? idEmp;
  String? nome;
  bool? ativo;
  String? id;
  int? codigo;
  String? dtInc;
  String? dtAlt;

  Perfil({this.idEmp, this.nome, this.ativo, this.id, this.codigo, this.dtInc, this.dtAlt});

  Perfil.fromJson(Map<String, dynamic> json) {
    idEmp = json['idEmp'];
    nome = json['nome'];
    ativo = json['ativo'];
    id = json['id'];
    codigo = json['codigo'];
    dtInc = json['dtInc'];
    dtAlt = json['dtAlt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idEmp'] = idEmp;
    data['nome'] = nome;
    data['ativo'] = ativo;
    data['id'] = id;
    data['codigo'] = codigo;
    data['dtInc'] = dtInc;
    data['dtAlt'] = dtAlt;
    return data;
  }
}
