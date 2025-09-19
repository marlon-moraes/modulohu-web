// 🌎 Project imports:
import 'package:modulohu_web/src/models/cadastros_transferencia_res.dart';
import 'package:modulohu_web/src/models/responsavel_transferencia.dart';

class Transferencia {
  String? idEmp;
  String? idUni;
  IdAtendimentoCRA? idAtendimentoCRA;
  String? nome;
  String? dtNascimento;
  String? sexo;
  String? telefone;
  int? prontuario;
  String? acomodacao;
  String? familiarResponsavel;
  String? familiarResponsavelContato;
  bool? leitoDisponivel;
  String? leito;
  String? medicosSolicitados;
  String? condicoesPaciente;
  String? idInstituicaoOrigem;
  String? idInstituicaoReferencia;
  String? idMedicoSolicitante;
  String? medicoSolicitanteContato;
  String? idMedicoRecebimento;
  ResponsavelTransferencia? responsavel;
  CadastrosTransferenciaRes? precaucao;
  CadastrosTransferenciaRes? convenio;
  CadastrosTransferenciaRes? coberturaContratual;
  CadastrosTransferenciaRes? motivoRejeitado;
  CadastrosTransferenciaRes? motivoTransferencia;
  CadastrosTransferenciaRes? tipoInterncao;
  CadastrosTransferenciaRes? solicitacaoAtendida;
  CadastrosTransferenciaRes? meioTransporteTransf;
  CadastrosTransferenciaRes? equipeTransporteTransf;
  String? dtChegada;
  String? dtSaida;
  IdAtendimentoCRA? idUsuAlt;

  Transferencia({
    this.idEmp,
    this.idUni,
    this.idAtendimentoCRA,
    this.nome,
    this.dtNascimento,
    this.sexo,
    this.telefone,
    this.prontuario,
    this.acomodacao,
    this.familiarResponsavel,
    this.familiarResponsavelContato,
    this.leitoDisponivel,
    this.leito,
    this.medicosSolicitados,
    this.condicoesPaciente,
    this.idInstituicaoOrigem,
    this.idInstituicaoReferencia,
    this.idMedicoSolicitante,
    this.medicoSolicitanteContato,
    this.idMedicoRecebimento,
    this.responsavel,
    this.precaucao,
    this.convenio,
    this.coberturaContratual,
    this.motivoRejeitado,
    this.motivoTransferencia,
    this.tipoInterncao,
    this.solicitacaoAtendida,
    this.meioTransporteTransf,
    this.equipeTransporteTransf,
    this.dtChegada,
    this.dtSaida,
    this.idUsuAlt,
  });

  Transferencia.fromJson(Map<String, dynamic> json) {
    idEmp = json['idEmp'];
    idUni = json['idUni'];
    idAtendimentoCRA = json['idAtendimentoCRA'] != null ? IdAtendimentoCRA.fromJson(json['idAtendimentoCRA']) : null;
    nome = json['nome'];
    dtNascimento = json['dtNascimento'];
    sexo = json['sexo'];
    telefone = json['telefone'];
    prontuario = json['prontuario'];
    acomodacao = json['acomodacao'];
    familiarResponsavel = json['familiarResponsavel'];
    familiarResponsavelContato = json['familiarResponsavelContato'];
    leitoDisponivel = json['leitoDisponivel'];
    leito = json['leito'];
    medicosSolicitados = json['medicosSolicitados'];
    condicoesPaciente = json['condicoesPaciente'];
    idInstituicaoOrigem = json['idInstituicaoOrigem'];
    idInstituicaoReferencia = json['idInstituicaoReferencia'];
    idMedicoSolicitante = json['idMedicoSolicitante'];
    medicoSolicitanteContato = json['medicoSolicitanteContato'];
    idMedicoRecebimento = json['idMedicoRecebimento'];
    responsavel = json['responsavel'] != null ? ResponsavelTransferencia.fromJson(json['responsavel']) : null;
    precaucao = json['precaucao'] != null ? CadastrosTransferenciaRes.fromJson(json['precaucao']) : null;
    convenio = json['convenio'] != null ? CadastrosTransferenciaRes.fromJson(json['convenio']) : null;
    coberturaContratual = json['coberturaContratual'] != null ? CadastrosTransferenciaRes.fromJson(json['coberturaContratual']) : null;
    motivoRejeitado = json['motivoRejeitado'] != null ? CadastrosTransferenciaRes.fromJson(json['motivoRejeitado']) : null;
    motivoTransferencia = json['motivoTransferencia'] != null ? CadastrosTransferenciaRes.fromJson(json['motivoTransferencia']) : null;
    tipoInterncao = json['tipoInterncao'] != null ? CadastrosTransferenciaRes.fromJson(json['tipoInterncao']) : null;
    solicitacaoAtendida = json['solicitacaoAtendida'] != null ? CadastrosTransferenciaRes.fromJson(json['solicitacaoAtendida']) : null;
    meioTransporteTransf = json['meioTransporteTransf'] != null ? CadastrosTransferenciaRes.fromJson(json['meioTransporteTransf']) : null;
    equipeTransporteTransf = json['equipeTransporteTransf'] != null ? CadastrosTransferenciaRes.fromJson(json['equipeTransporteTransf']) : null;
    dtChegada = json['dtChegada'];
    dtSaida = json['dtSaida'];
    idUsuAlt = json['idUsuAlt'] != null ? IdAtendimentoCRA.fromJson(json['idUsuAlt']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idEmp'] = idEmp;
    data['idUni'] = idUni;
    if (idAtendimentoCRA != null) data['idAtendimentoCRA'] = idAtendimentoCRA!.toJson();
    data['nome'] = nome;
    data['dtNascimento'] = dtNascimento;
    data['sexo'] = sexo;
    data['telefone'] = telefone;
    data['prontuario'] = prontuario;
    data['acomodacao'] = acomodacao;
    data['familiarResponsavel'] = familiarResponsavel;
    data['familiarResponsavelContato'] = familiarResponsavelContato;
    data['leitoDisponivel'] = leitoDisponivel;
    data['leito'] = leito;
    data['medicosSolicitados'] = medicosSolicitados;
    data['condicoesPaciente'] = condicoesPaciente;
    data['idInstituicaoOrigem'] = idInstituicaoOrigem;
    data['idInstituicaoReferencia'] = idInstituicaoReferencia;
    data['idMedicoSolicitante'] = idMedicoSolicitante;
    data['medicoSolicitanteContato'] = medicoSolicitanteContato;
    data['idMedicoRecebimento'] = idMedicoRecebimento;
    if (responsavel != null) data['responsavel'] = responsavel!.toJson();
    if (precaucao != null) data['precaucao'] = precaucao!.toJson();
    if (convenio != null) data['convenio'] = convenio!.toJson();
    if (coberturaContratual != null) data['coberturaContratual'] = coberturaContratual!.toJson();
    if (motivoRejeitado != null) data['motivoRejeitado'] = motivoRejeitado!.toJson();
    if (motivoTransferencia != null) data['motivoTransferencia'] = motivoTransferencia!.toJson();
    if (tipoInterncao != null) data['tipoInterncao'] = tipoInterncao!.toJson();
    if (solicitacaoAtendida != null) data['solicitacaoAtendida'] = solicitacaoAtendida!.toJson();
    if (meioTransporteTransf != null) data['meioTransporteTransf'] = meioTransporteTransf!.toJson();
    if (equipeTransporteTransf != null) data['equipeTransporteTransf'] = equipeTransporteTransf!.toJson();
    data['dtChegada'] = dtChegada;
    data['dtSaida'] = dtSaida;
    if (idUsuAlt != null) data['idUsuAlt'] = idUsuAlt!.toJson();
    return data;
  }
}

class IdAtendimentoCRA {
  String? id;

  IdAtendimentoCRA({this.id});

  IdAtendimentoCRA.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    return data;
  }
}
