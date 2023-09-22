import 'package:flutter_modular/flutter_modular.dart';
import 'package:lib/app/shared/models/evento_model.dart';
import 'package:lib/app/shared/models/local_model.dart';
import 'package:lib/app/shared/stores/evento_store.dart';
import 'package:lib/app/shared/stores/story_store.dart';

import '../../shared/models/banners_model.dart';
import '../../shared/models/categoria_model.dart';
import '../../shared/models/story_model.dart';
import '../../shared/stores/banners_store.dart';
import '../../shared/stores/categoria_store.dart';

import '../../shared/stores/local_por_id_store.dart';
import '../../shared/stores/local_store.dart';

class StoreController extends Disposable {
  final EventoStore _eventoStore;
  final CategoriaStore _categoriaStore;
  final LocalStore _localStore;
  final BannersStore _bannersStore;
  final LocalPorIdStore _localPorIdStore;
  final StoryStore _storyStore;

  StoreController(this._categoriaStore, this._eventoStore, this._localStore,
      this._bannersStore, this._localPorIdStore, this._storyStore);

  //CHAMADA DE REQUISIÇÕES PELA STORE
  //CATEGORIAS

  Future<List<CategoriaModel>> getCategoriaAtivas() async =>
      await _categoriaStore.getCategoriaAtivas();

  //lOCAIS

  Future<void> getLocalPorCategoria(String idCategoria) async =>
      await _localStore.getLocalPorCategoria(idCategoria);

  // Future<List<LocalModel>> localporId(String idLocal) async =>
  //     await _localStore.localporId(idLocal);

  Future<void> localporId(String idLocal) async =>
      await _localPorIdStore.localporId(idLocal);

  //EVENTOS

  Future<List<EventoModel>> eventosAtivosLocal(String idLocal) async =>
      await _eventoStore.eventosAtivosLocal(idLocal);

  Future<List<EventoModel>> buscarProximosEventos() async =>
      await _eventoStore.buscarProximosEventos();

  //BANNERS

  Future<List<BannersModel>> getBanners() async =>
      await _bannersStore.getBanners();

  // STORY

  Future<List<StoryModel>> getStoryAtivo() async =>
      await _storyStore.getStoryAtivos();
  @override
  void dispose() {}
}
