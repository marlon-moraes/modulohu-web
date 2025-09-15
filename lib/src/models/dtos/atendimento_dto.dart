// 🌎 Project imports:
import 'package:modulohu_web/src/models/atendimento.dart';

class AtendimentoDTO {
  List<Atendimento>? atendimentos;
  String? erro;
  String? path;
  bool? sucesso;
  String? mensagem;

  AtendimentoDTO({this.atendimentos, this.erro, this.path, this.sucesso, this.mensagem});

  AtendimentoDTO.fromJson(Map<String, dynamic> json) {
    if (json['atendimentos'] != null) {
      atendimentos = <Atendimento>[];
      json['atendimentos'].forEach((v) => atendimentos!.add(Atendimento.fromJson(v)));
    }
    erro = json['erro'];
    path = json['path'];
    sucesso = json['sucesso'];
    mensagem = json['mensagem'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (atendimentos != null) data['atendimentos'] = atendimentos!.map((v) => v.toJson()).toList();
    data['erro'] = erro;
    data['path'] = path;
    data['sucesso'] = sucesso;
    data['mensagem'] = mensagem;
    return data;
  }
}
