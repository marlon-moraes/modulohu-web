/// Valida um campo de dropdown.
///
/// A função [dropdownValidation] verifica se o valor do dropdown está vazio
/// ou nulo. Se estiver, retorna uma mensagem de erro indicando que o campo
/// deve ser informado.
///
/// ## Parâmetros:
/// - [value]: O valor do dropdown a ser validado.
/// - [type]: O tipo do campo, usado na mensagem de erro.
///
/// ## Retorno:
/// Retorna uma string com a mensagem de erro ou `null` se a validação for bem-sucedida.
///
/// ## Exemplo:
/// ```dart
/// String? erro = dropdownValidation(null, 'opção');
/// print(erro); // Saída: 'Campo opção deve ser informado!'
/// ```
String? dropdownValidation(String? value, String type) {
  if (value == null || value.isEmpty) {
    return 'Campo $type deve ser informado!';
  } else {
    return null;
  }
}

/// Valida um campo de texto.
///
/// A função [fieldValidation] verifica se o valor do campo está vazio
/// ou nulo. Se estiver, retorna uma mensagem de erro indicando que o campo
/// deve ser preenchido.
///
/// ## Parâmetros:
/// - [value]: O valor do campo a ser validado.
/// - [type]: O tipo do campo, usado na mensagem de erro.
///
/// ## Retorno:
/// Retorna uma string com a mensagem de erro ou `null` se a validação for bem-sucedida.
///
/// ## Exemplo:
/// ```dart
/// String? erro = fieldValidation('', 'nome');
/// print(erro); // Saída: 'Campo nome deve ser preenchido!'
/// ```
String? fieldValidation(String? value, String type) {
  if (value == null || value.isEmpty) {
    return 'Campo $type deve ser preenchido!';
  } else {
    return null;
  }
}

/// Valida uma lista.
///
/// A função [listValidation] verifica se a lista está vazia ou nula.
/// Se estiver, retorna uma mensagem de erro indicando que pelo menos um
/// item deve ser selecionado.
///
/// ## Parâmetros:
/// - [value]: A lista a ser validada.
/// - [type]: O tipo do item, usado na mensagem de erro.
///
/// ## Retorno:
/// Retorna uma string com a mensagem de erro ou `null` se a validação for bem-sucedida.
///
/// ## Exemplo:
/// ```dart
/// String? erro = listValidation([], 'item');
/// print(erro); // Saída: 'Selecione ao menos um item!'
/// ```
String? listValidation(List<dynamic>? value, String type) {
  if (value == null || value.isEmpty) {
    return 'Selecione ao menos um $type!';
  } else {
    return null;
  }
}

/// Valida um CPF.
///
/// A função [cpfValidation] verifica se o CPF é válido. Ela remove
/// caracteres não numéricos e aplica a lógica de validação do CPF.
///
/// ## Parâmetros:
/// - [value]: O CPF a ser validado.
///
/// ## Retorno:
/// Retorna uma string com a mensagem de erro se o CPF for inválido ou
/// `null` se a validação for bem-sucedida.
///
/// ## Exemplo:
/// ```dart
/// String? erro = cpfValidation('123.456.789-09');
/// print(erro); // Saída: 'CPF inválido!' (se o CPF não for válido)
/// ```
String? cpfValidation(String value) {
  value = value.replaceAll(RegExp(r'\D'), '');
  if (value == '00000000000' ||
      value == '11111111111' ||
      value == '22222222222' ||
      value == '33333333333' ||
      value == '44444444444' ||
      value == '55555555555' ||
      value == '66666666666' ||
      value == '77777777777' ||
      value == '88888888888' ||
      value == '99999999999') {
    return 'CPF inválido!';
  }
  int sum = 0;
  for (var i = 0; i < 9; i++) {
    sum += int.parse(value[i]) * (10 - i);
  }
  int digit1 = 11 - (sum % 11);
  if (digit1 >= 10) digit1 = 0;
  sum = 0;
  for (int i = 0; i < 10; i++) {
    sum += int.parse(value[i]) * (11 - i);
  }
  int digit2 = 11 - (sum % 11);
  if (digit2 >= 10) digit2 = 0;
  if (value.substring(9) != '$digit1$digit2') return 'CPF inválido!';
  return null;
}

/// Valida um endereço de e-mail.
///
/// A função [emailValidation] verifica se o e-mail está vazio ou nulo
/// e se corresponde ao formato de e-mail válido.
///
/// ## Parâmetros:
/// - [value]: O e-mail a ser validado.
///
/// ## Retorno:
/// Retorna uma string com a mensagem de erro se o e-mail for inválido ou
/// `null` se a validação for bem-sucedida.
///
/// ## Exemplo:
/// ```dart
/// String? erro = emailValidation('exemplo@dominio.com');
/// print(erro); // Saída: null (se o e-mail for válido)
/// ```
String? emailValidation(String? value) {
  if (value == null || value.isEmpty) return 'Email deve ser informado!';
  final RegExp emailRegExp = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  if (!emailRegExp.hasMatch(value)) return 'Email inválido!';
  return null;
}
