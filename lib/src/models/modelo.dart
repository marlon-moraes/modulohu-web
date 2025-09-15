// 🌎 Project imports:
import 'package:modulohu_web/src/models/tipo_contratacao.dart';

class Modelo {
  String? codigo;
  String? nome;
  TipoContratacao? tipoContratacao;
  String? telosRgUs;
  String? telosRgDt;
  String? telosUpUs;
  String? telosUpDt;
  int? autoid;

  Modelo({this.codigo, this.nome, this.tipoContratacao, this.telosRgUs, this.telosRgDt, this.telosUpUs, this.telosUpDt, this.autoid});

  Modelo.fromJson(Map<String, dynamic> json) {
    codigo = json['codigo'];
    nome = json['nome'];
    tipoContratacao = json['tipoContratacao'] != null ? TipoContratacao.fromJson(json['tipoContratacao']) : null;
    telosRgUs = json['telosRgUs'];
    telosRgDt = json['telosRgDt'];
    telosUpUs = json['telosUpUs'];
    telosUpDt = json['telosUpDt'];
    autoid = json['autoid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['codigo'] = codigo;
    data['nome'] = nome;
    if (tipoContratacao != null) data['tipoContratacao'] = tipoContratacao!.toJson();
    data['telosRgUs'] = telosRgUs;
    data['telosRgDt'] = telosRgDt;
    data['telosUpUs'] = telosUpUs;
    data['telosUpDt'] = telosUpDt;
    data['autoid'] = autoid;
    return data;
  }
}
