import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lib/app/modulos/home/store_controller.dart';
import 'package:lib/app/shared/formatters/formatters.dart';
import 'package:lib/app/shared/models/evento_model.dart';
import 'package:lib/app/shared/models/local_model.dart';
import 'package:lib/app/shared/stores/evento_store.dart';
import 'package:lib/app/shared/utils/widgets/appbar_default.dart';
import 'package:skeletons/skeletons.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../shared/theme/theme_color.dart';

class PerfilEstabelecimentoPage extends StatefulWidget {
  final LocalModel? local;
  final String? titulo;

  PerfilEstabelecimentoPage({Key? key, this.local, this.titulo})
      : super(key: key);

  @override
  State<PerfilEstabelecimentoPage> createState() =>
      _PerfilEstabelecimentoPageState();
}

class _PerfilEstabelecimentoPageState extends State<PerfilEstabelecimentoPage> {
  final StoreController controller = Modular.get();
  final EventoStore storeEvento = Modular.get();
  @override
  void initState() {
    storeEvento.eventosAtivosLocal(widget.local!.idLocal!.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDefault(),
      body: ScopedBuilder<EventoStore, Exception, List<EventoModel>>(
        store: storeEvento,
        onLoading: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
        onError: (context, err) => Scaffold(
          body: Center(
            child: Text('Ocorreu um erro ao carregar os dados'),
          ),
        ),
        onState: (context, state) {
          print(state);
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 10,
            ),
            child: ListView(
              children: [
                _header(),
                SizedBox(
                  height: 15,
                ),
                Divider(),
                _boxEndereco(),
                SizedBox(
                  height: 15,
                ),
                _boxHorarios(),
                Divider(),
                SizedBox(
                  height: 15,
                ),
                _boxInformacoes(),
                SizedBox(
                  height: 15,
                ),
                _boxNossosEventos(state),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
          child: Image.network(
            widget.local!.img!,
            height: 170,
            width: 170,
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) return child;
              return Container(
                height: 170,
                width: 170,
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
            errorBuilder:
                (BuildContext context, Object error, StackTrace? stackTrace) {
              // Implemente a lógica para lidar com o erro aqui
              // Por exemplo, exibir uma mensagem de erro ou tentar novamente
              print('Erro ao carregar imagem: $error');
              return Container(
                height: 170,
                width: 170,
                color: Colors.grey, // Cor de fundo para o erro
                child: Center(
                  child: Text(
                    'Falha ao carregar imagem',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(
          width: 15,
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.local!.nome!,
                textAlign: TextAlign.start,
                softWrap: true,
                style: TextStyle(
                  fontSize: 25,
                  color: ThemeColor.colorGrey,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              RowContato(
                icon: FontAwesomeIcons.whatsapp,
                colorsIcon: Color(0xFF0DC143),
                text: widget.local!.whatsapp,
                onTap: () => launch(
                  kIsWeb
                      ? 'https://wa.me/55${widget.local!.whatsapp!.replaceAll("(", "").replaceAll(")", "").replaceAll("-", "").replaceAll(" ", "")}'
                      : 'whatsapp://send?phone=+55${widget.local!.whatsapp!.replaceAll("(", "").replaceAll(")", "").replaceAll("-", "").replaceAll(" ", "")}',
                ),
              ),
              SizedBox(
                height: 4,
              ),
              RowContato(
                icon: FontAwesomeIcons.instagram,
                colorsIcon: Color.fromARGB(255, 221, 42, 123),
                text: widget.local!.instagram!,
                onTap: () => launch(
                  'https://www.instagram.com/' +
                      widget.local!.instagram!.trim(),
                ),
              ),
              SizedBox(
                height: 4,
              ),
              RowContato(
                icon: Icons.call_rounded,
                colorsIcon: Color.fromARGB(255, 255, 123, 0),
                text: widget.local!.telefone!,
                onTap: () => launchUrl(
                  Uri(
                    scheme: 'tel',
                    path: widget.local!.telefone!
                        .replaceAll("(", "")
                        .replaceAll(")", "")
                        .replaceAll("-", "")
                        .trim(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _boxEndereco() {
    return Row(
      children: [
        Card(
          color: Colors.white,
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: SizedBox(
            height: 70,
            width: 70,
            child: Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Icon(
                      Icons.location_pin,
                      color: Colors.red,
                      size: 40,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              Formatters.ConcatComVirgula(
                  widget.local!.endereco, widget.local!.numero),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              Formatters.ConcatComTraco(
                  widget.local!.complemento, widget.local!.bairro),
            ),
          ],
        ),
        Divider(),
      ],
    );
  }

  Widget _boxHorarios() {
    bool hasHorarios = false;

    if (widget.local != null) {
      hasHorarios = (widget.local!.abreSegunda != null &&
              widget.local!.abreSegunda != '') ||
          (widget.local!.fechaSegunda != null &&
              widget.local!.fechaSegunda != '') ||
          (widget.local!.abreTerca != null && widget.local!.abreTerca != '') ||
          (widget.local!.fechaTerca != null &&
              widget.local!.fechaTerca != '') ||
          (widget.local!.abreQuarta != null &&
              widget.local!.abreQuarta != '') ||
          (widget.local!.fechaQuarta != null &&
              widget.local!.fechaQuarta != '') ||
          (widget.local!.abreQuinta != null &&
              widget.local!.abreQuinta != '') ||
          (widget.local!.fechaQuinta != null &&
              widget.local!.fechaQuinta != '') ||
          (widget.local!.abreSexta != null && widget.local!.abreSexta != '') ||
          (widget.local!.fechaSexta != null &&
              widget.local!.fechaSexta != '') ||
          (widget.local!.abreSabado != null &&
              widget.local!.abreSabado != '') ||
          (widget.local!.fechaSabado != null &&
              widget.local!.fechaSabado != '') ||
          (widget.local!.abreDomingo != null &&
              widget.local!.abreDomingo != '') ||
          (widget.local!.fechaDomingo != null &&
              widget.local!.fechaDomingo != '');
    }
    if (!hasHorarios) {
      return SizedBox();
    }

    return Row(
      children: [
        Card(
          color: Colors.white,
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: SizedBox(
            height: contarDiasHorarios(widget.local!),
            width: 70,
            child: Center(
              child: Icon(
                Icons.access_time_rounded,
                color: Colors.green,
                size: 40,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            HorariosAbertos(
              'Segunda-Feira',
              widget.local!.abreSegunda,
              widget.local!.fechaSegunda,
            ),
            HorariosAbertos(
              'Terça-Feira',
              widget.local!.abreTerca,
              widget.local!.fechaTerca,
            ),
            HorariosAbertos(
              'Quarta-Feira',
              widget.local!.abreQuarta,
              widget.local!.fechaQuarta,
            ),
            HorariosAbertos(
              'Quinta-Feira',
              widget.local!.abreQuinta,
              widget.local!.fechaQuinta,
            ),
            HorariosAbertos(
              'Sexta-feira',
              widget.local!.abreSexta,
              widget.local!.fechaSexta,
            ),
            HorariosAbertos(
              'Sábado',
              widget.local!.abreSabado,
              widget.local!.fechaSabado,
            ),
            HorariosAbertos(
              'Domingo',
              widget.local!.abreDomingo,
              widget.local!.fechaDomingo,
            ),
          ],
        ),
      ],
    );
  }

  Widget _boxInformacoes() {
    final informacoes = widget.local?.informacoes;
    final hasInformacoes = informacoes != null && informacoes.isNotEmpty;
    if (hasInformacoes) {
      return Container(
        decoration: BoxDecoration(
          color: ThemeColor.destaqueColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (hasInformacoes)
                Container(
                  decoration: BoxDecoration(
                    color: ThemeColor.destaqueColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'Informações:',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 22,
                      color: ThemeColor.colorTitleWhite,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              SizedBox(
                height: 10,
              ),
              if (hasInformacoes)
                Container(
                  decoration: BoxDecoration(
                    color: ThemeColor.destaqueColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    informacoes,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 16,
                      color: ThemeColor.colorTitleWhite,
                    ),
                  ),
                ),
            ],
          ),
        ),
      );
    } else
      return SizedBox();
  }

  Widget _boxNossosEventos(List<EventoModel> state) {
    final hasEventos = state.isNotEmpty;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (hasEventos)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Nossos Eventos:',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 22,
                color: ThemeColor.colorGrey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ListView.builder(
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
              child: Column(
                children: [
                  Card(
                    color: ThemeColor.bigCard,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 90,
                          width: 90,
                          color: ThemeColor.bigCard,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.network(
                              evento.imgEvento!,
                              fit: BoxFit.fitHeight,
                              loadingBuilder: (BuildContext context,
                                  Widget child,
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
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  Icon(Icons.watch_later_outlined,
                                      size: 15, color: Colors.green),
                                  SizedBox(width: 5),
                                  Text(
                                    state[i].inicioEvento!,
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
            );
          },
        ),
      ],
    );
  }

  double contarDiasHorarios(LocalModel local) {
    int auxCount = 0;
    double height = 66;

    if ([local.abreSegunda, local.fechaSegunda]
        .any((value) => value != null && value.isNotEmpty)) {
      auxCount++;
    }
    if ([local.abreTerca, local.fechaTerca]
        .any((value) => value != null && value.isNotEmpty)) {
      auxCount++;
    }
    if ([local.abreQuarta, local.fechaQuarta]
        .any((value) => value != null && value.isNotEmpty)) {
      auxCount++;
    }
    if ([local.abreQuinta, local.fechaQuinta]
        .any((value) => value != null && value.isNotEmpty)) {
      auxCount++;
    }
    if ([local.abreSexta, local.fechaSexta]
        .any((value) => value != null && value.isNotEmpty)) {
      auxCount++;
    }
    if ([local.abreSabado, local.fechaSabado]
        .any((value) => value != null && value.isNotEmpty)) {
      auxCount++;
    }
    if ([local.abreDomingo, local.fechaDomingo]
        .any((value) => value != null && value.isNotEmpty)) {
      auxCount++;
    }

    if (auxCount > 2) {
      height = auxCount * 21;
    }

    return height;
  }

  Widget HorariosAbertos(
    String? diaSemana,
    String? horarioAbre,
    String? horarioFecha,
  ) {
    if (horarioAbre != null &&
        horarioFecha != null &&
        horarioAbre.isNotEmpty &&
        horarioFecha.isNotEmpty) {
      return Column(
        children: [
          Text('$diaSemana: $horarioAbre às $horarioFecha'),
          SizedBox(
            height: 5,
          ),
        ],
      );
    } else if ((horarioAbre == null || horarioAbre.isEmpty) &&
        (horarioFecha == null || horarioFecha.isEmpty)) {
      return SizedBox();
    } else {
      return SizedBox();
    }
  }

  Widget RowContato({
    IconData? icon,
    Color? colorsIcon,
    String? text,
    VoidCallback? onTap,
  }) {
    if (text == null || text.isEmpty) {
      return SizedBox
          .shrink(); // Retorna um widget vazio se o texto for nulo ou vazio
    }

    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: FaIcon(
              icon,
              color: colorsIcon,
              size: 18,
            ),
          ),
          SizedBox(
            width: 15,
          ),
          Text(
            text,
            textAlign: TextAlign.center,
            softWrap: true,
            style: TextStyle(
              fontSize: 14,
              color: ThemeColor.colorGrey,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
