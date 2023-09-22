import 'package:flutter/material.dart';
import 'package:flutter_image/flutter_image.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lib/app/shared/models/local_model.dart';
import 'package:lib/app/shared/theme/theme_color.dart';
import 'package:skeletons/skeletons.dart';

import '../../../shared/formatters/formatters.dart';
import '../../../shared/utils/widgets/appbar_default.dart';

class TodosLocaisPage extends StatefulWidget {
  final String categoriaNome;
  final List<LocalModel> locais;
  const TodosLocaisPage({
    Key? key,
    required this.locais,
    required this.categoriaNome,
  }) : super(key: key);

  @override
  _TodosLocaisPageState createState() => _TodosLocaisPageState();
}

class _TodosLocaisPageState extends State<TodosLocaisPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDefault(),
      backgroundColor: ThemeColor.background,
      body: ListView(
        children: [
          Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10.0,
                  ),
                  child: Text(
                    '${widget.categoriaNome}:',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF434444),
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                _boxLocais(widget.locais)
              ]),
        ],
      ),
    );
  }

  Widget _boxLocais(List<LocalModel> state) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: state.length,
      itemBuilder: (_, i) {
        final local = state[i];
        return GestureDetector(
          onTap: () => Modular.to
              .pushNamed('/home/local', arguments: {'local': state[i]}),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                Card(
                  color: ThemeColor.colorTitleWhite,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 90,
                        width: 90,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            10.0,
                          ),
                          color: ThemeColor.colorTitleWhite,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.network(
                            local.img!,
                            fit: BoxFit.cover,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Container(
                                height: 90,
                                width: 90,
                                child: Center(
                                  child: SkeletonAvatar(
                                    style: SkeletonAvatarStyle(
                                      shape: BoxShape.rectangle,
                                      height: 100,
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
                                height: 90,
                                width: 90,
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
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              local.nome.toString(),
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                              style: TextStyle(
                                fontSize: 20,
                                color: ThemeColor.colorGrey,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 15),
                            Text(
                              Formatters.ConcatComVirgula(
                                  local.endereco ?? '', local.numero ?? ''),
                              style: TextStyle(
                                color: ThemeColor.colorGrey,
                                fontWeight: FontWeight.w100,
                                fontSize: 11,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              Formatters.ConcatComVirgula(
                                  local.bairro ?? '', local.cidade ?? ''),
                              style: TextStyle(
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15),
              ],
            ),
          ),
        );
      },
    );
  }
}
