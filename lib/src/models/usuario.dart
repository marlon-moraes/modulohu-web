// 🌎 Project imports:
import 'package:modulohu_web/src/models/empresa.dart';
import 'package:modulohu_web/src/models/perfil.dart';

class User {
  Empresa? empresa;
  String? adm;
  String? idPessoa;
  Perfil? perfil;
  String? nome;
  int? ativo;
  int? vendedor;
  int? comite;
  int? forcaNovaSenha;
  int? podeCancelarOportunidade;
  String? email;
  String? dtExclusao;
  String? id;
  int? codigo;
  String? dtInc;
  String? dtAlt;

  User({
    this.empresa,
    this.adm,
    this.idPessoa,
    this.perfil,
    this.nome,
    this.ativo,
    this.vendedor,
    this.comite,
    this.forcaNovaSenha,
    this.podeCancelarOportunidade,
    this.email,
    this.dtExclusao,
    this.id,
    this.codigo,
    this.dtInc,
    this.dtAlt,
  });

  User.fromJson(Map<String, dynamic> json) {
    empresa = json['empresa'] != null ? Empresa.fromJson(json['empresa']) : null;
    adm = json['adm'];
    idPessoa = json['idPessoa'];
    perfil = json['perfil'] != null ? Perfil.fromJson(json['perfil']) : null;
    nome = json['nome'];
    ativo = json['ativo'];
    vendedor = json['vendedor'];
    comite = json['comite'];
    forcaNovaSenha = json['forcaNovaSenha'];
    podeCancelarOportunidade = json['podeCancelarOportunidade'];
    email = json['email'];
    dtExclusao = json['dtExclusao'];
    id = json['id'];
    codigo = json['codigo'];
    dtInc = json['dtInc'];
    dtAlt = json['dtAlt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (empresa != null) data['empresa'] = empresa!.toJson();
    data['adm'] = adm;
    data['idPessoa'] = idPessoa;
    if (perfil != null) data['perfil'] = perfil!.toJson();
    data['nome'] = nome;
    data['ativo'] = ativo;
    data['vendedor'] = vendedor;
    data['comite'] = comite;
    data['forcaNovaSenha'] = forcaNovaSenha;
    data['podeCancelarOportunidade'] = podeCancelarOportunidade;
    data['email'] = email;
    data['dtExclusao'] = dtExclusao;
    data['id'] = id;
    data['codigo'] = codigo;
    data['dtInc'] = dtInc;
    data['dtAlt'] = dtAlt;
    return data;
  }
}
