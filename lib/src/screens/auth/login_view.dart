// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:modulohu_web/src/components/components.dart';
import 'package:modulohu_web/src/screens/auth/login_widget.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return LayoutBuilder(
      builder: (context, constraints) {
        double widthFactor = 0.3;
        if (Responsive.isSmallScreen(context)) {
          widthFactor = 0.9;
        } else if (Responsive.isMediumScreen(context)) {
          widthFactor = 0.5;
        }
        return Scaffold(
          appBar: PreferredSize(preferredSize: const Size(double.infinity, 57), child: Header(isAuth: true)),
          body: Scrollbar(
            controller: scrollController,
            thumbVisibility: true,
            trackVisibility: true,
            radius: Radius.zero,
            interactive: true,
            child: Center(
              child: SingleChildScrollView(
                controller: scrollController,
                child: Container(margin: const EdgeInsets.symmetric(vertical: 80), width: size.width * widthFactor, child: const LoginWidget()),
              ),
            ),
          ),
          bottomNavigationBar: const Footer(),
          extendBodyBehindAppBar: true,
          extendBody: true,
        );
      },
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
