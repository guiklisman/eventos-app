import 'package:flutter/material.dart';
import 'package:lib/app/shared/formatters/formatters.dart';
import 'package:lib/app/shared/models/evento_model.dart';
import 'package:lib/app/shared/theme/theme.dart';
import 'package:skeletons/skeletons.dart';

import 'text_button_widget.dart';

class CardLocaisVerticalWidget extends StatelessWidget {
  final Function callback;
  final EventoModel proximosEventos;
  const CardLocaisVerticalWidget(
      {super.key, required this.callback, required this.proximosEventos});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
      child: Container(
        width: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: ThemeColor.backgroundCard,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 1, // Raio de propagação da sombra
              blurRadius: 2, // Raio de desfoque da sombra
              offset:
                  Offset(0, 2), // Deslocamento da sombra em relação à imagem
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  height: 90,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10), // Raio das bordas
                    child: Image.network(
                      proximosEventos.imgEvento!,
                      height: 95,
                      width: 105,
                      fit: BoxFit.cover,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          height: 95,
                          width: 105,
                          color: Colors.white,
                          child: Center(
                            child: SkeletonAvatar(
                              style: SkeletonAvatarStyle(
                                shape: BoxShape.rectangle,
                                height: 95,
                                width: 105,
                              ),
                            ),
                          ),
                        );
                      },
                      errorBuilder: (BuildContext context, Object error,
                          StackTrace? stackTrace) {
                        // Implemente a lógica para lidar com o erro aqui
                        // Por exemplo, exibir uma mensagem de erro ou tentar novamente
                        print('Erro ao carregar imagem: $error');
                        return Container(
                          height: 95,
                          width: 105,
                          color: Colors.grey, // Cor de fundo para o erro
                          child: Center(
                            child: Text(
                              'Falha ao carregar imagem',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Text(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    proximosEventos.nomeEvento!,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 12,
                      color: ThemeColor.colorTitleBlack,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.location_pin,
                    size: 16,
                    color: Colors.red,
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  Flexible(
                    child: Text(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      proximosEventos.nomeLocal!,
                      style: TextStyle(
                        fontSize: 9,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.calendar_month_outlined,
                    color: Colors.green,
                    size: 16,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    Formatters.formatarData(proximosEventos.dataEvento!),
                    style: TextStyle(
                      fontSize: 9,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Center(
                child: TextButtonWidget(
                  height: 20,
                  width: 90,
                  titleColor: ThemeColor.colorTitleWhite,
                  title: 'Ver mais',
                  fontSize: 12,
                  callback: () => callback(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
