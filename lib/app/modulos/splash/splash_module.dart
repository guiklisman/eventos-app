import 'package:flutter_modular/flutter_modular.dart';
import 'package:lib/app/shared/stores/banners_store.dart';
import 'package:lib/app/shared/stores/descricao_evento_store.dart';
import 'package:lib/app/shared/stores/story_store.dart';

import './splash_page.dart';
import '../../shared/backend/backend_service.dart';
import '../../shared/repository/repository.dart';
import '../../shared/stores/categoria_store.dart';
import '../../shared/stores/evento_store.dart';
import '../../shared/stores/home_page_store.dart';
import '../../shared/stores/local_por_id_store.dart';
import '../../shared/stores/local_store.dart';

class SplashModule extends Module {
  @override
  List<Bind> binds = [
    Bind.lazySingleton((i) => Repository(i.get<BackendService>().io)),
    Bind.lazySingleton((i) => LocalStore(i.get())),
    Bind.lazySingleton((i) => LocalPorIdStore(i.get())),
    Bind.lazySingleton((i) => BannersStore(i.get())),
    Bind.lazySingleton((i) => CategoriaStore(i.get())),
    Bind.lazySingleton((i) => HomePageStore(i.get())),
    Bind.lazySingleton((i) => EventoStore(i.get())),
    Bind.lazySingleton((i) => DescricaoEventoStore(i.get())),
    Bind.lazySingleton((i) => StoryStore(i.get())),

    // Bind.lazySingleton(
    //   (i) => HomeController(
    //     i.get(),
    //     i.get(),
    //     i.get(),
    //     i.get(),
    //     i.get(),
    //   ),
    // ),
  ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, args) => const SplashPage()),
      ];
}
