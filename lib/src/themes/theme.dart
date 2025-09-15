// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:google_fonts/google_fonts.dart';

// 🌎 Project imports:
import 'package:modulohu_web/src/themes/color_schemes.g.dart';

/// Definições de temas para a aplicação.
///
/// Este arquivo contém as definições dos temas claro e escuro utilizados
/// na aplicação, utilizando a classe [ThemeData] do Flutter. Os temas
/// são configurados com base nos esquemas de cores definidos em
/// `color_schemes.g.dart` e utilizam a fonte Poppins do Google Fonts.
///
/// ## Temas Definidos:
///
/// ### lightThemeData
/// O tema claro da aplicação, que utiliza:
/// - **Fonte:** Poppins (importada do Google Fonts).
/// - **Esquema de Cores:** `lightColorScheme`, que define as cores para
///   elementos da interface do usuário em modo claro.
/// - **Material 3:** Desativado (`useMaterial3: false`).
///
/// ### darkThemeData
/// O tema escuro da aplicação, que utiliza:
/// - **Fonte:** Poppins (importada do Google Fonts).
/// - **Esquema de Cores:** `darkColorScheme`, que define as cores para
///   elementos da interface do usuário em modo escuro.
/// - **Material 3:** Desativado (`useMaterial3: false`).
///
/// ### loadingBarColor
/// Uma constante que define a cor da barra de carregamento como verde.
/// Esta cor pode ser utilizada em diferentes partes da aplicação onde
/// uma barra de carregamento é necessária.
///
/// ## Exemplo de Uso:
/// ```dart
/// MaterialApp(
///   theme: lightThemeData,
///   darkTheme: darkThemeData,
///   home: MyHomePage(),
/// );
/// ```
///
/// ## Uso:
/// Este arquivo é essencial para a configuração da aparência da aplicação.
/// Ele permite que a interface do usuário seja consistente e adaptável
/// a diferentes modos de tema, melhorando a experiência do usuário.
final lightThemeData = ThemeData(fontFamily: GoogleFonts.poppins().fontFamily, colorScheme: lightColorScheme, useMaterial3: false);

final darkThemeData = ThemeData(fontFamily: GoogleFonts.poppins().fontFamily, colorScheme: darkColorScheme, useMaterial3: false);

const loadingBarColor = Colors.green;
