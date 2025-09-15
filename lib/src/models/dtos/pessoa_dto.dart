// 🌎 Project imports:
import 'package:modulohu_web/src/models/pessoa.dart';

class PessoaDTO {
  List<Pessoa>? pessoas;
  String? erro;
  String? path;
  bool? sucesso;
  String? mensagem;

  PessoaDTO({this.pessoas, this.erro, this.path, this.sucesso, this.mensagem});

  PessoaDTO.fromJson(Map<String, dynamic> json) {
    if (json['pessoas'] != null) {
      pessoas = <Pessoa>[];
      json['pessoas'].forEach((v) => pessoas!.add(Pessoa.fromJson(v)));
    }
    erro = json['erro'];
    path = json['path'];
    sucesso = json['sucesso'];
    mensagem = json['mensagem'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (pessoas != null) data['pessoas'] = pessoas!.map((v) => v.toJson()).toList();
    data['erro'] = erro;
    data['path'] = path;
    data['sucesso'] = sucesso;
    data['mensagem'] = mensagem;
    return data;
  }
}
