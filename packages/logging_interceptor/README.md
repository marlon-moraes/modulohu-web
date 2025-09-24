# logging_interceptor
Um interceptor HTTP para Flutter/Dart que registra requisições e respostas HTTP, facilitando a depuração e o monitoramento de chamadas de API.

## Visão Geral
O LoggingInterceptor implementa a interface InterceptorContract do pacote http_interceptor e utiliza o logger para registrar logs detalhados de todas as requisições e respostas HTTP realizadas pela aplicação.

- Log de requisições: URL, cabeçalhos, parâmetros (se disponível), método e corpo (se disponível).
- Log de respostas: URL, status code, cabeçalhos e corpo.
- Níveis de log diferenciados conforme o status da resposta (info, debug, warning, error).
- Útil para depuração, análise de problemas e auditoria de integrações.

## Níveis de Log

- 1xx (Informativo): logger.i
- 2xx (Sucesso): logger.d
- 3xx (Redirecionamento): logger.i
- 4xx (Erro do cliente): logger.e
- 5xx (Erro do servidor): logger.w

## Licença

MIT