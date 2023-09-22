import 'package:flutter_triple/flutter_triple.dart';
import 'package:lib/app/shared/models/local_model.dart';

import '../repository/repository.dart';

class HomePageStore extends NotifierStore<Exception, List<LocalModel>> {
  final Repository _repository;
  HomePageStore(this._repository) : super([]);

  Future<List<LocalModel>> getLocal() async {
    setLoading(true);
    List<LocalModel> locals = [];
    final response = await _repository.fetchLocal();
    response.fold(setError, (r) {
      locals.addAll(r);
      update(r);
    });
    setLoading(false);

    return locals;
  }
}
