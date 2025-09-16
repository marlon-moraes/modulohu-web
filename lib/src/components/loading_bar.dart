// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:modulohu_web/src/themes/theme.dart';

/// Um widget que exibe uma barra de carregamento.
///
/// A função [loadingBar] retorna um widget que representa uma barra de
/// carregamento linear. Se o parâmetro [loading] for verdadeiro, a barra
/// de carregamento será exibida; caso contrário, um espaço vazio será
/// retornado.
///
/// ## Parâmetros:
/// - [loading]: Um booleano que indica se a barra de carregamento deve
///   ser exibida. Se verdadeiro, a barra de carregamento será mostrada;
///   se falso, um [SizedBox] com altura de 8 pixels será retornado.
///
/// ## Exemplo:
/// ```dart
/// loadingBar(true) // Exibe a barra de carregamento
/// ```
///
/// ## Uso:
/// Esta função pode ser usada em qualquer parte da aplicação onde uma
/// barra de carregamento é necessária. Ela fornece uma maneira simples
/// de indicar que uma operação está em andamento.
Widget loadingBar(bool loading) {
  return Container(
    child:
        loading
            ? LinearProgressIndicator(
              valueColor: const AlwaysStoppedAnimation(Themes.loadingBarColor),
              backgroundColor: Colors.grey.withValues(alpha: 0.1),
              minHeight: 8,
            )
            : const SizedBox(height: 8),
  );
}
