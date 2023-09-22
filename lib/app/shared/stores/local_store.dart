import 'package:flutter_triple/flutter_triple.dart';
import 'package:lib/app/shared/models/local_model.dart';

import '../../shared/repository/repository.dart';

class LocalStore extends NotifierStore<Exception, List<LocalModel>> {
  final Repository _repository;

  LocalStore(this._repository) : super([]);

  Future<void> getLocalPorCategoria(String idCategoria) async {
    setLoading(true);
    List<LocalModel> local = [];
    final response = await _repository.getLocalporCategoria(idCategoria);
    response.fold(setError, (r) {
      local.addAll(r);
      update(local, force: true);
    });
    setLoading(false);
  }
}
