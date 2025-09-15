// 🌎 Project imports:
import 'package:modulohu_web/src/models/responsavel.dart';

class ResponsavelDTO {
  List<Responsavel>? usuarios;
  String? erro;
  String? path;
  bool? sucesso;
  String? mensagem;

  ResponsavelDTO({this.usuarios, this.erro, this.path, this.sucesso, this.mensagem});

  ResponsavelDTO.fromJson(Map<String, dynamic> json) {
    if (json['usuarios'] != null) {
      usuarios = <Responsavel>[];
      json['usuarios'].forEach((v) => usuarios!.add(Responsavel.fromJson(v)));
    }
    erro = json['erro'];
    path = json['path'];
    sucesso = json['sucesso'];
    mensagem = json['mensagem'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (usuarios != null) data['usuarios'] = usuarios!.map((v) => v.toJson()).toList();
    data['erro'] = erro;
    data['path'] = path;
    data['sucesso'] = sucesso;
    data['mensagem'] = mensagem;
    return data;
  }
}
