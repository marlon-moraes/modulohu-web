// 🌎 Project imports:
import 'package:modulohu_web/src/models/tipo_atendimento.dart';

class TipoAtendimentoDTO {
  List<TipoAtendimento>? tipos;
  String? erro;
  String? path;
  bool? sucesso;
  String? mensagem;

  TipoAtendimentoDTO({this.tipos, this.erro, this.path, this.sucesso, this.mensagem});

  TipoAtendimentoDTO.fromJson(Map<String, dynamic> json) {
    if (json['tipos'] != null) {
      tipos = <TipoAtendimento>[];
      json['tipos'].forEach((v) => tipos!.add(TipoAtendimento.fromJson(v)));
    }
    erro = json['erro'];
    path = json['path'];
    sucesso = json['sucesso'];
    mensagem = json['mensagem'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (tipos != null) data['tipos'] = tipos!.map((v) => v.toJson()).toList();
    data['erro'] = erro;
    data['path'] = path;
    data['sucesso'] = sucesso;
    data['mensagem'] = mensagem;
    return data;
  }
}
