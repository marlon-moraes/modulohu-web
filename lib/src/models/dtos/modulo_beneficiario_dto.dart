// 🌎 Project imports:
import 'package:modulohu_web/src/models/modulo_beneficiario.dart';

class ModuloBeneficiarioDTO {
  List<ModuloBeneficiario>? modulosBeneficiario;
  String? erro;
  String? path;
  bool? sucesso;
  String? mensagem;

  ModuloBeneficiarioDTO({this.modulosBeneficiario, this.erro, this.path, this.sucesso, this.mensagem});

  ModuloBeneficiarioDTO.fromJson(Map<String, dynamic> json) {
    if (json['modulosBeneficiario'] != null) {
      modulosBeneficiario = <ModuloBeneficiario>[];
      json['modulosBeneficiario'].forEach((v) => modulosBeneficiario!.add(ModuloBeneficiario.fromJson(v)));
    }
    erro = json['erro'];
    path = json['path'];
    sucesso = json['sucesso'];
    mensagem = json['mensagem'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (modulosBeneficiario != null) data['modulosBeneficiario'] = modulosBeneficiario!.map((v) => v.toJson()).toList();
    data['erro'] = erro;
    data['path'] = path;
    data['sucesso'] = sucesso;
    data['mensagem'] = mensagem;
    return data;
  }
}
