class ModuloBeneficiario {
  String? modulo;
  String? nome;
  String? dtInicioVigencia;
  String? dtFimVigencia;
  String? tipo;

  ModuloBeneficiario({this.modulo, this.nome, this.dtInicioVigencia, this.dtFimVigencia, this.tipo});

  ModuloBeneficiario.fromJson(Map<String, dynamic> json) {
    modulo = json['modulo'];
    nome = json['nome'];
    dtInicioVigencia = json['dtInicioVigencia'];
    dtFimVigencia = json['dtFimVigencia'];
    tipo = json['tipo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['modulo'] = modulo;
    data['nome'] = nome;
    data['dtInicioVigencia'] = dtInicioVigencia;
    data['dtFimVigencia'] = dtFimVigencia;
    data['tipo'] = tipo;
    return data;
  }
}
