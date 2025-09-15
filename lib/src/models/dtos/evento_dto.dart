// 🌎 Project imports:
import 'package:modulohu_web/src/models/evento.dart';

class EventoDTO {
  List<Evento>? eventos;
  String? erro;
  String? path;
  bool? sucesso;
  String? mensagem;

  EventoDTO({this.eventos, this.erro, this.path, this.sucesso, this.mensagem});

  EventoDTO.fromJson(Map<String, dynamic> json) {
    if (json['eventos'] != null) {
      eventos = <Evento>[];
      json['eventos'].forEach((v) => eventos!.add(Evento.fromJson(v)));
    }
    erro = json['erro'];
    path = json['path'];
    sucesso = json['sucesso'];
    mensagem = json['mensagem'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (eventos != null) data['eventos'] = eventos!.map((v) => v.toJson()).toList();
    data['erro'] = erro;
    data['path'] = path;
    data['sucesso'] = sucesso;
    data['mensagem'] = mensagem;
    return data;
  }
}
