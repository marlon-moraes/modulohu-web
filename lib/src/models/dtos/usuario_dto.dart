// 🌎 Project imports:
import 'package:modulohu_web/src/models/user_action.dart';

class UsuarioDTO {
  UserAction? usuarioActions;
  String? erro;
  String? path;
  bool? sucesso;
  String? mensagem;

  UsuarioDTO({this.usuarioActions, this.erro, this.path, this.sucesso, this.mensagem});

  UsuarioDTO.fromJson(Map<String, dynamic> json) {
    usuarioActions = json['usuarioActions'] != null ? UserAction.fromJson(json['usuarioActions']) : null;
    erro = json['erro'];
    path = json['path'];
    sucesso = json['sucesso'];
    mensagem = json['mensagem'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (usuarioActions != null) data['usuarioActions'] = usuarioActions!.toJson();
    data['erro'] = erro;
    data['path'] = path;
    data['sucesso'] = sucesso;
    data['mensagem'] = mensagem;
    return data;
  }
}
