// 🌎 Project imports:
import 'package:modulohu_web/src/models/pessoa_cadastro.dart';

class PessoaCadastroDTO {
  PessoaCadastro? pessoa;
  String? erro;
  String? path;
  bool? sucesso;
  String? mensagem;

  PessoaCadastroDTO({this.pessoa, this.erro, this.path, this.sucesso, this.mensagem});

  PessoaCadastroDTO.fromJson(Map<String, dynamic> json) {
    pessoa = json['pessoa'] != null ? PessoaCadastro.fromJson(json['pessoa']) : null;
    erro = json['erro'];
    path = json['path'];
    sucesso = json['sucesso'];
    mensagem = json['mensagem'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (pessoa != null) data['pessoa'] = pessoa!.toJson();
    data['erro'] = erro;
    data['path'] = path;
    data['sucesso'] = sucesso;
    data['mensagem'] = mensagem;
    return data;
  }
}
