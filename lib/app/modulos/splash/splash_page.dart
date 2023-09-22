import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lib/app/modulos/home/store_controller.dart';
import 'package:lib/app/shared/models/story_model.dart';
import 'package:new_version_plus/new_version_plus.dart';

import '../../shared/models/banners_model.dart';
import '../../shared/models/categoria_model.dart';
import '../../shared/models/evento_model.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  StoreController storeController = Modular.get();
  AnimationController? _animationController;
  Animation<double>? _animation;
  Connectivity _connectivity = Connectivity();

  @override
  void initState() {
    super.initState();

    _checkConnectivity().then((isConnected) {
      if (isConnected) {
        _checkUpdate();
        _fetchData();
      } else {
        _navigateToNoConnectionScreen();
      }
    });

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _animation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController!,
        curve: Curves.easeInCirc,
      ),
    );

    _animationController!.forward();
  }

  Future<bool> _checkConnectivity() async {
    var connectivityResult = await _connectivity.checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  void _fetchData() async {
    Future.wait([
      storeController.getCategoriaAtivas(),
      storeController.buscarProximosEventos(),
      storeController.getBanners(),
      storeController.getStoryAtivo(),
    ]).then((value) {
      next(
        value[0] as List<CategoriaModel>,
        value[1] as List<EventoModel>,
        value[2] as List<BannersModel>,
        value[3] as List<StoryModel>,
      );
    });
  }

  void _checkUpdate() async {
    final newVersion = NewVersionPlus(
        iOSId: '6451264648',
        androidId: 'klisman.com.evento',
        iOSAppStoreCountry: 'br');

    final status = await newVersion.getVersionStatus();

    debugPrint('****** Verificando versão na loja ******');
    debugPrint('****** Versão da Loja: ${status!.storeVersion} ******');

    if (status.canUpdate) {
      newVersion.showUpdateDialog(
        allowDismissal: false,
        context: context,
        versionStatus: status,
        dialogTitle: 'Nova versão disponível.',
        dialogText: 'Atualize para ter acesso aos novos recursos e melhorias.',
        updateButtonText: 'Atualizar agora',
      );
    }
  }

  void _navigateToNoConnectionScreen() {
    Modular.to.navigate('/no-connection');
  }

  @override
  void dispose() {
    _animationController!.reset();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: FadeTransition(
          opacity: _animation!,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'images/037eventos.png',
                height: 200,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void next(
      List<CategoriaModel> listaCategoria,
      List<EventoModel> proximosEventos,
      List<BannersModel> banners,
      List<StoryModel> storys) {
    Future.delayed(const Duration(seconds: 3)).then((value) async {
      Modular.to.navigate('/home/', arguments: {
        'categoriasAtivas': listaCategoria,
        'proximosEventos': proximosEventos,
        'banners': banners,
        'storys': storys
      });
    });
  }
}
