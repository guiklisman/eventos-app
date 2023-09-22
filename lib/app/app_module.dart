import 'package:flutter_modular/flutter_modular.dart';
import 'package:lib/app/modulos/home/home_module.dart';
import 'package:lib/app/shared/backend/backend_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'modulos/home/store_controller.dart';
import 'modulos/eventos_proximos/eventos_proximos_module.dart';
import 'modulos/splash/splash_module.dart';
import 'shared/services/verificação-conexao/no_connection_screen_page.dart';
import 'shared/stores/evento_store.dart';

class AppModule extends Module {
  AppModule() {
    print(Modular.initialRoute);
  }
  @override
  List<Bind> get binds => [
        AsyncBind((i) => SharedPreferences.getInstance()),
        Bind.lazySingleton((i) => BackendService()),
        Bind.lazySingleton((i) => EventoStore(
              i.get(),
            )),
        Bind.lazySingleton(
          (i) => StoreController(
            i.get(),
            i.get(),
            i.get(),
            i.get(),
            i.get(),
            i.get(),
          ),
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/no-connection', child: (_, __) => NoConnectionScreen()),
        ModuleRoute(
          Modular.initialRoute,
          module: SplashModule(),
          transition: TransitionType.fadeIn,
        ),
        ModuleRoute(
          '/home',
          module: HomeModule(),
          transition: TransitionType.fadeIn,
        ),
        ModuleRoute(
          '/lista-evento',
          module: EventosProximosModule(),
          transition: TransitionType.fadeIn,
        ),
      ];
}
