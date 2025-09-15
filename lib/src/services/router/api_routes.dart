/// Classe que define as rotas da API utilizadas na aplicação.
///
/// A classe [ApiRoutes] contém constantes que representam os endpoints
/// da API para diferentes funcionalidades da aplicação. As rotas são
/// organizadas em seções, como autenticação, atendimento, cadastros,
/// eventos, anexos, agenda médica, transferência e informações de
/// contrato.
///
/// ## Variáveis de Ambiente:
/// A classe utiliza a variável de ambiente `API_ENV` para determinar
/// se a aplicação está em modo de produção ou homologação. Dependendo
/// do valor dessa variável, as rotas são definidas para apontar para
/// os endpoints corretos.
///
/// ## Rotas Definidas:
///
/// ### Autenticação
/// - `logon`: Endpoint para realizar o login do usuário.
/// - `alterarSenha`: Endpoint para atualizar a senha do usuário.
///
/// ### Atendimento
/// - `incluirAtendimento`: Endpoint para incluir um novo atendimento.
/// - `listarAtendimento`: Endpoint para listar atendimentos.
/// - `alterarAtendimento`: Endpoint para alterar um atendimento.
/// - `cancelarAtendimento`: Endpoint para cancelar um atendimento.
/// - `finalizarAtendimento`: Endpoint para finalizar um atendimento.
/// - `reabrirAtendimento`: Endpoint para reabrir um atendimento.
///
/// ### Cadastros
/// - `incluirTipoAtendimento`: Endpoint para incluir um tipo de atendimento.
/// - `listarTipoAtendimento`: Endpoint para listar tipos de atendimento.
/// - `alterarTipoAtendimento`: Endpoint para alterar um tipo de atendimento.
/// - `excluirTipoAtendimento`: Endpoint para excluir um tipo de atendimento.
///
/// - `incluirAssunto`: Endpoint para incluir um assunto.
/// - `listarAssunto`: Endpoint para listar assuntos.
/// - `alterarAssunto`: Endpoint para alterar um assunto.
/// - `excluirAssunto`: Endpoint para excluir um assunto.
///
/// - `incluirCanal`: Endpoint para incluir um canal.
/// - `listarCanal`: Endpoint para listar canais.
/// - `alterarCanal`: Endpoint para alterar um canal.
/// - `excluirCanal`: Endpoint para excluir um canal.
///
/// - `incluirCaraterAtendimento`: Endpoint para incluir um caráter de atendimento.
/// - `listarCaraterAtendimento`: Endpoint para listar caracteres de atendimento.
/// - `alterarCaraterAtendimento`: Endpoint para alterar um caráter de atendimento.
/// - `excluirCaraterAtendimento`: Endpoint para excluir um caráter de atendimento.
///
/// - `incluirStatus`: Endpoint para incluir um status.
/// - `listarStatus`: Endpoint para listar status.
/// - `alterarStatus`: Endpoint para alterar um status.
/// - `excluirStatus`: Endpoint para excluir um status.
///
/// ### Evento/Assentamento
/// - `incluirEvento`: Endpoint para incluir um evento.
/// - `listarEvento`: Endpoint para listar eventos.
/// - `alterarEvento`: Endpoint para alterar um evento.
/// - `excluirEvento`: Endpoint para excluir um evento.
///
/// ### Anexo
/// - `incluirAnexo`: Endpoint para incluir um anexo.
/// - `listarAnexo`: Endpoint para listar anexos.
/// - `carregarAnexo`: Endpoint para carregar um anexo por ID.
/// - `excluirAnexo`: Endpoint para excluir um anexo.
///
/// ### Agenda Médica
/// - `listarEspecializacao`: Endpoint para listar especializações.
/// - `listarEspecialidade`: Endpoint para listar especialidades.
/// - `listarProcedimentos`: Endpoint para listar procedimentos.
/// - `incluirProcedimento`: Endpoint para incluir um procedimento.
/// - `listarProcedimento`: Endpoint para listar procedimentos.
/// - `alterarProcedimento`: Endpoint para alterar um procedimento.
/// - `excluirProcedimento`: Endpoint para excluir um procedimento.
/// - `listarAgendaMedica`: Endpoint para listar agendas médicas.
/// - `alterarAgendaMedica`: Endpoint para alterar uma agenda médica.
///
/// ### Ambulância/Transferência
/// - `incluirTransferencia`: Endpoint para incluir uma transferência.
/// - `listarTransferencia`: Endpoint para listar transferências.
/// - `alterarTransferencia`: Endpoint para alterar uma transferência.
/// - `excluirTransferencia`: Endpoint para excluir uma transferência.
///
/// ### Seletores
/// - `listarPrestadorServico`: Endpoint para listar prestadores de serviço.
/// - `listarBeneficiario`: Endpoint para listar beneficiários.
/// - `listarResponsavel`: Endpoint para listar responsáveis.
///
/// ### Pessoa
/// - `validarPessoaCpf`: Endpoint para validar uma pessoa pelo CPF.
/// - `carregarTelefonePessoa`: Endpoint para carregar telefone de uma pessoa.
/// - `listarPessoa`: Endpoint para listar pessoas.
/// - `incluirPessoa`: Endpoint para incluir uma nova pessoa.
///
/// ### Contrato
/// - `carregarInformacoesContrato`: Endpoint para carregar informações de contrato.
/// - `carregarInformacoesCoberturas`: Endpoint para carregar informações de coberturas.
/// - `carregarInformacoesModuloBeneficiario`: Endpoint para carregar informações do módulo beneficiário.
class ApiRoutes {
  // static final _rootSpringModuloCommon = '/modulo_common_homologacao';
  // static final _rootSpringModuloHU = '/modulo_hu_homologacao';
  // static final _rootSpringModuloCardio = '/modulo_cardio_homologacao';
  // static final _rootSpringModuloCommon = '/modulo_common';
  // static final _rootSpringModuloHU = '/modulo_hu';
  // static final _rootSpringModuloCardio =  '/modulo_cardio';

  static const _apiEnv = String.fromEnvironment('API_ENV', defaultValue: 'homologacao');
  static final _rootSpringModuloCommon = _apiEnv == 'producao' ? '/modulo_common' : '/modulo_common_homologacao';
  static final _rootSpringModuloHU = _apiEnv == 'producao' ? '/modulo_hu' : '/modulo_hu_homologacao';
  static final _rootSpringModuloCardio = _apiEnv == 'producao' ? '/modulo_cardio' : '/modulo_cardio_homologacao';

  //* AUTENTICAÇÃO
  static final logon = '$_rootSpringModuloCommon/usuario/actions/logon';
  static final alterarSenha = '$_rootSpringModuloCommon/usuario/actions/updatePassword';

  //* ATENDIMENTO
  static final incluirAtendimento = '$_rootSpringModuloHU/atendimentocra/actions/begin';
  static final listarAtendimento = '$_rootSpringModuloHU/atendimentocra/list';
  static final alterarAtendimento = '$_rootSpringModuloHU/atendimentocra/actions/update';
  static final cancelarAtendimento = '$_rootSpringModuloHU/atendimentocra/actions/cancel';
  static final finalizarAtendimento = '$_rootSpringModuloHU/atendimentocra/actions/finish';
  static final reabrirAtendimento = '$_rootSpringModuloHU/atendimentocra/actions/reopen';

  //* CADASTROS
  static final incluirTipoAtendimento = '$_rootSpringModuloHU/atendimentocra/tipo/create';
  static final listarTipoAtendimento = '$_rootSpringModuloHU/atendimentocra/tipo/list';
  static final alterarTipoAtendimento = '$_rootSpringModuloHU/atendimentocra/tipo/update';
  static final excluirTipoAtendimento = '$_rootSpringModuloHU/atendimentocra/tipo/delete';

  static final incluirAssunto = '$_rootSpringModuloHU/atendimentocra/assunto/create';
  static final listarAssunto = '$_rootSpringModuloHU/atendimentocra/assunto/list';
  static final alterarAssunto = '$_rootSpringModuloHU/atendimentocra/assunto/update';
  static final excluirAssunto = '$_rootSpringModuloHU/atendimentocra/assunto/delete';

  static final incluirCanal = '$_rootSpringModuloHU/atendimentocra/canal/create';
  static final listarCanal = '$_rootSpringModuloHU/atendimentocra/canal/list';
  static final alterarCanal = '$_rootSpringModuloHU/atendimentocra/canal/update';
  static final excluirCanal = '$_rootSpringModuloHU/atendimentocra/canal/delete';

  static final incluirCaraterAtendimento = '$_rootSpringModuloHU/atendimentocra/carater/create';
  static final listarCaraterAtendimento = '$_rootSpringModuloHU/atendimentocra/carater/list';
  static final alterarCaraterAtendimento = '$_rootSpringModuloHU/atendimentocra/carater/update';
  static final excluirCaraterAtendimento = '$_rootSpringModuloHU/atendimentocra/carater/delete';

  static final incluirStatus = '$_rootSpringModuloHU/atendimentocra/status/create';
  static final listarStatus = '$_rootSpringModuloHU/atendimentocra/status/list';
  static final alterarStatus = '$_rootSpringModuloHU/atendimentocra/status/update';
  static final excluirStatus = '$_rootSpringModuloHU/atendimentocra/status/delete';

  //* EVENTO/ASSENTAMENTO
  static final incluirEvento = '$_rootSpringModuloHU/atendimentocra/evento/create';
  static final listarEvento = '$_rootSpringModuloHU/atendimentocra/evento/list';
  static final alterarEvento = '$_rootSpringModuloHU/atendimentocra/evento/update';
  static final excluirEvento = '$_rootSpringModuloHU/atendimentocra/evento/delete';

  //* ANEXO
  static final incluirAnexo = '$_rootSpringModuloHU/atendimentocra/anexo/actions/include';
  static final listarAnexo = '$_rootSpringModuloHU/atendimentocra/anexo/list';
  static final carregarAnexo = '$_rootSpringModuloHU/atendimentocra/anexo/actions/openById';
  static final excluirAnexo = '$_rootSpringModuloHU/atendimentocra/anexo/actions/exclude';

  //* AGENDA MÉDICA
  static final listarEspecializacao = '$_rootSpringModuloHU/especializacao/list';
  static final listarEspecialidade = '$_rootSpringModuloCardio/especialidade/list';
  static final listarProcedimentos = '$_rootSpringModuloCardio/procedimento/list';

  static final incluirProcedimento = '$_rootSpringModuloHU/atendimentocra/agendamedica/procedimento/actions/create';
  static final listarProcedimento = '$_rootSpringModuloHU/atendimentocra/agendamedica/procedimento/list';
  static final alterarProcedimento = '$_rootSpringModuloHU/atendimentocra/agendamedica/procedimento/update';
  static final excluirProcedimento = '$_rootSpringModuloHU/atendimentocra/agendamedica/procedimento/delete';

  static final listarAgendaMedica = '$_rootSpringModuloHU/atendimentocra/agendamedica/list';
  static final alterarAgendaMedica = '$_rootSpringModuloHU/atendimentocra/agendamedica/update';

  //* AMBULÂNCIA/TRANSFERÊNCIA
  static final incluirTransferencia = '$_rootSpringModuloHU/atendimentocra/transferencia/create';
  static final listarTransferencia = '$_rootSpringModuloHU/atendimentocra/transferencia/list';
  static final alterarTransferencia = '$_rootSpringModuloHU/atendimentocra/transferencia/update';
  static final excluirTransferencia = '$_rootSpringModuloHU/atendimentocra/transferencia/delete';

  static final incluirCoberturaContratual = '$_rootSpringModuloHU/atendimentocra/transferencia/coberturacontratual/create';
  static final listarCoberturaContratual = '$_rootSpringModuloHU/atendimentocra/transferencia/coberturacontratual/list';
  static final alterarCoberturaContratual = '$_rootSpringModuloHU/atendimentocra/transferencia/coberturacontratual/update';
  static final excluirCoberturaContratual = '$_rootSpringModuloHU/atendimentocra/transferencia/coberturacontratual/delete';

  static final incluirConvenio = '$_rootSpringModuloHU/atendimentocra/transferencia/convenio/create';
  static final listarConvenio = '$_rootSpringModuloHU/atendimentocra/transferencia/convenio/list';
  static final alterarConvenio = '$_rootSpringModuloHU/atendimentocra/transferencia/convenio/update';
  static final excluirConvenio = '$_rootSpringModuloHU/atendimentocra/transferencia/convenio/delete';

  static final incluirEquipeTransporte = '$_rootSpringModuloHU/atendimentocra/transferencia/equipetransporte/create';
  static final listarEquipeTransporte = '$_rootSpringModuloHU/atendimentocra/transferencia/equipetransporte/list';
  static final alterarEquipeTransporte = '$_rootSpringModuloHU/atendimentocra/transferencia/equipetransporte/update';
  static final excluirEquipeTransporte = '$_rootSpringModuloHU/atendimentocra/transferencia/equipetransporte/delete';

  static final incluirMeioTransporte = '$_rootSpringModuloHU/atendimentocra/transferencia/meiotransporte/create';
  static final listarMeioTransporte = '$_rootSpringModuloHU/atendimentocra/transferencia/meiotransporte/list';
  static final alterarMeioTransporte = '$_rootSpringModuloHU/atendimentocra/transferencia/meiotransporte/update';
  static final excluirMeioTransporte = '$_rootSpringModuloHU/atendimentocra/transferencia/meiotransporte/delete';

  static final incluirMotivo = '$_rootSpringModuloHU/atendimentocra/transferencia/motivo/create';
  static final listarMotivo = '$_rootSpringModuloHU/atendimentocra/transferencia/motivo/list';
  static final alterarMotivo = '$_rootSpringModuloHU/atendimentocra/transferencia/motivo/update';
  static final excluirMotivo = '$_rootSpringModuloHU/atendimentocra/transferencia/motivo/delete';

  static final incluirMotivoNaoAtendida = '$_rootSpringModuloHU/atendimentocra/transferencia/motivonaoatendida/create';
  static final listarMotivoNaoAtendida = '$_rootSpringModuloHU/atendimentocra/transferencia/motivonaoatendida/list';
  static final alterarMotivoNaoAtendida = '$_rootSpringModuloHU/atendimentocra/transferencia/motivonaoatendida/update';
  static final excluirMotivoNaoAtendida = '$_rootSpringModuloHU/atendimentocra/transferencia/motivonaoatendida/delete';

  static final incluirMotivoRejeitado = '$_rootSpringModuloHU/atendimentocra/transferencia/motivorejeitado/create';
  static final listarMotivoRejeitado = '$_rootSpringModuloHU/atendimentocra/transferencia/motivorejeitado/list';
  static final alterarMotivoRejeitado = '$_rootSpringModuloHU/atendimentocra/transferencia/motivorejeitado/update';
  static final excluirMotivoRejeitado = '$_rootSpringModuloHU/atendimentocra/transferencia/motivorejeitado/delete';

  static final incluirMotivoSolicitacao = '$_rootSpringModuloHU/atendimentocra/transferencia/motivosolicitacao/create';
  static final listarMotivoSolicitacao = '$_rootSpringModuloHU/atendimentocra/transferencia/motivosolicitacao/list';
  static final alterarMotivoSolicitacao = '$_rootSpringModuloHU/atendimentocra/transferencia/motivosolicitacao/update';
  static final excluirMotivoSolicitacao = '$_rootSpringModuloHU/atendimentocra/transferencia/motivosolicitacao/delete';

  static final incluirPrecaucao = '$_rootSpringModuloHU/atendimentocra/transferencia/precaucao/create';
  static final listarPrecaucao = '$_rootSpringModuloHU/atendimentocra/transferencia/precaucao/list';
  static final alterarPrecaucao = '$_rootSpringModuloHU/atendimentocra/transferencia/precaucao/update';
  static final excluirPrecaucao = '$_rootSpringModuloHU/atendimentocra/transferencia/precaucao/delete';

  static final incluirTipoInternacao = '$_rootSpringModuloHU/atendimentocra/transferencia/tipointernacao/create';
  static final listarTipoInternacao = '$_rootSpringModuloHU/atendimentocra/transferencia/tipointernacao/list';
  static final alterarTipoInternacao = '$_rootSpringModuloHU/atendimentocra/transferencia/tipointernacao/update';
  static final excluirTipoInternacao = '$_rootSpringModuloHU/atendimentocra/transferencia/tipointernacao/delete';

  //* SELETORES
  static final listarPrestadorServico = '$_rootSpringModuloCardio/prestadorservico/list';
  static final listarBeneficiario = '$_rootSpringModuloCardio/beneficiario/list';
  static final listarResponsavel = '$_rootSpringModuloCommon/usuario/list';

  //* PESSOA
  static final validarPessoaCpf = '$_rootSpringModuloCommon/pessoa/findByCpf';
  static final carregarTelefonePessoa = '$_rootSpringModuloCardio/pessoa/telefone/findByPessoa';
  static final listarPessoa = '$_rootSpringModuloCommon/pessoa/list';
  static final incluirPessoa = '$_rootSpringModuloCommon/pessoa/actions/generateDefault';

  //* CONTRATO
  static final carregarInformacoesContrato = '$_rootSpringModuloCardio/contrato/actions/getInfo';
  static final carregarInformacoesCoberturas = '$_rootSpringModuloCardio/contrato/cobertura/actions/getInfo';
  static final carregarInformacoesModuloBeneficiario = '$_rootSpringModuloCardio/modulobeneficiario/actions/getInfo';
}
