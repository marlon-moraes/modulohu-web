// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:components/components.dart';
import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// 🌎 Project imports:
import 'package:modulohu_web/environment.dart' as env;
import 'package:modulohu_web/src/utils/utils.dart';

/// Um widget que representa o cabeçalho da aplicação.
///
/// O widget [Header] exibe um cabeçalho com um título, um logotipo e
/// opções de tema. Ele se adapta ao estado de autenticação do usuário
/// e pode incluir uma barra de abas na parte inferior.
///
/// ## Parâmetros:
/// - [isAuth]: Um boolean que indica se o usuário está autenticado.
/// - [title]: Um texto opcional que será exibido como título no cabeçalho.
/// - [bottom]: Um widget [TabBar] opcional que pode ser exibido na parte inferior do cabeçalho.
///
/// ## Exemplo:
/// ```dart
/// Header(
///   isAuth: true,
///   title: 'Usuário',
///   bottom: TabBar(
///     tabs: [
///       Tab(text: 'Tab 1'),
///       Tab(text: 'Tab 2'),
///     ],
///   ),
/// )
/// ```
///
/// ## Uso:
/// Este widget pode ser usado em qualquer parte da aplicação onde um cabeçalho
/// é necessário. Ele fornece uma maneira consistente de exibir informações
/// importantes na parte superior da interface do usuário, além de permitir
/// a troca de temas e a opção de logout.
class Header extends StatefulWidget {
  final bool isAuth;
  final String? title;
  final TabBar? bottom;

  const Header({super.key, required this.isAuth, this.title, this.bottom});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  Utils utils = Utils();

  @override
  Widget build(BuildContext context) {
    ThemeMode? themeMode = EasyDynamicTheme.of(context).themeMode;
    final theme = Theme.of(context);

    return AppBar(
      title: Row(
        children: [
          if (Responsive.isLargeScreen(context)) Image.asset('assets/images/unimed_logo.png', scale: 1.2),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 10),
              child: Text(
                widget.title == null || widget.title == '' ? env.title : 'Bem vindo(a), ${widget.title}',
                style: TextStyle(fontSize: Responsive.isLargeScreen(context) ? 22 : 18, fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
          ),
        ],
      ),
      foregroundColor: theme.colorScheme.onSecondary,
      backgroundColor: theme.colorScheme.secondary,
      automaticallyImplyLeading: !widget.isAuth,
      centerTitle: true,
      actions: [
        Container(
          margin: const EdgeInsets.only(left: 8, right: 4),
          child: IconButton(
            icon: Icon(
              themeMode == ThemeMode.light
                  ? Icons.brightness_7_rounded
                  : themeMode == ThemeMode.dark
                  ? Icons.brightness_4_rounded
                  : Icons.brightness_auto_rounded,
              color: theme.colorScheme.onSecondary,
            ),
            onPressed: () => EasyDynamicTheme.of(context).changeTheme(),
          ),
        ),
        if (!widget.isAuth)
          Container(
            margin: const EdgeInsets.only(left: 4, top: 8, right: 8, bottom: 8),
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () => utils.logout(context),
              child: Ink(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                height: 49,
                child: Row(
                  children: [
                    Icon(FontAwesomeIcons.rightFromBracket, color: theme.colorScheme.onTertiary),
                    if (!Responsive.isSmallScreen(context))
                      Container(
                        margin: const EdgeInsets.only(left: 4),
                        child: Text('Sair', style: TextStyle(color: theme.colorScheme.onTertiary, fontWeight: FontWeight.bold)),
                      ),
                  ],
                ),
              ),
            ),
          ),
      ],
      bottom: widget.bottom,
    );
  }
}
