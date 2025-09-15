// ignore_for_file: constant_identifier_names

/// Um arquivo que contém constantes e enums utilizados na aplicação.
///
/// Este arquivo define enums para diferentes tipos de requisições HTTP
/// e para os retornos de atendimento. Além disso, inclui uma função
/// para obter o nome correspondente ao enum [RetornoAtendimento].
///
/// ## Enums:
///
/// ### HttpRequests
/// Enum que representa os diferentes tipos de requisições HTTP.
/// - `GET`: Requisição para obter dados.
/// - `HEAD`: Requisição para obter cabeçalhos.
/// - `POST`: Requisição para enviar dados.
/// - `PUT`: Requisição para atualizar dados.
/// - `DELETE`: Requisição para excluir dados.
/// - `CONNECT`: Requisição para estabelecer uma conexão.
/// - `OPTIONS`: Requisição para obter opções de comunicação.
/// - `TRACE`: Requisição para rastrear a rota até o servidor.
/// - `PATCH`: Requisição para aplicar modificações parciais.
/// - `OUTRO`: Representa outros tipos de requisições.
///
/// ### RetornoAtendimento
/// Enum que representa os diferentes tipos de retorno de atendimento.
/// - `MEDICO`: Retorno relacionado ao médico.
/// - `CLIENTE`: Retorno relacionado ao cliente.
/// - `MEDICO_CLIENTE`: Retorno relacionado tanto ao médico quanto ao cliente.
///
/// ## Funções:
///
/// ### getRetornoAtendimentoName
/// Retorna o nome correspondente ao valor do enum [RetornoAtendimento].
///
/// - **Parâmetros:**
///   - [value]: O valor do enum [RetornoAtendimento] para o qual o nome deve ser retornado.
///
/// - **Retorno:** Uma string que representa o nome do retorno de atendimento.
///
/// ## Exemplo:
/// ```dart
/// String nome = getRetornoAtendimentoName(RetornoAtendimento.MEDICO);
/// print(nome); // Saída: Médico
/// ```
///
/// ## Uso:
/// Este arquivo pode ser utilizado em qualquer parte da aplicação onde
/// seja necessário trabalhar com requisições HTTP ou tipos de retorno de
/// atendimento. Ele fornece uma maneira organizada de gerenciar constantes
/// e enums relacionados à lógica da aplicação.
enum HttpRequests { GET, HEAD, POST, PUT, DELETE, CONNECT, OPTIONS, TRACE, PATCH, OUTRO }

enum RetornoAtendimento { MEDICO, CLIENTE, MEDICO_CLIENTE }

String getRetornoAtendimentoName(RetornoAtendimento value) {
  switch (value) {
    case RetornoAtendimento.MEDICO:
      return 'Médico';
    case RetornoAtendimento.CLIENTE:
      return 'Cliente';
    case RetornoAtendimento.MEDICO_CLIENTE:
      return 'Médico e Cliente';
  }
}
