// 🐦 Flutter imports:
import 'package:flutter/material.dart';

/// Um widget que adapta a interface do usuário com base no tamanho da tela.
///
/// A classe [Responsive] permite que você forneça diferentes widgets para
/// diferentes tamanhos de tela (grande, média e pequena). Isso é útil
/// para criar layouts responsivos que se ajustam a diferentes dispositivos.
///
/// ## Propriedades:
/// - [largeScreen]: O widget a ser exibido em telas grandes. Este parâmetro é obrigatório.
/// - [mediumScreen]: O widget a ser exibido em telas médias. Este parâmetro é opcional.
/// - [smallScreen]: O widget a ser exibido em telas pequenas. Este parâmetro é opcional.
///
/// ## Construtor:
/// - [Responsive]: Cria uma nova instância da classe [Responsive] com os widgets
///   especificados para diferentes tamanhos de tela.
///
/// ## Tamanhos de Tela:
/// - `largeScreenSize`: Define o limite superior para telas grandes (1200 pixels).
/// - `mediumScreenSize`: Define o limite inferior para telas médias (800 pixels).
///
/// ## Métodos Estáticos:
/// - [isLargeScreen]: Retorna um booleano indicando se a tela é grande.
/// - [isMediumScreen]: Retorna um booleano indicando se a tela é média.
/// - [isSmallScreen]: Retorna um booleano indicando se a tela é pequena.
///
/// ## Exemplo:
/// ```dart
/// Responsive(
///   largeScreen: LargeWidget(),
///   mediumScreen: MediumWidget(),
///   smallScreen: SmallWidget(),
/// )
/// ```
///
/// ## Uso:
/// Este widget pode ser usado em qualquer parte da aplicação onde um layout
/// responsivo é necessário. Ele fornece uma maneira simples de adaptar a
/// interface do usuário a diferentes tamanhos de tela, melhorando a experiência
/// do usuário em dispositivos variados.
class Responsive extends StatelessWidget {
  final Widget? mediumScreen;
  final Widget? smallScreen;
  final Widget largeScreen;

  const Responsive({super.key, required this.largeScreen, this.mediumScreen, this.smallScreen});

  static const double largeScreenSize = 1200;
  static const double mediumScreenSize = 800;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > largeScreenSize) {
          return largeScreen;
        } else if (constraints.maxWidth <= largeScreenSize && constraints.maxWidth >= mediumScreenSize) {
          return mediumScreen ?? largeScreen;
        } else {
          return smallScreen ?? largeScreen;
        }
      },
    );
  }

  static bool isLargeScreen(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return screenWidth > largeScreenSize;
  }

  static bool isMediumScreen(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return screenWidth >= mediumScreenSize && screenWidth <= largeScreenSize;
  }

  static bool isSmallScreen(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return screenWidth < mediumScreenSize;
  }
}
