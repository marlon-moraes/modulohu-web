// ignore_for_file: constant_identifier_names

enum HttpRequests { GET, HEAD, POST, PUT, DELETE, CONNECT, OPTIONS, TRACE, PATCH, OUTRO }

enum RetornoAtendimento { MEDICO, CLIENTE, MEDICO_CLIENTE }

enum Telas { LISTAGEM, ATENDIMENTO }

String getRetornoAtendimentoName(RetornoAtendimento value) {
  switch (value) {
    case RetornoAtendimento.MEDICO:
      return 'Médico';
    case RetornoAtendimento.CLIENTE:
      return 'Cliente';
    case RetornoAtendimento.MEDICO_CLIENTE:
      return 'Médico e Cliente';
  }
}
