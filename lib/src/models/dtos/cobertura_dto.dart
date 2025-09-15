// 🌎 Project imports:
import 'package:modulohu_web/src/models/cobertura.dart';

class CoberturaDTO {
  List<Cobertura>? coberturas;
  String? erro;
  String? path;
  bool? sucesso;
  String? mensagem;

  CoberturaDTO({this.coberturas, this.erro, this.path, this.sucesso, this.mensagem});

  CoberturaDTO.fromJson(Map<String, dynamic> json) {
    if (json['coberturas'] != null) {
      coberturas = <Cobertura>[];
      json['coberturas'].forEach((v) => coberturas!.add(Cobertura.fromJson(v)));
    }
    erro = json['erro'];
    path = json['path'];
    sucesso = json['sucesso'];
    mensagem = json['mensagem'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (coberturas != null) data['coberturas'] = coberturas!.map((v) => v.toJson()).toList();
    data['erro'] = erro;
    data['path'] = path;
    data['sucesso'] = sucesso;
    data['mensagem'] = mensagem;
    return data;
  }
}
