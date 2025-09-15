// 🐦 Flutter imports:
import 'package:flutter/material.dart';

/// Uma classe que representa uma mensagem a ser exibida.
///
/// A classe [Message] é usada para criar mensagens que podem ser exibidas
/// na interface do usuário, como notificações ou alertas. Ela permite
/// personalizar o texto da mensagem, o estado de sucesso e a duração
/// da exibição.
///
/// ## Propriedades:
/// - [message]: O texto da mensagem a ser exibida.
/// - [success]: Um booleano que indica se a mensagem é de sucesso.
/// - [duration]: A duração em segundos que a mensagem será exibida. O padrão é 4 segundos.
///
/// ## Construtor:
/// - [Message]: Cria uma nova instância da classe [Message] com o texto,
///   o estado de sucesso e a duração especificados.
///
/// ## Métodos:
/// - [inputMsg]: Exibe a mensagem usando um [SnackBar] no contexto fornecido.
///
/// ## Exemplo:
/// ```dart
/// Message('Operação realizada com sucesso!', true).inputMsg(context);
/// ```
///
/// ## Uso:
/// Esta classe pode ser usada em qualquer parte da aplicação onde mensagens
/// de feedback são necessárias. Ela fornece uma maneira simples de exibir
/// notificações ao usuário.
class Message {
  final String message;
  final bool success;
  final int duration;

  Message(this.message, this.success, {this.duration = 4});

  void inputMsg(BuildContext context) {
    final theme = Theme.of(context);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: TextStyle(color: theme.colorScheme.onTertiary), textAlign: TextAlign.center),
        backgroundColor: success ? theme.colorScheme.tertiary : theme.colorScheme.error,
        duration: Duration(seconds: duration),
      ),
    );
  }
}
