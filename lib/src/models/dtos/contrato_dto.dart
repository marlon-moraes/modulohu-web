// 🌎 Project imports:
import 'package:modulohu_web/src/models/contrato.dart';

class ContratoDTO {
  Contrato? contratoVO;
  String? erro;
  String? path;
  bool? sucesso;
  String? mensagem;

  ContratoDTO({this.contratoVO, this.erro, this.path, this.sucesso, this.mensagem});

  ContratoDTO.fromJson(Map<String, dynamic> json) {
    contratoVO = json['contratoVO'] != null ? Contrato.fromJson(json['contratoVO']) : null;
    erro = json['erro'];
    path = json['path'];
    sucesso = json['sucesso'];
    mensagem = json['mensagem'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (contratoVO != null) data['contratoVO'] = contratoVO!.toJson();
    data['erro'] = erro;
    data['path'] = path;
    data['sucesso'] = sucesso;
    data['mensagem'] = mensagem;
    return data;
  }
}
