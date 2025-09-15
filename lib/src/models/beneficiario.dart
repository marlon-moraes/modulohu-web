// 🌎 Project imports:
import 'package:modulohu_web/src/models/contrato_beneficiario.dart';
import 'package:modulohu_web/src/models/pessoa.dart';

class Beneficiario {
  Pessoa? pessoa;
  ContratoBeneficiario? contrato;
  int? codigo;
  String? telosRgUs;
  String? telosRgDt;
  String? telosUpUs;
  String? telosUpDt;
  int? autoId;
  bool? ativo;

  Beneficiario({this.pessoa, this.contrato, this.codigo, this.telosRgUs, this.telosRgDt, this.telosUpUs, this.telosUpDt, this.autoId, this.ativo});

  Beneficiario.fromJson(Map<String, dynamic> json) {
    pessoa = json['pessoa'] != null ? Pessoa.fromJson(json['pessoa']) : null;
    contrato = json['contrato'] != null ? ContratoBeneficiario.fromJson(json['contrato']) : null;
    codigo = json['codigo'];
    telosRgUs = json['telosRgUs'];
    telosRgDt = json['telosRgDt'];
    telosUpUs = json['telosUpUs'];
    telosUpDt = json['telosUpDt'];
    autoId = json['autoId'];
    ativo = json['ativo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (pessoa != null) data['pessoa'] = pessoa!.toJson();
    if (contrato != null) data['contrato'] = contrato!.toJson();
    data['contrato'] = contrato;
    data['codigo'] = codigo;
    data['telosRgUs'] = telosRgUs;
    data['telosRgDt'] = telosRgDt;
    data['telosUpUs'] = telosUpUs;
    data['telosUpDt'] = telosUpDt;
    data['autoId'] = autoId;
    data['ativo'] = ativo;
    return data;
  }
}
