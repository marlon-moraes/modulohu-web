// 🌎 Project imports:
import 'package:modulohu_web/src/models/modelo.dart';
import 'package:modulohu_web/src/models/pessoa.dart';

class ContratoBeneficiario {
  int? codigo;
  Modelo? modelo;
  Pessoa? contratante;
  String? telosRgUs;
  String? telosRgDt;
  String? telosUpUs;
  String? telosUpDt;
  int? autoId;

  ContratoBeneficiario({this.codigo, this.modelo, this.contratante, this.telosRgUs, this.telosRgDt, this.telosUpUs, this.telosUpDt, this.autoId});

  ContratoBeneficiario.fromJson(Map<String, dynamic> json) {
    codigo = json['codigo'];
    modelo = json['modelo'] != null ? Modelo.fromJson(json['modelo']) : null;
    contratante = json['contratante'] != null ? Pessoa.fromJson(json['contratante']) : null;
    telosRgUs = json['telosRgUs'];
    telosRgDt = json['telosRgDt'];
    telosUpUs = json['telosUpUs'];
    telosUpDt = json['telosUpDt'];
    autoId = json['autoid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['codigo'] = codigo;
    if (modelo != null) data['modelo'] = modelo!.toJson();
    if (contratante != null) data['contratante'] = contratante!.toJson();
    data['telosRgUs'] = telosRgUs;
    data['telosRgDt'] = telosRgDt;
    data['telosUpUs'] = telosUpUs;
    data['telosUpDt'] = telosUpDt;
    data['autoid'] = autoId;
    return data;
  }
}
