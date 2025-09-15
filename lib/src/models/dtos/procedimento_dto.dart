// 🌎 Project imports:
import 'package:modulohu_web/src/models/procedimento.dart';

class ProcedimentoDTO {
  List<Procedimento>? procedimentos;
  String? erro;
  String? path;
  bool? sucesso;
  String? mensagem;

  ProcedimentoDTO({this.procedimentos, this.erro, this.path, this.sucesso, this.mensagem});

  ProcedimentoDTO.fromJson(Map<String, dynamic> json) {
    if (json['procedimentos'] != null) {
      procedimentos = <Procedimento>[];
      json['procedimentos'].forEach((v) => procedimentos!.add(Procedimento.fromJson(v)));
    }
    erro = json['erro'];
    path = json['path'];
    sucesso = json['sucesso'];
    mensagem = json['mensagem'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (procedimentos != null) data['procedimentos'] = procedimentos!.map((v) => v.toJson()).toList();
    data['erro'] = erro;
    data['path'] = path;
    data['sucesso'] = sucesso;
    data['mensagem'] = mensagem;
    return data;
  }
}
