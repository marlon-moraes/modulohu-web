class AtendimentoSC {
  String? protocolo;
  String? nome;
  String? dtSolicitacaoIni;
  String? dtSolicitacaoFim;
  String? tipo;
  String? assunto;
  String? responsavel;
  String? status;
  String? prestador;

  AtendimentoSC({
    this.protocolo,
    this.nome,
    this.dtSolicitacaoIni,
    this.dtSolicitacaoFim,
    this.tipo,
    this.assunto,
    this.responsavel,
    this.status,
    this.prestador,
  });

  AtendimentoSC.fromJson(Map<String, dynamic> json) {
    protocolo = json['protocolo'];
    nome = json['nome'];
    dtSolicitacaoIni = json['dtSolicitacaoIni'];
    dtSolicitacaoFim = json['dtSolicitacaoFim'];
    tipo = json['tipo'];
    assunto = json['assunto'];
    responsavel = json['responsavel'];
    status = json['status'];
    prestador = json['prestador'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['protocolo'] = protocolo;
    data['nome'] = nome;
    data['dtSolicitacaoIni'] = dtSolicitacaoIni;
    data['dtSolicitacaoFim'] = dtSolicitacaoFim;
    data['tipo'] = tipo;
    data['assunto'] = assunto;
    data['responsavel'] = responsavel;
    data['status'] = status;
    data['prestador'] = prestador;
    return data;
  }
}
