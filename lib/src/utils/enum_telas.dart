// ignore_for_file: constant_identifier_names

/// Um enum que representa as diferentes telas da aplicação.
///
/// O enum [Telas] define os tipos de telas disponíveis na aplicação.
/// Ele pode ser utilizado para gerenciar a navegação entre diferentes
/// seções da interface do usuário.
///
/// ## Valores:
/// - `LISTAGEM`: Representa a tela de listagem, onde os itens são exibidos.
/// - `ATENDIMENTO`: Representa a tela de atendimento, onde interações específicas
///   podem ocorrer.
///
/// ## Exemplo:
/// ```dart
/// Telas telaAtual = Telas.LISTAGEM;
///
/// switch (telaAtual) {
///   case Telas.LISTAGEM:
///     // Lógica para a tela de listagem
///     break;
///   case Telas.ATENDIMENTO:
///     // Lógica para a tela de atendimento
///     break;
/// }
/// ```
///
/// ## Uso:
/// Este enum pode ser utilizado em qualquer parte da aplicação onde
/// seja necessário identificar ou gerenciar diferentes telas. Ele fornece
/// uma maneira clara e organizada de referenciar as telas disponíveis.
enum Telas { LISTAGEM, ATENDIMENTO }
