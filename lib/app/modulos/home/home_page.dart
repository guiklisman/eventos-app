import 'package:asuka/asuka.dart' as Asuka;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image/flutter_image.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:lib/app/shared/models/banners_model.dart';
import 'package:lib/app/shared/models/categoria_model.dart';
import 'package:lib/app/shared/models/local_model.dart';
import 'package:lib/app/shared/models/story_model.dart';
import 'package:lib/app/shared/stores/local_store.dart';
import 'package:lib/app/shared/theme/theme_color.dart';
import 'package:lib/app/shared/utils/widgets/card_locais_horizontal_widget.dart';
import 'package:skeletons/skeletons.dart';
import 'package:story/story.dart';

import '../../shared/models/evento_model.dart';
import '../../shared/utils/widgets/appbar_default.dart';
import '../../shared/utils/widgets/text_button_widget.dart';
import '../menu/menu.dart';
import 'store_controller.dart';
import 'widgets/destaques_widgets.dart';

class HomePage extends StatefulWidget {
  final List<CategoriaModel> categoriasAtivas;
  final List<EventoModel> proximosEventos;
  final List<BannersModel> banners;
  final List<StoryModel> storys;
  HomePage({
    Key? key,
    required this.categoriasAtivas,
    required this.proximosEventos,
    required this.banners,
    required this.storys,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  StoreController storeController = Modular.get();
  RxNotifier<String> nomeCategoria = RxNotifier<String>('');
  LocalStore localStore = Modular.get();

  @override
  void initState() {
    _tabController =
        TabController(length: widget.categoriasAtivas.length, vsync: this);
    localStore.getLocalPorCategoria(
      widget.categoriasAtivas.first.idCategoria.toString(),
    );
    nomeCategoria.value = widget.categoriasAtivas.first.nomeCategoria!;

    super.initState();
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColor.background,
      appBar: AppBarDefault(),
      body: RefreshIndicator(
        onRefresh: () async {
          await storeController.getCategoriaAtivas();
          await storeController.buscarProximosEventos();
          await storeController.getBanners();
          await storeController.getStoryAtivo();
        },
        child: Column(
          children: [
            Visibility(
              visible: widget.storys.isNotEmpty,
              child: SizedBox(
                height: 105,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.storys.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 85,
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () => _story(widget.storys),
                              child: CircleAvatar(
                                backgroundColor: ThemeColor.destaqueColor,
                                radius: 32,
                                child: CircleAvatar(
                                  backgroundColor: ThemeColor.destaqueColor,
                                  radius: 30,
                                  backgroundImage: NetworkImage(
                                      widget.storys[index].imgLocal!),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Expanded(
                              child: Text(
                                widget.storys[index].nome!,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Visibility(
              visible: widget.proximosEventos.isEmpty,
              child: SizedBox(
                height: 15,
              ),
            ),
            Visibility(
              visible: widget.proximosEventos.isEmpty,
              child: CarouselSlider(
                  items: _listBanners(widget.banners),
                  options: CarouselOptions(
                    height: 170,
                    viewportFraction: 0.8,
                    enableInfiniteScroll: true,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 7),
                    autoPlayAnimationDuration: Duration(milliseconds: 3000),
                    autoPlayCurve: Curves.easeInOutCubicEmphasized,
                    enlargeCenterPage: true,
                    scrollDirection: Axis.horizontal,
                  )),
            ),
            SizedBox(
              height: 10,
            ),
            Visibility(
              visible: widget.proximosEventos.isNotEmpty,
              child: DestaquesWidget(proximosEventos: widget.proximosEventos),
            ),
            Column(
              children: [
                TabBar(
                  indicatorSize: TabBarIndicatorSize.tab,
                  isScrollable: true,
                  indicatorPadding: EdgeInsets.symmetric(horizontal: 10.0),
                  // Espaçamento interno da divisão
                  indicator: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: ThemeColor.destaqueColor, // Cor da divisão
                        width: 2.5, // Espessura da divisão
                      ),
                    ),
                  ),
                  enableFeedback: true,
                  unselectedLabelColor: Colors.grey,
                  controller: _tabController,
                  tabs: buildTabBar(widget.categoriasAtivas),
                  labelStyle: TextStyle(fontSize: 15),
                  automaticIndicatorColorAdjustment: true,
                  onTap: (index) {
                    localStore.getLocalPorCategoria(
                        widget.categoriasAtivas[index].idCategoria.toString());
                    nomeCategoria.value =
                        widget.categoriasAtivas[index].nomeCategoria!;
                  },
                ),
              ],
            ),
            ScopedBuilder<LocalStore, Exception, List<LocalModel>>(
              store: Modular.get<LocalStore>(),
              onLoading: (context) => Flexible(
                child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Flexible(
                            child: SkeletonAvatar(
                              style: SkeletonAvatarStyle(
                                shape: BoxShape.rectangle,
                                height: 80,
                                width: 80,
                              ),
                            ),
                          ),
                          SkeletonParagraph(
                            style: SkeletonParagraphStyle(
                              lines: 3,
                              lineStyle: SkeletonLineStyle(
                                height: 15,
                                width: MediaQuery.of(context).size.width / 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              onState: (_, state) {
                if (state.isEmpty) {
                  return Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                            'Essa categoria ainda não possui estabelecimentos!'),
                      ],
                    ),
                  );
                }
                return Expanded(
                  child: TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    controller: _tabController,
                    children:
                        buildTabBarView(state, widget.categoriasAtivas.length),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      drawer: MenuHome(),
    );
  }

  List<Widget> buildTabBar(List<CategoriaModel> categoriasAtivas) {
    List<Tab> tabs = [];
    for (var categoria in categoriasAtivas) {
      tabs.add(Tab(text: categoria.nomeCategoria));
    }

    return tabs;
  }

  List<Widget> buildTabBarView(List<LocalModel> locaisAtivos, int lenght) {
    List<Widget> widget = [];
    for (var i = 0; i < lenght; i++) {
      widget.add(
        ListView.builder(
          itemCount: locaisAtivos.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Padding(
                padding: const EdgeInsets.only(
                  right: 15.0,
                  bottom: 5,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(),
                    ),
                    TextButtonWidget(
                      height: 25,
                      width: 75,
                      titleColor: ThemeColor.destaqueColor,
                      colorBackground: Colors.white,
                      title: 'Ver todos',
                      fontSize: 12,
                      callback: () {
                        return Modular.to.pushNamed('todos-locais', arguments: {
                          'categoriaNome': nomeCategoria.value,
                          'locais': locaisAtivos
                        });
                      },
                    ),
                  ],
                ),
              );
            } else {
              final localIndex = index - 1;
              return CardLocaisHorizontalWidget(
                local: locaisAtivos[localIndex],
                callback: () => Modular.to.pushNamed('/home/local',
                    arguments: {'local': locaisAtivos[localIndex]}),
              );
            }
          },
        ),
      );
    }

    return widget;
  }

  List<Widget> _listBanners(List<BannersModel> listaBanners) {
    List<Widget> banners = [];
    for (var i = 0; i < listaBanners.length; i++) {
      banners.add(ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Image.network(
          listaBanners[i].url!,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.fill,
        ),
      ));
    }
    return banners;
  }

  Future<void> _story(List<StoryModel> story) {
    return Asuka.showDialog(
      builder: (context) => Container(
        child: Material(
          child: Stack(
            children: [
              StoryPageView(
                pageLength: story.length,
                storyLength: (int pageIndex) {
                  return 1;
                },
                onPageLimitReached: () {
                  Navigator.pop(context);
                },
                itemBuilder: (
                  BuildContext context,
                  int pageIndex,
                  int storyIndex,
                ) {
                  return Stack(
                    children: [
                      Positioned.fill(
                        child: Container(
                          color: Colors.black,
                        ),
                      ),
                      Positioned.fill(
                        child: Image.network(
                          story[pageIndex].imagem!,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 44, left: 8),
                        child: Row(
                          children: [
                            Container(
                              height: 32,
                              width: 32,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(
                                        0.2), // Define a cor da sombra
                                    blurRadius:
                                        4, // Define o raio do desfoque da sombra
                                    offset: Offset(2,
                                        2), // Define o deslocamento da sombra
                                  ),
                                ],
                                image: DecorationImage(
                                  image:
                                      NetworkImage(story[pageIndex].imgLocal!),
                                  fit: BoxFit.cover,
                                ),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(
                                        0.2), // Define a cor da sombra
                                    blurRadius:
                                        4, // Define o raio do desfoque da sombra
                                    offset: Offset(2,
                                        2), // Define o deslocamento da sombra
                                  ),
                                ],
                              ),
                              child: Text(
                                story[pageIndex].nome!,
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
              Align(
                alignment: Alignment.topRight,
                child: Stack(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 45.0,
                          right: 25,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black
                                    .withOpacity(0.2), // Define a cor da sombra
                                blurRadius:
                                    4, // Define o raio do desfoque da sombra
                                offset: Offset(
                                    1, 0), // Define o deslocamento da sombra
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 35,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
