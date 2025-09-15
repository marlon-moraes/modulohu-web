class Unidade {
  String? idUni;
  String? idUsuario;
  String? id;
  String? dtInc;
  String? dtAlt;

  Unidade({this.idUni, this.idUsuario, this.id, this.dtInc, this.dtAlt});

  Unidade.fromJson(Map<String, dynamic> json) {
    idUni = json['idUni'];
    idUsuario = json['idUsuario'];
    id = json['id'];
    dtInc = json['dtInc'];
    dtAlt = json['dtAlt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idUni'] = idUni;
    data['idUsuario'] = idUsuario;
    data['id'] = id;
    data['dtInc'] = dtInc;
    data['dtAlt'] = dtAlt;
    return data;
  }
}
