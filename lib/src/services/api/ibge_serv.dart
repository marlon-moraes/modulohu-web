// 🎯 Dart imports:
import 'dart:convert';

// 📦 Package imports:
import 'package:http/http.dart' as http;

// 🌎 Project imports:
import 'package:modulohu_web/src/models/cidade.dart';
import 'package:modulohu_web/src/models/estado.dart';

/// Serviço para consulta de estados e cidades via API do IBGE.
///
/// A classe [IBGEService] fornece métodos para buscar estados (UFs) e cidades
/// brasileiras utilizando a API pública do IBGE. É útil para preencher campos
/// de seleção de estado e cidade em formulários.
///
/// ## Propriedades:
/// - [_baseUrl]: URL base da API do IBGE utilizada para as consultas.
///
/// ## Métodos:
///
/// ### fetchEstados
/// Busca todos os estados (UFs) do Brasil, ordenados por nome.
///
/// - **Retorno:** `Future<List<Estado>>`
///   Uma lista de objetos [Estado] representando os estados brasileiros.
/// - **Exceção:** Lança uma [Exception] se a consulta falhar.
///
/// ### fetchCidadesPorEstado
/// Busca todos os municípios de um determinado estado (UF).
///
/// - **Parâmetros:**
///   - [estadoId]: O ID do estado (UF) para o qual os municípios serão buscados.
/// - **Retorno:** `Future<List<Cidade>>`
///   Uma lista de objetos [Cidade] representando os municípios do estado.
/// - **Exceção:** Lança uma [Exception] se a consulta falhar.
///
/// ## Exemplo de Uso:
/// ```dart
/// final ibgeService = IBGEService();
/// List<Estado> estados = await ibgeService.fetchEstados();
/// List<Cidade> cidades = await ibgeService.fetchCidadesPorEstado(estados.first.id);
/// ```
///
/// ## Uso:
/// Utilize esta classe em formulários ou telas onde seja necessário permitir
/// ao usuário selecionar estados e cidades brasileiras de forma dinâmica e atualizada.
class IBGEService {
  final String _baseUrl = "https://servicodados.ibge.gov.br/api/v1/localidades";

  // Busca todos os estados (UFs)
  Future<List<Estado>> fetchEstados() async {
    final response = await http.get(Uri.parse('$_baseUrl/estados?orderBy=nome'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Estado.fromJson(json)).toList();
    } else {
      throw Exception('Falha ao carregar os Estados');
    }
  }

  // Busca os municípios de um determinado estado (UF)
  Future<List<Cidade>> fetchCidadesPorEstado(int estadoId) async {
    final response = await http.get(Uri.parse('$_baseUrl/estados/$estadoId/municipios'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Cidade.fromJson(json)).toList();
    } else {
      throw Exception('Falha ao carregar as Cidades');
    }
  }
}
