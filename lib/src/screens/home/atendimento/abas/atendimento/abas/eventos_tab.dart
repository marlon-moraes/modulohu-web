// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:modulohu_web/src/components/components.dart';
import 'package:modulohu_web/src/models/atendimento.dart';
import 'package:modulohu_web/src/models/evento.dart';
import 'package:modulohu_web/src/services/api/req/evento_req.dart';

class EventosTab extends StatefulWidget {
  final Atendimento atendimentoCarregado;

  const EventosTab({super.key, required this.atendimentoCarregado});

  @override
  State<EventosTab> createState() => _EventosTabState();
}

class _EventosTabState extends State<EventosTab> {
  final scrollController = ScrollController();
  List<Evento> eventos = [];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scrollbar(
      controller: scrollController,
      thumbVisibility: true,
      radius: Radius.zero,
      interactive: true,
      child: ListView.builder(
        itemCount: eventos.length,
        controller: scrollController,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          Evento item = eventos[index];
          return Container(
            padding: const EdgeInsets.only(right: 12),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Card(
                color: index.isEven ? theme.colorScheme.secondary.withValues(alpha: 0.3) : null,
                margin: const EdgeInsets.all(4),
                clipBehavior: Clip.antiAlias,
                child: IntrinsicWidth(
                  child: Container(
                    color: index.isEven ? theme.colorScheme.secondary.withValues(alpha: 0.3) : null,
                    padding: const EdgeInsets.all(4),
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      alignment: WrapAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                dateFormatter(item.dtInc ?? ''),
                                style: const TextStyle(fontWeight: FontWeight.bold),
                                overflow: TextOverflow.clip,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                item.titulo ?? '',
                                style: const TextStyle(fontWeight: FontWeight.bold),
                                overflow: TextOverflow.clip,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                item.usuario ?? '',
                                style: const TextStyle(fontWeight: FontWeight.bold),
                                overflow: TextOverflow.clip,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                        Text('\n${item.descricao ?? ""}', overflow: TextOverflow.clip, textAlign: TextAlign.justify),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _carregarEventos();
  }

  Future<void> _carregarEventos() async {
    if (widget.atendimentoCarregado.id != null) {
      var res = await reqListarEvento(widget.atendimentoCarregado.id ?? '', context);
      setState(() => eventos = res);
    }
  }
}
