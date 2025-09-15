// 🌎 Project imports:
import 'package:modulohu_web/src/models/anexo.dart';

class CRUDAnexo {
  Anexo? anexoAtdCRABody;
  String? arqBase64;

  CRUDAnexo({this.anexoAtdCRABody, this.arqBase64});

  CRUDAnexo.fromJson(Map<String, dynamic> json) {
    anexoAtdCRABody = json['anexoAtdCRABody'] != null ? Anexo.fromJson(json['anexoAtdCRABody']) : null;
    arqBase64 = json['arqBase64'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (anexoAtdCRABody != null) data['anexoAtdCRABody'] = anexoAtdCRABody!.toJson();
    data['arqBase64'] = arqBase64;
    return data;
  }
}
