// 🐦 Flutter imports:
import 'package:flutter/material.dart';

/// Definições de esquemas de cores para a aplicação.
///
/// Este arquivo contém as definições dos esquemas de cores claros e escuros
/// utilizados na aplicação. Os esquemas de cores são configurados usando
/// a classe [ColorScheme] do Flutter, que fornece uma maneira consistente
/// de definir cores para diferentes elementos da interface do usuário.
///
/// ## Esquemas de Cores:
///
/// ### lightColorScheme
/// O esquema de cores claro é utilizado quando a aplicação está em modo claro.
/// Ele define as cores para elementos como:
/// - `primary`: Cor principal da aplicação.
/// - `onPrimary`: Cor do texto ou ícones sobre a cor principal.
/// - `secondary`: Cor secundária da aplicação.
/// - `error`: Cor utilizada para indicar erros.
/// - `surface`: Cor de superfícies como cartões e caixas.
/// - `background`: Cor de fundo da aplicação.
///
/// #### Exemplo de Cores:
/// - `primary`: `Color(0xFF607D8B)`
/// - `secondary`: `Color(0xFF208c54)`
/// - `error`: `Color(0xFFBA1A1A)`
///
/// ### darkColorScheme
/// O esquema de cores escuro é utilizado quando a aplicação está em modo escuro.
/// Ele define as cores de maneira semelhante ao esquema claro, mas com cores
/// adaptadas para um fundo escuro.
///
/// #### Exemplo de Cores:
/// - `primary`: `Color(0xFF65D3FF)`
/// - `secondary`: `Color(0xFF208c54)`
/// - `error`: `Color(0xFFFFB4AB)`
///
/// ## Uso:
/// Os esquemas de cores podem ser utilizados em toda a aplicação para garantir
/// uma aparência consistente e acessível. Eles podem ser aplicados em widgets
/// como `MaterialApp` ou `ThemeData` para definir o tema da aplicação.
///
/// ## Exemplo de Uso:
/// ```dart
/// MaterialApp(
///   theme: ThemeData.from(colorScheme: lightColorScheme),
///   darkTheme: ThemeData.from(colorScheme: darkColorScheme),
///   home: MyHomePage(),
/// );
/// ```
const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  // primary: Color(0xFF006783),
  primary: Color(0xFF607D8B),
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFFBDE9FF),
  onPrimaryContainer: Color(0xFF001F2A),
  // secondary: Color(0xFF006D3D),
  secondary: Color(0xFF208c54),
  onSecondary: Color(0xFFFFFFFF),
  secondaryContainer: Color(0xFF92F8B5),
  onSecondaryContainer: Color(0xFF00210F),
  // tertiary: Color(0xFF974800),
  tertiary: Color(0xFFec7c24),
  onTertiary: Color(0xFFFFFFFF),
  tertiaryContainer: Color(0xFFFFDBC7),
  onTertiaryContainer: Color(0xFF311300),
  error: Color(0xFFBA1A1A),
  errorContainer: Color(0xFFFFDAD6),
  onError: Color(0xFFFFFFFF),
  onErrorContainer: Color(0xFF410002),
  surface: Color(0xFFFBFCFE),
  onSurface: Color(0xFF191C1E),
  surfaceContainerHighest: Color(0xFFDCE4E9),
  onSurfaceVariant: Color(0xFF40484C),
  outline: Color(0xFF70787D),
  onInverseSurface: Color(0xFFEFF1F3),
  inverseSurface: Color(0xFF2E3132),
  inversePrimary: Color(0xFF65D3FF),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFF006783),
  outlineVariant: Color(0xFFC0C8CD),
  scrim: Color(0xFF000000),
);

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFF65D3FF),
  onPrimary: Color(0xFF003546),
  primaryContainer: Color(0xFF004D64),
  onPrimaryContainer: Color(0xFFBDE9FF),
  // secondary: Color(0xFF76DB9B),
  secondary: Color(0xFF208c54),
  onSecondary: Color(0xFF00391D),
  secondaryContainer: Color(0xFF00522D),
  onSecondaryContainer: Color(0xFF92F8B5),
  // tertiary: Color(0xFFFFB689),
  tertiary: Color(0xFFec7c24),
  onTertiary: Color(0xFF512400),
  tertiaryContainer: Color(0xFF733500),
  onTertiaryContainer: Color(0xFFFFDBC7),
  error: Color(0xFFFFB4AB),
  errorContainer: Color(0xFF93000A),
  onError: Color(0xFF690005),
  onErrorContainer: Color(0xFFFFDAD6),
  surface: Color(0xFF191C1E),
  onSurface: Color(0xFFE1E2E4),
  surfaceContainerHighest: Color(0xFF40484C),
  onSurfaceVariant: Color(0xFFC0C8CD),
  outline: Color(0xFF8A9297),
  onInverseSurface: Color(0xFF191C1E),
  inverseSurface: Color(0xFFE1E2E4),
  inversePrimary: Color(0xFF006783),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFF65D3FF),
  outlineVariant: Color(0xFF40484C),
  scrim: Color(0xFF000000),
);
