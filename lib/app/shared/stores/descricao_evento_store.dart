import 'package:flutter_triple/flutter_triple.dart';
import 'package:lib/app/shared/models/evento_model.dart';

import '../repository/repository.dart';

class DescricaoEventoStore extends NotifierStore<Exception, List<EventoModel>> {
  final Repository _repository;
  DescricaoEventoStore(this._repository) : super([]);

  void eventosAtivosLocal(String idLocal) async {
    setLoading(true);
    final response = await _repository.eventosAtivosLocal(idLocal);
    response.fold(setError, update);
    setLoading(false);
  }
}
