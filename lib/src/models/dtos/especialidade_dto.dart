// 🌎 Project imports:
import 'package:modulohu_web/src/models/especialidade.dart';

class EspecialidadeDTO {
  List<Especialidade>? especialidades;
  String? erro;
  String? path;
  bool? sucesso;
  String? mensagem;

  EspecialidadeDTO({this.especialidades, this.erro, this.path, this.sucesso, this.mensagem});

  EspecialidadeDTO.fromJson(Map<String, dynamic> json) {
    if (json['especialidades'] != null) {
      especialidades = <Especialidade>[];
      json['especialidades'].forEach((v) => especialidades!.add(Especialidade.fromJson(v)));
    }
    erro = json['erro'];
    path = json['path'];
    sucesso = json['sucesso'];
    mensagem = json['mensagem'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (especialidades != null) data['especialidades'] = especialidades!.map((v) => v.toJson()).toList();
    data['erro'] = erro;
    data['path'] = path;
    data['sucesso'] = sucesso;
    data['mensagem'] = mensagem;
    return data;
  }
}
