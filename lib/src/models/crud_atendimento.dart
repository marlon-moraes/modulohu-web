class CRUDAtendimento {
  String? idEmp;
  String? idUni;
  int? beneficiarioCarteirinha;
  String? beneficiarioCpf;
  String? beneficiarioNome;
  String? beneficiarioContrato;
  String? telefone;
  String? email;
  int? prestadorAutoid;
  String? prestadorNome;
  String? dtSolicitacao;
  String? idTipo;
  String? idAssunto;
  String? idCanal;
  String? idCarater;
  String? idStatus;
  String? idResponsavel;
  String? idUsuInc;
  String? idUsuAlt;
  String? id;

  CRUDAtendimento({
    this.idEmp,
    this.idUni,
    this.beneficiarioCarteirinha,
    this.beneficiarioCpf,
    this.beneficiarioNome,
    this.beneficiarioContrato,
    this.telefone,
    this.email,
    this.prestadorAutoid,
    this.prestadorNome,
    this.dtSolicitacao,
    this.idTipo,
    this.idAssunto,
    this.idCanal,
    this.idCarater,
    this.idStatus,
    this.idResponsavel,
    this.idUsuInc,
    this.idUsuAlt,
    this.id,
  });

  CRUDAtendimento.fromJson(Map<String, dynamic> json) {
    idEmp = json['idEmp'];
    idUni = json['idUni'];
    beneficiarioCarteirinha = json['beneficiarioCarteirinha'];
    beneficiarioCpf = json['beneficiarioCpf'];
    beneficiarioNome = json['beneficiarioNome'];
    beneficiarioContrato = json['beneficiarioContrato'];
    telefone = json['telefone'];
    email = json['email'];
    prestadorAutoid = json['prestadorAutoid'];
    prestadorNome = json['prestadorNome'];
    dtSolicitacao = json['dtSolicitacao'];
    idTipo = json['idTipo'];
    idAssunto = json['idAssunto'];
    idCanal = json['idCanal'];
    idCarater = json['idCarater'];
    idStatus = json['idStatus'];
    idResponsavel = json['idResponsavel'];
    idUsuInc = json['idUsuInc'];
    idUsuAlt = json['idUsuAlt'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idEmp'] = idEmp;
    data['idUni'] = idUni;
    data['beneficiarioCarteirinha'] = beneficiarioCarteirinha;
    data['beneficiarioCpf'] = beneficiarioCpf;
    data['beneficiarioNome'] = beneficiarioNome;
    data['beneficiarioContrato'] = beneficiarioContrato;
    data['telefone'] = telefone;
    data['email'] = email;
    data['prestadorAutoid'] = prestadorAutoid;
    data['prestadorNome'] = prestadorNome;
    data['dtSolicitacao'] = dtSolicitacao;
    data['idTipo'] = idTipo;
    data['idAssunto'] = idAssunto;
    data['idCanal'] = idCanal;
    data['idCarater'] = idCarater;
    data['idStatus'] = idStatus;
    data['idResponsavel'] = idResponsavel;
    data['idUsuInc'] = idUsuInc;
    data['idUsuAlt'] = idUsuAlt;
    data['id'] = id;
    return data;
  }
}
