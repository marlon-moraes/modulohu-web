// 🌎 Project imports:
import 'package:modulohu_web/src/models/beneficiario.dart';

class BeneficiarioDTO {
  List<Beneficiario>? beneficiarios;
  String? erro;
  String? path;
  bool? sucesso;
  String? mensagem;

  BeneficiarioDTO({this.beneficiarios, this.erro, this.path, this.sucesso, this.mensagem});

  BeneficiarioDTO.fromJson(Map<String, dynamic> json) {
    if (json['beneficiarios'] != null) {
      beneficiarios = <Beneficiario>[];
      json['beneficiarios'].forEach((v) => beneficiarios!.add(Beneficiario.fromJson(v)));
    }
    erro = json['erro'];
    path = json['path'];
    sucesso = json['sucesso'];
    mensagem = json['mensagem'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (beneficiarios != null) data['beneficiarios'] = beneficiarios!.map((v) => v.toJson()).toList();
    data['erro'] = erro;
    data['path'] = path;
    data['sucesso'] = sucesso;
    data['mensagem'] = mensagem;
    return data;
  }
}
