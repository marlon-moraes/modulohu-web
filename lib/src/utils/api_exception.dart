/// Uma classe que representa uma exceção de API.
///
/// A classe [ApiException] é usada para encapsular mensagens de erro
/// relacionadas a chamadas de API. Ela implementa a interface [Exception],
/// permitindo que seja lançada e capturada como uma exceção.
///
/// ## Propriedades:
/// - [message]: A mensagem de erro que descreve a exceção.
///
/// ## Construtor:
/// - [ApiException]: Cria uma nova instância da classe [ApiException]
///   com a mensagem de erro especificada.
///
/// ## Métodos:
/// - [toString]: Retorna a mensagem de erro como uma string.
///
/// ## Exemplo:
/// ```dart
/// throw ApiException('Erro ao conectar à API');
/// ```
///
/// ## Uso:
/// Esta classe pode ser usada em qualquer parte da aplicação onde
/// seja necessário tratar erros relacionados a chamadas de API. Ela
/// fornece uma maneira consistente de encapsular e relatar erros.
class ApiException implements Exception {
  final String message;

  ApiException(this.message);

  @override
  String toString() => message;
}
