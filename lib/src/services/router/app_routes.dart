// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:go_router/go_router.dart';

// 🌎 Project imports:
import 'package:modulohu_web/src/components/components.dart';
import 'package:modulohu_web/src/screens/auth/login_view.dart';
import 'package:modulohu_web/src/screens/home/atendimento/atendimento_view.dart';
import 'package:modulohu_web/src/screens/home/listagem/listagem_view.dart';

/// Configuração das rotas da aplicação.
///
/// Este arquivo define as rotas da aplicação utilizando o pacote
/// [go_router]. As rotas são configuradas para gerenciar a navegação
/// entre diferentes telas da aplicação, como a tela de login e as
/// telas de listagem e atendimento.
///
/// ## Rotas Definidas:
///
/// - **Rota Inicial (`/`)**:
///   - **Builder:** `LoginView`
///   - **Descrição:** Tela de login da aplicação.
///
/// - **Rota de Listagem (`/home/listagem`)**:
///   - **Builder:** `ListagemView`
///   - **Descrição:** Tela que exibe a listagem de itens.
///
/// - **Rota de Atendimento (`/home/atendimento`)**:
///   - **Builder:** `AtendimentoView`
///   - **Descrição:** Tela que exibe informações e funcionalidades relacionadas ao atendimento.
///
/// ## Tratamento de Erros:
/// O [GoRouter] também define um `errorBuilder` que exibe uma página
/// de erro personalizada quando uma rota não é encontrada.
///
/// ### NotFoundPage:
/// A classe [NotFoundPage] é um widget que exibe uma mensagem de erro
/// 404 quando a rota solicitada não é encontrada. Ela inclui:
/// - Um cabeçalho com um componente de autenticação.
/// - Mensagens de erro centralizadas.
/// - Um botão flutuante que permite ao usuário voltar para a página inicial.
/// - Um rodapé.
///
/// ## Exemplo de Uso:
/// ```dart
/// void main() {
///   runApp(MaterialApp.router(
///     routerDelegate: router.routerDelegate,
///     routeInformationParser: router.routeInformationParser,
///   ));
/// }
/// ```
///
/// ## Uso:
/// Este arquivo é essencial para a configuração da navegação na aplicação.
/// Ele permite que os desenvolvedores definam rotas de maneira clara e
/// organizada, facilitando a manutenção e a expansão da aplicação.
final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => LoginView()),
    GoRoute(path: '/home/listagem', builder: (context, state) => ListagemView()),
    GoRoute(path: '/home/atendimento', builder: (context, state) => AtendimentoView()),
  ],
  errorBuilder: (context, state) => NotFoundPage(),
);

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: PreferredSize(preferredSize: const Size(double.infinity, 57), child: Header(isAuth: true)),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text('404', style: TextStyle(color: theme.colorScheme.error, fontWeight: FontWeight.bold, fontSize: 40))),
          Center(child: Text('PÁGINA NÃO ENCONTRADA', style: TextStyle(color: theme.colorScheme.error, fontSize: 36))),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Voltar para a página inicial',
        child: const Icon(Icons.chevron_left),
        onPressed: () => context.go('/'),
      ),
      bottomNavigationBar: const Footer(),
      extendBodyBehindAppBar: true,
      extendBody: true,
    );
  }
}
