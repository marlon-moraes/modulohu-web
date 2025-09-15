class Modulo {
  String? idEmp;
  String? idUsuario;
  String? modulo;
  String? telaPrincipal;
  String? idUsuInc;
  String? idUsuAlt;
  String? id;
  String? dtInc;
  String? dtAlt;

  Modulo({this.idEmp, this.idUsuario, this.modulo, this.telaPrincipal, this.idUsuInc, this.idUsuAlt, this.id, this.dtInc, this.dtAlt});

  Modulo.fromJson(Map<String, dynamic> json) {
    idEmp = json['idEmp'];
    idUsuario = json['idUsuario'];
    modulo = json['modulo'];
    telaPrincipal = json['telaPrincipal'];
    idUsuInc = json['idUsuInc'];
    idUsuAlt = json['idUsuAlt'];
    id = json['id'];
    dtInc = json['dtInc'];
    dtAlt = json['dtAlt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idEmp'] = idEmp;
    data['idUsuario'] = idUsuario;
    data['modulo'] = modulo;
    data['telaPrincipal'] = telaPrincipal;
    data['idUsuInc'] = idUsuInc;
    data['idUsuAlt'] = idUsuAlt;
    data['id'] = id;
    data['dtInc'] = dtInc;
    data['dtAlt'] = dtAlt;
    return data;
  }
}
