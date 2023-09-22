import 'package:flutter_modular/flutter_modular.dart';
import 'package:lib/app/modulos/eventos_proximos/eventos_proximos_page.dart';

import '../../shared/backend/backend_service.dart';
import '../../shared/repository/repository.dart';
import '../../shared/stores/evento_store.dart';

class EventosProximosModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => Repository(i.get<BackendService>().io)),
    Bind.lazySingleton((i) => EventoStore(i.get())),
  ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/',
            child: (_, args) => EventosProximosPage(
                  proximosEventos: args.data,
                )),
      ];
}
