// 🌎 Project imports:
import 'package:modulohu_web/src/models/especializacao.dart';

class AgendaMedica {
  String? idEmp;
  String? idUni;
  int? especialidadeAutoId;
  String? especialidadeNome;
  String? idAtendimentoCRA;
  String? idEspecializacao;
  Especializacao? especializacao;
  String? observacao;
  String? retornoAtendimento;
  String? idUsuInc;
  String? idUsuAlt;
  String? id;
  int? codigo;
  String? dtInc;
  String? dtAlt;

  AgendaMedica({
    this.idEmp,
    this.idUni,
    this.especialidadeAutoId,
    this.especialidadeNome,
    this.idAtendimentoCRA,
    this.idEspecializacao,
    this.especializacao,
    this.observacao,
    this.retornoAtendimento,
    this.idUsuInc,
    this.idUsuAlt,
    this.id,
    this.codigo,
    this.dtInc,
    this.dtAlt,
  });

  AgendaMedica.fromJson(Map<String, dynamic> json) {
    idEmp = json['idEmp'];
    idUni = json['idUni'];
    especialidadeAutoId = json['especialidadeAutoId'];
    especialidadeNome = json['especialidadeNome'];
    idAtendimentoCRA = json['idAtendimentoCRA'];
    idEspecializacao = json['idEspecializacao'];
    especializacao = json['especializacao'] != null ? Especializacao.fromJson(json['especializacao']) : null;
    observacao = json['observacao'];
    retornoAtendimento = json['retornoAtendimento'];
    idUsuInc = json['idUsuInc'];
    idUsuAlt = json['idUsuAlt'];
    id = json['id'];
    codigo = json['codigo'];
    dtInc = json['dtInc'];
    dtAlt = json['dtAlt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idEmp'] = idEmp;
    data['idUni'] = idUni;
    data['especialidadeAutoId'] = especialidadeAutoId;
    data['especialidadeNome'] = especialidadeNome;
    data['idAtendimentoCRA'] = idAtendimentoCRA;
    data['idEspecializacao'] = idEspecializacao;
    if (especializacao != null) data['especializacao'] = especializacao!.toJson();
    data['observacao'] = observacao;
    data['retornoAtendimento'] = retornoAtendimento;
    data['idUsuInc'] = idUsuInc;
    data['idUsuAlt'] = idUsuAlt;
    data['id'] = id;
    data['codigo'] = codigo;
    data['dtInc'] = dtInc;
    data['dtAlt'] = dtAlt;
    return data;
  }
}
