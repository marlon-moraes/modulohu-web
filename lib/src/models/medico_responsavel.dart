class MedicoResponsavel {
  String? idEmp;
  String? nome;
  String? id;
  int? codigo;
  String? dtInc;
  String? dtAlt;

  MedicoResponsavel({this.idEmp, this.nome, this.id, this.codigo, this.dtInc, this.dtAlt});

  MedicoResponsavel.fromJson(Map<String, dynamic> json) {
    idEmp = json['idEmp'];
    nome = json['nome'];
    id = json['id'];
    codigo = json['codigo'];
    dtInc = json['dtInc'];
    dtAlt = json['dtAlt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idEmp'] = idEmp;
    data['nome'] = nome;
    data['id'] = id;
    data['codigo'] = codigo;
    data['dtInc'] = dtInc;
    data['dtAlt'] = dtAlt;
    return data;
  }
}
