// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

// 🌎 Project imports:
import 'package:modulohu_web/environment.dart' as env;
import 'package:modulohu_web/src/services/router/app_routes.dart';
import 'package:modulohu_web/src/themes/theme.dart';

/// O ponto de entrada da aplicação.
///
/// Este arquivo contém a função `main`, que inicializa a aplicação
/// Flutter e configura o tema dinâmico, as variáveis de ambiente
/// e as rotas da aplicação.
///
/// ## Função principal:
///
/// ### main
/// A função `main` é o ponto de entrada da aplicação. Ela carrega
/// as variáveis de ambiente a partir de um arquivo `.env` e inicia
/// a aplicação com o widget `EasyDynamicThemeWidget`.
///
/// - **Retorno:**
///   Um `Future<void>` que indica que a inicialização da aplicação
///   foi concluída.
Future<void> main() async {
  await dotenv.load(fileName: '.env');
  runApp(EasyDynamicThemeWidget(child: const MyApp()));
}

/// ## Classe MyApp:
///
/// A classe [MyApp] é um widget sem estado que configura o tema,
/// as localizações e as rotas da aplicação.
///
/// ### Métodos:
///
/// #### build
/// O método `build` constrói a interface do usuário da aplicação.
///
/// - **Parâmetros:**
///   - [context]: O contexto do widget.
///
/// - **Retorno:**
///   Retorna um `MaterialApp.router` configurado com:
///   - Delegados de localizações para suporte a múltiplos idiomas.
///   - Modos de tema dinâmico.
///   - Título da aplicação obtido das variáveis de ambiente.
///   - Configuração do roteador.
///   - Temas claro e escuro.
///
/// ## Exemplo de Uso:
/// ```dart
/// void main() async {
///   runApp(EasyDynamicThemeWidget(child: const MyApp()));
/// }
/// ```
///
/// ## Uso:
/// Este arquivo é essencial para a inicialização da aplicação Flutter.
/// Ele configura as dependências necessárias e define a estrutura
/// básica da aplicação, incluindo temas e rotas.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      localizationsDelegates: [GlobalMaterialLocalizations.delegate, GlobalWidgetsLocalizations.delegate, GlobalCupertinoLocalizations.delegate],
      supportedLocales: const [Locale('pt', 'BR'), Locale('en', 'US')],
      themeMode: EasyDynamicTheme.of(context).themeMode,
      title: env.title,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      darkTheme: Themes.darkThemeData,
      theme: Themes.lightThemeData,
    );
  }
}
