import 'package:flutter/material.dart';
import 'package:lib/app/shared/formatters/formatters.dart';
import 'package:lib/app/shared/models/local_model.dart';
import 'package:lib/app/shared/theme/theme.dart';
import 'package:skeletons/skeletons.dart';

class CardLocaisHorizontalWidget extends StatelessWidget {
  final LocalModel local;
  final Function callback;
  const CardLocaisHorizontalWidget({
    super.key,
    required this.local,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 7),
      child: GestureDetector(
        onTap: () => callback(),
        child: Container(
          height: 75,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: ThemeColor.backgroundCard,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                spreadRadius: 1,
                blurRadius: 2,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 75,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10)),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    local.img!,
                    width: 75,
                    height: 75,
                    fit: BoxFit.fitHeight,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) return child;
                      return SizedBox(
                        width: 90,
                        height: 90,
                        child: Center(
                          child: SkeletonAvatar(
                            style: SkeletonAvatarStyle(
                              shape: BoxShape.rectangle,
                              width: 90,
                              height: 90,
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
                        width: 75,
                        height: 75,
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
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Flexible(
                        child: Text(
                          local.nome!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: ThemeColor.colorTitleBlack,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        Formatters.ConcatComVirgula(
                            local.endereco ?? '', local.numero ?? ''),
                        style: TextStyle(
                          fontSize: 10,
                        ),
                      ),
                      Text(
                        Formatters.ConcatComVirgula(
                            local.bairro ?? '', local.cidade ?? ''),
                        style: TextStyle(
                          fontSize: 10,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      // Center(
                      //   child: TextButtonWidget(
                      //     height: 25,
                      //     width: 80,
                      //     titleColor: ThemeColor.colorTitleWhite,
                      //     title: 'Ver mais',
                      //     fontSize: 12,
                      //     callback: () {
                      //       callback();
                      //     },
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
