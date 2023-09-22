import 'package:flutter_modular/flutter_modular.dart';
import 'package:lib/app/modulos/home/home_page.dart';
import 'package:lib/app/shared/models/evento_model.dart';
import 'package:lib/app/shared/models/story_model.dart';
import 'package:lib/app/shared/stores/banners_store.dart';
import 'package:lib/app/shared/stores/story_store.dart';

import '../../shared/backend/backend_service.dart';
import '../../shared/models/banners_model.dart';
import '../../shared/models/categoria_model.dart';
import '../../shared/models/local_model.dart';
import '../../shared/repository/repository.dart';
import '../../shared/stores/categoria_store.dart';
import '../../shared/stores/evento_store.dart';
import '../../shared/stores/home_page_store.dart';
import '../../shared/stores/local_por_id_store.dart';
import '../../shared/stores/local_store.dart';
import 'pages/evento_page.dart';
import 'pages/perfil_estabelecimento_page.dart';
import 'pages/todos_locais_page.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => Repository(i.get<BackendService>().io)),
    Bind.lazySingleton((i) => LocalStore(i.get())),
    Bind.lazySingleton((i) => LocalPorIdStore(i.get())),
    Bind.lazySingleton((i) => BannersStore(i.get())),
    Bind.lazySingleton((i) => CategoriaStore(i.get())),
    Bind.lazySingleton((i) => EventoStore(i.get())),
    Bind.lazySingleton((i) => HomePageStore(i.get())),
    Bind.lazySingleton((i) => StoryStore(i.get())),
  ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (_, args) => HomePage(
            categoriasAtivas:
                args.data['categoriasAtivas'] as List<CategoriaModel>,
            proximosEventos: args.data['proximosEventos'] as List<EventoModel>,
            banners: args.data['banners'] as List<BannersModel>,
            storys: args.data['storys'] as List<StoryModel>,
          ),
        ),
        ChildRoute(
          '/local',
          child: (_, args) => PerfilEstabelecimentoPage(
            local: args.data['local'] as LocalModel,
          ),
        ),
        ChildRoute(
          '/evento',
          child: (_, args) => EventoPage(
            idLocal: args.data['local'],
            evento: args.data['evento'] as EventoModel,
          ),
        ),
        ChildRoute(
          '/todos-locais',
          child: (_, args) => TodosLocaisPage(
            categoriaNome: args.data['categoriaNome'],
            locais: args.data['locais'] as List<LocalModel>,
          ),
        ),
      ];
}
