// 🌎 Project imports:
import 'package:modulohu_web/src/models/anexo.dart';

class AnexoDTO {
  List<Anexo>? anexos;
  String? erro;
  String? path;
  bool? sucesso;
  String? mensagem;

  AnexoDTO({this.anexos, this.erro, this.path, this.sucesso, this.mensagem});

  AnexoDTO.fromJson(Map<String, dynamic> json) {
    if (json['anexos'] != null) {
      anexos = <Anexo>[];
      json['anexos'].forEach((v) => anexos!.add(Anexo.fromJson(v)));
    }
    erro = json['erro'];
    path = json['path'];
    sucesso = json['sucesso'];
    mensagem = json['mensagem'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (anexos != null) data['anexos'] = anexos!.map((v) => v.toJson()).toList();
    data['erro'] = erro;
    data['path'] = path;
    data['sucesso'] = sucesso;
    data['mensagem'] = mensagem;
    return data;
  }
}
