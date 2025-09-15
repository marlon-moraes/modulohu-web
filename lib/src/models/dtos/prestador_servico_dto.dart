// 🌎 Project imports:
import 'package:modulohu_web/src/models/medico_solicitante.dart';

class PrestadorServicoDTO {
  List<MedicoSolicitante>? prestadorServicos;
  String? erro;
  String? path;
  bool? sucesso;
  String? mensagem;

  PrestadorServicoDTO({this.prestadorServicos, this.erro, this.path, this.sucesso, this.mensagem});

  PrestadorServicoDTO.fromJson(Map<String, dynamic> json) {
    if (json['prestadorServicos'] != null) {
      prestadorServicos = <MedicoSolicitante>[];
      json['prestadorServicos'].forEach((v) => prestadorServicos!.add(MedicoSolicitante.fromJson(v)));
    }
    erro = json['erro'];
    path = json['path'];
    sucesso = json['sucesso'];
    mensagem = json['mensagem'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (prestadorServicos != null) data['prestadorServicos'] = prestadorServicos!.map((v) => v.toJson()).toList();
    data['erro'] = erro;
    data['path'] = path;
    data['sucesso'] = sucesso;
    data['mensagem'] = mensagem;
    return data;
  }
}
