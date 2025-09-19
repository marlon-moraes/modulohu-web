import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:modulohu_web/src/models/cidade.dart';
import 'package:modulohu_web/src/models/estado.dart';

class IbgeService {
  final String _baseUrl = "https://servicodados.ibge.gov.br/api/v1/localidades";

  // Busca todos os estados (UFs)
  Future<List<Estado>> fetchEstados() async {
    final response = await http.get(Uri.parse('$_baseUrl/estados?orderBy=nome'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Estado.fromJson(json)).toList();
    } else {
      throw Exception('Falha ao carregar os estados');
    }
  }

  // Busca os municípios de um determinado estado (UF)
  Future<List<Cidade>> fetchCidadesPorEstado(int estadoId) async {
    final response = await http.get(Uri.parse('$_baseUrl/estados/$estadoId/municipios'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Cidade.fromJson(json)).toList();
    } else {
      throw Exception('Falha ao carregar as cidades');
    }
  }
}
