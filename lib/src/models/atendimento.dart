// 🌎 Project imports:
import 'package:modulohu_web/src/models/assunto.dart';
import 'package:modulohu_web/src/models/canal.dart';
import 'package:modulohu_web/src/models/carater.dart';
import 'package:modulohu_web/src/models/medico_responsavel.dart';
import 'package:modulohu_web/src/models/status.dart';
import 'package:modulohu_web/src/models/tipo.dart';

class Atendimento {
  String? idEmp;
  String? idUni;
  String? protocolo;
  int? beneficiarioCarteirinha;
  String? beneficiarioCpf;
  String? beneficiarioNome;
  String? beneficiarioContrato;
  String? telefone;
  String? email;
  int? prestadorAutoid;
  String? prestadorNome;
  String? dtSolicitacao;
  Tipo? tipo;
  Assunto? assunto;
  Canal? canal;
  CaraterAtendimento? carater;
  Status? status;
  MedicoResponsavel? responsavel;
  String? idUsuInc;
  String? idUsuAlt;
  String? id;
  int? codigo;
  String? dtInc;
  String? dtAlt;

  Atendimento({
    this.idEmp,
    this.idUni,
    this.protocolo,
    this.beneficiarioCarteirinha,
    this.beneficiarioCpf,
    this.beneficiarioNome,
    this.beneficiarioContrato,
    this.telefone,
    this.email,
    this.prestadorAutoid,
    this.prestadorNome,
    this.dtSolicitacao,
    this.tipo,
    this.assunto,
    this.canal,
    this.carater,
    this.status,
    this.responsavel,
    this.idUsuInc,
    this.idUsuAlt,
    this.id,
    this.codigo,
    this.dtInc,
    this.dtAlt,
  });

  Atendimento.fromJson(Map<String, dynamic> json) {
    idEmp = json['idEmp'];
    idUni = json['idUni'];
    protocolo = json['protocolo'];
    beneficiarioCarteirinha = json['beneficiarioCarteirinha'];
    beneficiarioCpf = json['beneficiarioCpf'];
    beneficiarioNome = json['beneficiarioNome'];
    beneficiarioContrato = json['beneficiarioContrato'];
    telefone = json['telefone'];
    email = json['email'];
    prestadorAutoid = json['prestadorAutoid'];
    prestadorNome = json['prestadorNome'];
    dtSolicitacao = json['dtSolicitacao'];
    tipo = json['tipo'] != null ? Tipo.fromJson(json['tipo']) : null;
    assunto = json['assunto'] != null ? Assunto.fromJson(json['assunto']) : null;
    canal = json['canal'] != null ? Canal.fromJson(json['canal']) : null;
    carater = json['carater'] != null ? CaraterAtendimento.fromJson(json['carater']) : null;
    status = json['status'] != null ? Status.fromJson(json['status']) : null;
    responsavel = json['responsavel'] != null ? MedicoResponsavel.fromJson(json['responsavel']) : null;
    idUsuInc = json['idUsuInc'];
    idUsuAlt = json['idUsuAlt'];
    id = json['id'];
    codigo = json['codigo'];
    dtInc = json['dtInc'];
    dtAlt = json['dtAlt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idEmp'] = idEmp;
    data['idUni'] = idUni;
    data['protocolo'] = protocolo;
    data['beneficiarioCarteirinha'] = beneficiarioCarteirinha;
    data['beneficiarioCpf'] = beneficiarioCpf;
    data['beneficiarioNome'] = beneficiarioNome;
    data['beneficiarioContrato'] = beneficiarioContrato;
    data['telefone'] = telefone;
    data['email'] = email;
    data['prestadorAutoid'] = prestadorAutoid;
    data['prestadorNome'] = prestadorNome;
    data['dtSolicitacao'] = dtSolicitacao;
    if (tipo != null) data['tipo'] = tipo!.toJson();
    if (assunto != null) data['assunto'] = assunto!.toJson();
    if (canal != null) data['canal'] = canal!.toJson();
    if (carater != null) data['carater'] = carater!.toJson();
    if (status != null) data['status'] = status!.toJson();
    if (responsavel != null) data['responsavel'] = responsavel!.toJson();
    data['idUsuInc'] = idUsuInc;
    data['idUsuAlt'] = idUsuAlt;
    data['id'] = id;
    data['codigo'] = codigo;
    data['dtInc'] = dtInc;
    data['dtAlt'] = dtAlt;
    return data;
  }
}
