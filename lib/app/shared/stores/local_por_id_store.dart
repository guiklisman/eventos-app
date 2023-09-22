import 'package:flutter_triple/flutter_triple.dart';
import 'package:lib/app/shared/models/local_model.dart';

import '../../shared/repository/repository.dart';

class LocalPorIdStore extends StreamStore<Exception, LocalModel> {
  final Repository _repository;

  LocalPorIdStore(this._repository) : super(LocalModel());

  Future<void> localporId(String idLocal) async {
    setLoading(true);

    final response = await _repository.localporId(idLocal);
    response.fold(setError, (r) {
      update(r, force: true);
    });
    setLoading(false);
  }
}
