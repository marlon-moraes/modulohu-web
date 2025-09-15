// 🌎 Project imports:
import 'package:modulohu_web/src/models/agenda_medica.dart';

class AgendaMedicaDTO {
  List<AgendaMedica>? agendaMedicas;
  String? erro;
  String? path;
  bool? sucesso;
  String? mensagem;

  AgendaMedicaDTO({this.agendaMedicas, this.erro, this.path, this.sucesso, this.mensagem});

  AgendaMedicaDTO.fromJson(Map<String, dynamic> json) {
    if (json['agendaMedicas'] != null) {
      agendaMedicas = <AgendaMedica>[];
      json['agendaMedicas'].forEach((v) => agendaMedicas!.add(AgendaMedica.fromJson(v)));
    }
    erro = json['erro'];
    path = json['path'];
    sucesso = json['sucesso'];
    mensagem = json['mensagem'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (agendaMedicas != null) data['agendaMedicas'] = agendaMedicas!.map((v) => v.toJson()).toList();
    data['erro'] = erro;
    data['path'] = path;
    data['sucesso'] = sucesso;
    data['mensagem'] = mensagem;
    return data;
  }
}
