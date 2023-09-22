import 'package:flutter_triple/flutter_triple.dart';
import 'package:lib/app/shared/models/evento_model.dart';

import '../repository/repository.dart';

class EventoStore extends StreamStore<Exception, List<EventoModel>> {
  final Repository _repository;
  EventoStore(this._repository) : super([]);

  Future<List<EventoModel>> eventosAtivosLocal(String idLocal) async {
    setLoading(true);
    List<EventoModel> eventos = [];
    final response = await _repository.eventosAtivosLocal(idLocal);
    response.fold(setError, (r) {
      eventos.addAll(r);
      update(r, force: true);
    });
    setLoading(false);
    return eventos;
  }

  Future<List<EventoModel>> getEventoPorCategoria(String idCategoria) async {
    setLoading(true);
    List<EventoModel> eventos = [];
    final response = await _repository.fetchEventoGeral();
    response.fold(setError, (r) {
      eventos.addAll(r);
      update(r, force: true);
    });
    setLoading(false);

    return eventos;
  }

  Future<List<EventoModel>> buscarProximosEventos() async {
    setLoading(true);
    List<EventoModel> eventos = [];
    final response = await _repository.buscarProximosEventos();
    response.fold(setError, (r) {
      eventos.addAll(r);
      update(r, force: true);
    });
    setLoading(false);
    return eventos;
  }
}
