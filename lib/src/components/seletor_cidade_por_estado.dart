// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:dropdown_search/dropdown_search.dart';

// 🌎 Project imports:
import 'package:modulohu_web/src/models/cidade.dart';
import 'package:modulohu_web/src/models/estado.dart';
import 'package:modulohu_web/src/services/api/ibge_serv.dart';

/// Widget para seleção de cidade baseada no estado (UF).
///
/// O widget [SeletorCidadePorEstado] permite ao usuário selecionar um estado brasileiro
/// e, em seguida, escolher uma cidade pertencente ao estado selecionado. Utiliza
/// dropdowns com busca assíncrona, integrando-se à API do IBGE para obter os dados.
///
/// ## Funcionamento:
/// - O usuário seleciona um estado (UF) em um dropdown com busca.
/// - Após selecionar o estado, o dropdown de cidades é habilitado e exibe apenas as cidades
///   pertencentes ao estado selecionado.
/// - Ao trocar o estado, a seleção de cidade é limpa automaticamente.
///
/// ## Parâmetros:
/// Este widget não recebe parâmetros no construtor.
///
/// ## Exemplo de Uso:
/// ```dart
/// SeletorCidadePorEstado()
/// ```
///
/// ## Uso:
/// Este widget pode ser utilizado em formulários ou telas onde é necessário
/// que o usuário selecione uma cidade a partir de um estado brasileiro.
/// É útil para cadastros, filtros e buscas geográficas.
///
/// ## Detalhes Técnicos:
/// - Utiliza o pacote [dropdown_search] para os campos de seleção.
/// - Os dados de estados e cidades são obtidos de forma assíncrona via [IBGEService].
/// - O campo de cidade é zerado automaticamente ao trocar o estado.
/// - Permite busca por nome ou sigla nos estados e por nome nas cidades.
class SeletorCidadePorEstado extends StatefulWidget {
  const SeletorCidadePorEstado({super.key});

  @override
  State<SeletorCidadePorEstado> createState() => _SeletorCidadePorEstadoState();
}

class _SeletorCidadePorEstadoState extends State<SeletorCidadePorEstado> {
  final IBGEService _ibgeService = IBGEService();

  // Variáveis para armazenar os itens selecionados
  Estado? _estadoSelecionado;
  Cidade? _cidadeSelecionada;

  // Chave para resetar o seletor de cidade quando o estado muda
  final GlobalKey<DropdownSearchState<Cidade>> _cidadeDropdownKey = GlobalKey<DropdownSearchState<Cidade>>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Dropdown com busca para Estados (UF)
        Container(
          margin: EdgeInsetsDirectional.symmetric(horizontal: 8, vertical: 4),
          child: DropdownSearch<Estado>(
            // Configurações do Popup
            popupProps: PopupProps.menu(
              searchFieldProps: TextFieldProps(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(8),
                  labelText: 'Pesquisar Estado',
                  border: OutlineInputBorder(),
                  isDense: true,
                ),
                autofocus: true,
              ),
              itemBuilder: (context, estado, isSelected) => ListTile(title: Text(estado.nome), subtitle: Text(estado.sigla)),
              showSearchBox: true,
            ),
            // Filtro personalizado para buscar por nome ou sigla em lowercase
            filterFn: (item, filter) {
              final nomeNormalizado = item.nome.toLowerCase();
              final siglaNormalizada = item.sigla.toLowerCase();
              final filtroNormalizado = filter.toLowerCase();
              return nomeNormalizado.contains(filtroNormalizado) || siglaNormalizada.contains(filtroNormalizado);
            },
            // Busca os itens de forma assíncrona direto da API
            asyncItems: (String filter) => _ibgeService.fetchEstados(),
            // Define como o nome do item será exibido no campo
            itemAsString: (Estado estado) => estado.nome,
            // Define como comparar os itens para encontrar o selecionado
            compareFn: (a, b) => a.id == b.id,
            // Decoração do campo
            dropdownDecoratorProps: const DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                contentPadding: EdgeInsets.all(8),
                hintText: 'Selecione um estado',
                border: OutlineInputBorder(),
                labelText: 'Estado (UF)',
                isDense: true,
              ),
            ),
            // Item selecionado atualmente
            selectedItem: _estadoSelecionado,
            // Ação ao mudar a seleção
            onChanged: (Estado? novoEstado) {
              if (novoEstado != null) {
                setState(() {
                  _estadoSelecionado = novoEstado;
                  // Limpa a seleção de cidade quando o estado muda
                  _cidadeSelecionada = null;
                  // Usa a chave para limpar a seleção visual no dropdown de cidade
                  _cidadeDropdownKey.currentState?.clear();
                });
              }
            },
          ),
        ),
        // Dropdown com busca para Cidades
        Container(
          margin: EdgeInsetsDirectional.symmetric(horizontal: 8, vertical: 4),
          child: DropdownSearch<Cidade>(
            // Associa a chave global
            key: _cidadeDropdownKey,
            // Habilita/desabilita o campo
            enabled: _estadoSelecionado != null,
            // Configurações do Popup com busca
            popupProps: const PopupProps.menu(
              searchFieldProps: TextFieldProps(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(8),
                  labelText: 'Pesquisar Cidade',
                  border: OutlineInputBorder(),
                  isDense: true,
                ),
                autofocus: true,
              ),
              showSearchBox: true,
            ),
            // Busca as cidades de forma assíncrona, dependendo do estado selecionado
            asyncItems: (String filter) {
              if (_estadoSelecionado == null) return Future.value([]); // Retorna lista vazia se nenhum estado foi selecionado
              return _ibgeService.fetchCidadesPorEstado(_estadoSelecionado!.id);
            },
            itemAsString: (Cidade cidade) => cidade.nome,
            compareFn: (a, b) => a.id == b.id,
            dropdownDecoratorProps: const DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                contentPadding: EdgeInsets.all(8),
                hintText: 'Selecione uma cidade',
                border: OutlineInputBorder(),
                labelText: 'Cidade',
                isDense: true,
              ),
            ),
            selectedItem: _cidadeSelecionada,
            onChanged: (Cidade? novaCidade) => setState(() => _cidadeSelecionada = novaCidade),
          ),
        ),
      ],
    );
  }
}
