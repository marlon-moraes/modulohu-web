// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:modulohu_web/src/components/responsive.dart';

/// Um widget que representa o rodapé da aplicação.
///
/// O widget [Footer] exibe informações de copyright e outros textos
/// relevantes na parte inferior da tela. Ele se adapta ao tamanho da tela,
/// exibindo um layout diferente para telas grandes e pequenas.
///
/// ## Parâmetros:
/// Este widget não possui parâmetros adicionais no construtor.
///
/// ## Exemplo:
/// ```dart
/// Footer()
/// ```
///
/// ## Uso:
/// Este widget pode ser usado em qualquer parte da aplicação onde um rodapé
/// é necessário. Ele fornece uma maneira consistente de exibir informações
/// importantes na parte inferior da interface do usuário.
class Footer extends StatelessWidget {
  final String unimedText = 'Unimed Noroeste/RS Sociedade Cooperativa de Assistência à saúde Ltda.';

  final String ansText = 'ANS - nº 357260';
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      color: theme.colorScheme.onSurface,
      width: size.width,
      height: 62,
      child: Responsive.isLargeScreen(context) ? _buildLargeScreenFooter(context) : _buildSmallScreenFooter(size, context),
    );
  }

  Widget _buildLargeScreenFooter(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          unimedText,
          style: TextStyle(fontSize: theme.textTheme.bodySmall!.fontSize, color: theme.colorScheme.surface),
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          ansText,
          style: TextStyle(fontSize: theme.textTheme.bodySmall!.fontSize, color: theme.colorScheme.surface),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildSmallScreenFooter(Size size, BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            unimedText,
            style: TextStyle(fontSize: theme.textTheme.bodySmall!.fontSize, color: theme.colorScheme.surface),
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
          Text(
            ansText,
            style: TextStyle(fontSize: theme.textTheme.bodySmall!.fontSize, color: theme.colorScheme.surface),
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
