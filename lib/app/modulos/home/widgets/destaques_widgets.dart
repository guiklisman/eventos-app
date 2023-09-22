import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lib/app/shared/models/evento_model.dart';
import 'package:lib/app/shared/theme/theme.dart';

import '../../../shared/utils/widgets/card_locais_vertical_widget.dart';

class DestaquesWidget extends StatefulWidget {
  final List<EventoModel> proximosEventos;
  const DestaquesWidget({super.key, required this.proximosEventos});

  @override
  State<DestaquesWidget> createState() => _DestaquesWidgetState();
}

class _DestaquesWidgetState extends State<DestaquesWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      color: ThemeColor.destaqueColor,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: SizedBox(
              height: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 15.0,
                    ),
                    child: Text(
                      'Eventos Próximos',
                      style: TextStyle(
                        fontSize: 15,
                        color: ThemeColor.colorTitleWhite,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => Modular.to.pushNamed('/lista-evento',
                          arguments: widget.proximosEventos),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 0),
                        child: SizedBox(
                          width: 50,
                          child: Icon(
                            Icons.arrow_forward_sharp,
                            color: ThemeColor.background,
                            size: 22,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: widget.proximosEventos.length,
              itemBuilder: (context, index) {
                return CardLocaisVerticalWidget(
                  proximosEventos: widget.proximosEventos[index],
                  callback: () async {
                    return Modular.to.pushNamed('/home/evento', arguments: {
                      'evento': widget.proximosEventos[index],
                      'local': widget.proximosEventos[index].idLocal.toString(),
                    });
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
