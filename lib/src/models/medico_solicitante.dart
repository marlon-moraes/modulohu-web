// 🌎 Project imports:
import 'package:modulohu_web/src/models/pessoa.dart';

class MedicoSolicitante {
  Pessoa? pessoa;
  String? classe;
  String? telosRgUs;
  String? telosRgDt;
  String? telosUpUs;
  String? telosUpDt;
  String? autoId;

  MedicoSolicitante({this.pessoa, this.classe, this.telosRgUs, this.telosRgDt, this.telosUpUs, this.telosUpDt, this.autoId});

  MedicoSolicitante.fromJson(Map<String, dynamic> json) {
    pessoa = json['pessoa'] != null ? Pessoa.fromJson(json['pessoa']) : null;
    classe = json['classe'];
    telosRgUs = json['telosRgUs'];
    telosRgDt = json['telosRgDt'];
    telosUpUs = json['telosUpUs'];
    telosUpDt = json['telosUpDt'];
    autoId = json['autoId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (pessoa != null) data['pessoa'] = pessoa!.toJson();
    data['classe'] = classe;
    data['telosRgUs'] = telosRgUs;
    data['telosRgDt'] = telosRgDt;
    data['telosUpUs'] = telosUpUs;
    data['telosUpDt'] = telosUpDt;
    data['autoId'] = autoId;
    return data;
  }
}
