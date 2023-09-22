import 'package:flutter_triple/flutter_triple.dart';

import '../../shared/models/categoria_model.dart';
import '../../shared/repository/repository.dart';

class CategoriaStore extends StreamStore<Exception, List<CategoriaModel>> {
  final Repository _repository;
  CategoriaStore(this._repository) : super([]);

  Future<List<CategoriaModel>> getCategoriaAtivas() async {
    setLoading(true);
    List<CategoriaModel> categorias = [];
    final response = await _repository.fetchCategorias();
    response.fold(setError, (r) {
      categorias.addAll(r);
      update(r);
    });
    setLoading(false);

    return categorias;
  }
}
