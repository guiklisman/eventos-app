import 'package:flutter/material.dart';
import 'package:flutter_image/flutter_image.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:lib/app/shared/formatters/formatters.dart';
import 'package:lib/app/shared/models/evento_model.dart';
import 'package:lib/app/shared/models/local_model.dart';
import 'package:lib/app/shared/utils/widgets/appbar_default.dart';
import 'package:screenshot/screenshot.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../shared/stores/local_por_id_store.dart';
import '../../../shared/theme/theme_color.dart';

class EventoPage extends StatefulWidget {
  final String? idLocal;
  final EventoModel? evento;
  final String? titulo;

  EventoPage({Key? key, this.idLocal, this.titulo, this.evento})
      : super(key: key);

  @override
  State<EventoPage> createState() => _EventoPageState();
}

class _EventoPageState extends State<EventoPage> {
  final LocalPorIdStore storeLocalPorId = Modular.get();
  ScreenshotController screenshotController = ScreenshotController();
  @override
  void initState() {
    storeLocalPorId.localporId(widget.idLocal!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColor.background,
      appBar: AppBarDefault(),
      body: ScopedBuilder<LocalPorIdStore, Exception, LocalModel>(
          store: storeLocalPorId,
          onLoading: (context) => const Center(
                child: CircularProgressIndicator(),
              ),
          onError: (context, err) => Scaffold(
                body: Center(
                  child: Text('Ocorreu um erro ao carregar os dados'),
                ),
              ),
          onState: (context, state) {
            return Screenshot(
              controller: screenshotController,
              child: ListView(
                children: [
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 40),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                                color: ThemeColor.destaqueColor,
                              ),
                              child: ListView(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                children: [
                                  SizedBox(
                                    height: 80,
                                  ),

                                  _padding(
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.2),
                                            spreadRadius: 1,
                                            blurRadius: 2,
                                            offset: Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        child: Image.network(
                                          widget.evento!.imgEvento!,
                                          fit: BoxFit.cover,
                                          loadingBuilder: (BuildContext context,
                                              Widget child,
                                              ImageChunkEvent?
                                                  loadingProgress) {
                                            if (loadingProgress == null)
                                              return child;
                                            return Center(
                                                child:
                                                    CircularProgressIndicator());
                                          },
                                          errorBuilder: (BuildContext context,
                                              Object error,
                                              StackTrace? stackTrace) {
                                            // Implemente a lógica para lidar com o erro aqui
                                            // Por exemplo, exibir uma mensagem de erro ou tentar novamente
                                            print(
                                                'Erro ao carregar imagem: $error');
                                            return Container(
                                              color: Colors
                                                  .grey, // Cor de fundo para o erro
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
                                    pH: 25,
                                  ),

                                  _padding(
                                    Text(
                                      widget.evento!.nomeEvento!,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: ThemeColor.colorTitleWhite,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),

                                  _padding(
                                    _boxSobreEvento(),
                                  ),

                                  _padding(
                                    _boxInfoUteis(),
                                  ),
                                  _padding(
                                    _contats(state),
                                  ),
                                  _padding(
                                    buildDottedLine(),
                                    pH: 0,
                                    pV: 25,
                                  ),

                                  _boxEndereco(state),
                                  // _boxBotao(),
                                  SizedBox(
                                    height: 80,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: 90,
                            height: 90,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
    );
  }

  String formatarData(String data) {
    return DateFormat("dd/MM/yyyy").format(DateTime.parse(data));
  }

  Widget _boxSobreEvento() {
    return widget.evento!.descricaoEvento! != ''
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Sobre o evento:',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 18,
                  color: ThemeColor.colorTitleWhite,
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.underline,
                ),
              ),
              _padding(_boxHorarios(), pH: 0, pV: 10),
              Text(
                widget.evento!.descricaoEvento!,
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 15,
                  color: ThemeColor.colorTitleWhite,
                ),
              ),
            ],
          )
        : SizedBox();
  }

  Widget _boxInfoUteis() {
    final String? infoUteis = widget.evento?.infoUteis;

    if (infoUteis != null && infoUteis.isNotEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Informações Úteis:',
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 18,
              color: ThemeColor.colorTitleWhite,
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.underline,
            ),
          ),
          SizedBox(height: 15),
          Text(
            infoUteis,
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontSize: 15,
              color: ThemeColor.colorTitleWhite,
            ),
          ),
        ],
      );
    } else {
      return SizedBox();
    }
  }

  Widget _contats(LocalModel local) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RowContato(
          icon: FontAwesomeIcons.whatsapp,
          colorsIcon: ThemeColor.colorTitleWhite,
          text: local.whatsapp,
          onTap: () {
            print(
              local.whatsapp!
                  .replaceAll("(", "")
                  .replaceAll(")", "")
                  .replaceAll("-", "")
                  .replaceAll(" ", ""),
            );
            launchUrl(
              Uri.parse(
                'https://wa.me/55' +
                    local.whatsapp!
                        .replaceAll("(", "")
                        .replaceAll(")", "")
                        .replaceAll("-", "")
                        .replaceAll(" ", ""),
              ),
            );
          },
        ),
        SizedBox(
          height: 4,
        ),
        RowContato(
          icon: FontAwesomeIcons.instagram,
          colorsIcon: ThemeColor.colorTitleWhite,
          text: local.instagram,
          onTap: () => launchUrl(
            Uri.parse(
              'https://www.instagram.com/' + local.instagram!,
            ),
          ),
        ),
      ],
    );
  }

  Widget _boxHorarios() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        widget.evento?.dataEvento != ''
            ? Text(
                'Data: ${formatarData(widget.evento!.dataEvento!)}',
                style: TextStyle(color: ThemeColor.colorTitleWhite),
              )
            : SizedBox(),
        SizedBox(
          height: widget.evento?.dataEvento != '' ? 5 : 0,
        ),
        widget.evento?.inicioEvento != ''
            ? Text(
                'Início: ${widget.evento!.inicioEvento!}',
                style: TextStyle(color: ThemeColor.colorTitleWhite),
              )
            : SizedBox(),
        SizedBox(
          height: widget.evento?.dataEvento != '' ? 5 : 0,
        ),
        widget.evento?.terminoEvento != ''
            ? Text(
                'Fim: ${widget.evento!.terminoEvento}',
                style: TextStyle(color: ThemeColor.colorTitleWhite),
              )
            : SizedBox(),
      ],
    );
  }

  Widget _boxEndereco(LocalModel local) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          ' ${local.nome ?? ''}',
          style: TextStyle(
            color: ThemeColor.colorTitleWhite,
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          Formatters.ConcatComVirgula(
              Formatters.ConcatComVirgula(local.endereco, local.numero),
              Formatters.ConcatComTraco(local.complemento, local.bairro)),
          style: TextStyle(color: ThemeColor.colorTitleWhite),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          ' ${local.cidade ?? ''}',
          style: TextStyle(color: ThemeColor.colorTitleWhite),
        ),
      ],
    );
  }

  Widget _boxBotao() {
    if ((widget.evento!.nomeBotao != null &&
            widget.evento!.nomeBotao!.isNotEmpty) &&
        (widget.evento!.siteEvento != null &&
            widget.evento!.siteEvento!.isNotEmpty)) {
      return MaterialButton(
        height: 40.0,
        minWidth: 20,
        color: ThemeColor.colorTitleWhite,
        child: Text(
          widget.evento!.nomeBotao!,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: ThemeColor.colorTitleBlack,
          ),
        ),
        onPressed: () async {
          if (widget.evento!.siteEvento!.startsWith('http://') ||
              widget.evento!.siteEvento!.startsWith('https://')) {
            launchUrl(
              Uri.parse(widget.evento!.siteEvento!),
            );
          } else {
            launchUrl(Uri.parse('https://' + widget.evento!.siteEvento!));
          }
        },
        splashColor: Colors.redAccent,
      );
    } else {
      return SizedBox();
    }
  }

  Widget buildDottedLine() {
    return Row(
      children: [
        Expanded(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 5,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 100,
                  itemBuilder: (context, index) {
                    return Container(
                      width: 20,
                      height: 20,
                      margin: EdgeInsets.only(right: 4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    );
                  },
                ),
              ),
              _boxBotao(),
            ],
          ),
        ),
      ],
    );
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
          FaIcon(
            icon,
            color: colorsIcon,
            size: 18,
          ),
          SizedBox(
            width: 15,
          ),
          Text(
            text,
            textAlign: TextAlign.center,
            softWrap: true,
            style: TextStyle(
              fontSize: 15,
              color: ThemeColor.colorTitleWhite,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _padding(
    Widget widget, {
    double pH = 15,
    double pV = 5,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: pH, vertical: pV),
      child: widget,
    );
  }
}
