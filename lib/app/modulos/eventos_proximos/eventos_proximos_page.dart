import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lib/app/shared/theme/theme_color.dart';
import 'package:skeletons/skeletons.dart';

import '../../shared/formatters/formatters.dart';
import '../../shared/models/evento_model.dart';
import '../../shared/stores/evento_store.dart';
import '../../shared/utils/widgets/appbar_default.dart';
import '../home/store_controller.dart';

class EventosProximosPage extends StatefulWidget {
  final List<EventoModel> proximosEventos;
  const EventosProximosPage({
    Key? key,
    required this.proximosEventos,
  }) : super(key: key);

  @override
  _EventosProximosPageState createState() => _EventosProximosPageState();
}

class _EventosProximosPageState extends State<EventosProximosPage> {
  final StoreController controller = Modular.get();
  final EventoStore store = Modular.get();

  @override
  void initState() {
    controller.buscarProximosEventos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDefault(),
      backgroundColor: ThemeColor.background,
      body: ListView(shrinkWrap: true, children: <Widget>[
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 10.0,
          ),
          child: Text(
            'Eventos Próximos:',
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
        _boxNossosEventos(widget.proximosEventos)
      ]),
    );
  }

  Widget _boxNossosEventos(List<EventoModel> state) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: state.length,
      itemBuilder: (_, i) {
        final evento = state[i];
        return GestureDetector(
          onTap: () => Modular.to.pushNamed('/home/evento', arguments: {
            'evento': evento,
            'local': evento.idLocal.toString(),
          }),
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
                          borderRadius: BorderRadius.circular(10.0),
                          color: ThemeColor.colorTitleWhite,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.network(
                            evento.imgEvento!,
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
                      SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              evento.nomeEvento.toString(),
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                              style: TextStyle(
                                fontSize: 20,
                                color: ThemeColor.colorGrey,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.location_pin,
                                  size: 15,
                                  color: Colors.red,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  evento.nomeLocal!,
                                  style: TextStyle(
                                    color: ThemeColor.colorGrey,
                                    fontWeight: FontWeight.w100,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.calendar_month,
                                    size: 15,
                                    color: Color.fromARGB(255, 50, 180, 255)),
                                SizedBox(width: 5),
                                Text(
                                  Formatters.formatarData(evento.dataEvento!),
                                  style: TextStyle(
                                    color: ThemeColor.colorGrey,
                                    fontWeight: FontWeight.w100,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
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
