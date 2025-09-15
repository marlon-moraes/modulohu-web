// 🌎 Project imports:
import 'package:modulohu_web/src/models/modulo.dart';
import 'package:modulohu_web/src/models/unidade.dart';
import 'package:modulohu_web/src/models/usuario.dart';

class UserAction {
  User? usuario;
  List<Modulo>? modulos;
  List<Unidade>? unidades;

  UserAction({this.usuario, this.modulos, this.unidades});

  UserAction.fromJson(Map<String, dynamic> json) {
    usuario = json['usuario'] != null ? User.fromJson(json['usuario']) : null;
    if (json['modulos'] != null) {
      modulos = <Modulo>[];
      json['modulos'].forEach((v) => modulos!.add(Modulo.fromJson(v)));
    }
    if (json['unidades'] != null) {
      unidades = <Unidade>[];
      json['unidades'].forEach((v) => unidades!.add(Unidade.fromJson(v)));
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (usuario != null) data['usuario'] = usuario!.toJson();
    if (modulos != null) data['modulos'] = modulos!.map((v) => v.toJson()).toList();
    if (unidades != null) data['unidades'] = unidades!.map((v) => v.toJson()).toList();
    return data;
  }
}
