// 🌎 Project imports:
import 'package:modulohu_web/src/models/especializacao.dart';

class EspecializacaoDTO {
  List<Especializacao>? especializacaos;
  String? erro;
  String? path;
  bool? sucesso;
  String? mensagem;

  EspecializacaoDTO({this.especializacaos, this.erro, this.path, this.sucesso, this.mensagem});

  EspecializacaoDTO.fromJson(Map<String, dynamic> json) {
    if (json['especializacaos'] != null) {
      especializacaos = <Especializacao>[];
      json['especializacaos'].forEach((v) => especializacaos!.add(Especializacao.fromJson(v)));
    }
    erro = json['erro'];
    path = json['path'];
    sucesso = json['sucesso'];
    mensagem = json['mensagem'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (especializacaos != null) data['especializacaos'] = especializacaos!.map((v) => v.toJson()).toList();
    data['erro'] = erro;
    data['path'] = path;
    data['sucesso'] = sucesso;
    data['mensagem'] = mensagem;
    return data;
  }
}
