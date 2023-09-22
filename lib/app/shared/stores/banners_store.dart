import 'package:flutter_triple/flutter_triple.dart';

import '../../shared/repository/repository.dart';
import '../models/banners_model.dart';

class BannersStore extends NotifierStore<Exception, List<BannersModel>> {
  final Repository _repository;
  BannersStore(this._repository) : super([]);

  Future<List<BannersModel>> getBanners() async {
    setLoading(true);
    List<BannersModel> banners = [];
    final response = await _repository.getBanners();
    response.fold(setError, (r) {
      banners.addAll(r);
      update(r);
    });
    setLoading(false);

    return banners;
  }
}
