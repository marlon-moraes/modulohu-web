// 🌎 Project imports:
import 'package:modulohu_web/src/models/usuario.dart';

class PessoaCadastro {
  String? id;
  int? codigo;
  String? idEmp;
  String? nome;
  String? tipoPessoa;
  String? cpf;
  String? nacionalidade;
  String? estadoCivil;
  String? sexo;
  String? dddCelular;
  String? celular;
  String? email;
  String? origemPessoa;
  String? isEnfermeiro;
  String? prestador;
  String? geradoPlanium;
  String? dtNascimento;
  User? usuInc;
  User? usuAlt;
  String? dtInc;
  String? dtAlt;

  PessoaCadastro({
    this.id,
    this.codigo,
    this.idEmp,
    this.nome,
    this.tipoPessoa,
    this.cpf,
    this.nacionalidade,
    this.estadoCivil,
    this.sexo,
    this.dddCelular,
    this.celular,
    this.email,
    this.origemPessoa,
    this.isEnfermeiro,
    this.prestador,
    this.geradoPlanium,
    this.dtNascimento,
    this.usuInc,
    this.usuAlt,
    this.dtInc,
    this.dtAlt,
  });

  PessoaCadastro.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    codigo = json['codigo'];
    idEmp = json['idEmp'];
    nome = json['nome'];
    tipoPessoa = json['tipoPessoa'];
    cpf = json['cpf'];
    nacionalidade = json['nacionalidade'];
    estadoCivil = json['estadoCivil'];
    sexo = json['sexo'];
    dddCelular = json['dddCelular'];
    celular = json['celular'];
    email = json['email'];
    origemPessoa = json['origemPessoa'];
    isEnfermeiro = json['isEnfermeiro'];
    prestador = json['prestador'];
    geradoPlanium = json['geradoPlanium'];
    dtNascimento = json['dtNascimento'];
    usuInc = json['usuInc'] != null ? User.fromJson(json['usuInc']) : null;
    usuAlt = json['usuAlt'] != null ? User.fromJson(json['usuAlt']) : null;
    dtInc = json['dtInc'];
    dtAlt = json['dtAlt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['codigo'] = codigo;
    data['idEmp'] = idEmp;
    data['nome'] = nome;
    data['tipoPessoa'] = tipoPessoa;
    data['cpf'] = cpf;
    data['nacionalidade'] = nacionalidade;
    data['estadoCivil'] = estadoCivil;
    data['sexo'] = sexo;
    data['dddCelular'] = dddCelular;
    data['celular'] = celular;
    data['email'] = email;
    data['origemPessoa'] = origemPessoa;
    data['isEnfermeiro'] = isEnfermeiro;
    data['prestador'] = prestador;
    data['geradoPlanium'] = geradoPlanium;
    data['dtNascimento'] = dtNascimento;
    if (usuInc != null) data['usuInc'] = usuInc!.toJson();
    if (usuAlt != null) data['usuAlt'] = usuAlt!.toJson();
    data['dtInc'] = dtInc;
    data['dtAlt'] = dtAlt;
    return data;
  }
}
