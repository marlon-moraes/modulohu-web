class ResponsavelTransferencia {
  String? id;
  int? codigo;
  String? dtInc;
  String? dtAlt;

  ResponsavelTransferencia({this.id, this.codigo, this.dtInc, this.dtAlt});

  ResponsavelTransferencia.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    codigo = json['codigo'];
    dtInc = json['dtInc'];
    dtAlt = json['dtAlt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['codigo'] = codigo;
    data['dtInc'] = dtInc;
    data['dtAlt'] = dtAlt;
    return data;
  }
}
