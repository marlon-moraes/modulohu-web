# seletor_cidade_por_uf

Widget Flutter para seleção de cidades brasileiras a partir do estado (UF), com busca assíncrona integrada à API do IBGE.

## Visão Geral

O SeletorCidadePorUf é um widget reutilizável que permite ao usuário selecionar um estado brasileiro e, em seguida, escolher uma cidade pertencente ao estado selecionado. Ele utiliza dropdowns com busca, tornando a experiência de seleção rápida e intuitiva, mesmo com grandes listas.

- Busca assíncrona de estados e cidades via API do IBGE
- Dropdowns com busca por nome ou sigla (estado) e nome (cidade)
- Seleção de cidade habilitada apenas após seleção do estado
- Reset automático da cidade ao trocar o estado
- Fácil integração em formulários Flutter

## Detalhes Técnicos

- Utiliza o pacote dropdown_search para os campos de seleção.
- Os dados de estados e cidades são obtidos de forma assíncrona via API do IBGE.
- O campo de cidade é resetado automaticamente ao trocar o estado.
- Permite busca por nome ou sigla nos estados e por nome nas cidades.

## Licença

MIT