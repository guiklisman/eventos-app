import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lib/app/shared/backend/backend_routes.dart';
import 'package:lib/app/shared/models/categoria_model.dart';
import 'package:lib/app/shared/models/local_model.dart';
import 'package:lib/app/shared/models/story_model.dart';

import '../models/banners_model.dart';
import '../models/evento_model.dart';

class Repository extends Disposable {
  final Dio _client;

  Repository(this._client);

  Future<Either<Exception, List<StoryModel>>> getStoryAtivos() async {
    try {
      final response = await _client.get(
        BackendRoutes.storyAtivos,
      );
      if (response.statusCode == 200) {
        List<StoryModel> listaLocal = [];

        for (var json in response.data) {
          listaLocal.add(StoryModel.fromJson(json));
        }

        return Right(listaLocal);
      }
      return Right(List<StoryModel>.empty());
    } on Exception catch (e) {
      return Left(
        Exception(e),
      );
    }
  }

  Future<Either<Exception, List<LocalModel>>> getLocalporCategoria(
      String idCategoria) async {
    try {
      final response = await _client.get(
        BackendRoutes.localPorCategoria(idCategoria),
      );
      if (response.statusCode == 200) {
        List<LocalModel> listaLocal = [];

        for (var json in response.data) {
          listaLocal.add(LocalModel.fromJson(json));
        }

        return Right(listaLocal);
      }
      return Right(List<LocalModel>.empty());
    } on Exception catch (e) {
      return Left(
        Exception(e),
      );
    }
  }

  Future<Either<Exception, LocalModel>> localporId(String idLocal) async {
    try {
      final response = await _client.get(
        BackendRoutes.localporId(idLocal),
      );
      if (response.statusCode == 200) {
        return Right(LocalModel.fromJson(response.data));
      }
      return Right(LocalModel());
    } on Exception catch (e) {
      return Left(
        Exception(e),
      );
    }
  }

  Future<Either<Exception, List<LocalModel>>> fetchLocal() async {
    try {
      final response = await _client.get('/local');
      if (response.statusCode == 200) {
        List<LocalModel> listaLocal = [];

        for (var json in response.data) {
          listaLocal.add(LocalModel.fromJson(json));
        }

        return Right(listaLocal);
      }
      return Right(List<LocalModel>.empty());
    } on Exception catch (e) {
      return Left(
        Exception(e),
      );
    }
  }

  Future<Either<Exception, List<CategoriaModel>>> fetchCategorias() async {
    try {
      final response = await _client.get(BackendRoutes.categoriasAtivas);

      if (response.statusCode == 200) {
        List<CategoriaModel> listaCategoria = [];

        for (var json in response.data) {
          listaCategoria.add(CategoriaModel.fromJson(json));
        }

        return Right(listaCategoria);
      }
      return Right(List<CategoriaModel>.empty());
    } on Exception catch (e) {
      return Left(
        Exception(e),
      );
    }
  }

  Future<Either<Exception, List<BannersModel>>> getBanners() async {
    try {
      final response = await _client.get(BackendRoutes.banners);

      if (response.statusCode == 200) {
        List<BannersModel> listaBanners = [];

        for (var json in response.data) {
          listaBanners.add(BannersModel.fromJson(json));
        }

        return Right(listaBanners);
      }
      return Right(List<BannersModel>.empty());
    } on Exception catch (e) {
      return Left(
        Exception(e),
      );
    }
  }

  Future<Either<Exception, List<EventoModel>>> eventosAtivosLocal(
      String idLocal) async {
    try {
      final response = await _client.get(
        BackendRoutes.eventosAtivosLocal(
          idLocal,
        ),
      );

      if (response.statusCode == 200) {
        List<EventoModel> listaEvento = [];

        for (var json in response.data) {
          listaEvento.add(EventoModel.fromJson(json));
        }

        return Right(listaEvento);
      }
      return Right([]);
    } on Exception catch (e) {
      return Left(
        Exception(e),
      );
    }
  }

  Future<Either<Exception, List<EventoModel>>> fetchEventoGeral() async {
    try {
      final response = await _client.get(BackendRoutes.evento);
      if (response.statusCode == 200) {
        List<EventoModel> listaEvento = [];

        for (var json in response.data) {
          listaEvento.add(EventoModel.fromJson(json));
        }

        return Right(listaEvento);
      }
      return Right(List<EventoModel>.empty());
    } on Exception catch (e) {
      return Left(
        Exception(e),
      );
    }
  }

  Future<Either<Exception, List<EventoModel>>> buscarProximosEventos() async {
    try {
      final response = await _client.get(BackendRoutes.proximosEventos);

      if (response.statusCode == 200) {
        List<EventoModel> listaEvento = [];

        for (var json in response.data) {
          listaEvento.add(EventoModel.fromJson(json));
        }

        return Right(listaEvento);
      }
      return Right(List<EventoModel>.empty());
    } on Exception catch (e) {
      return Left(
        Exception(e),
      );
    }
  }

  Future<Either<Exception, List<LocalModel>>> fecthLocalsByID(
      int idCategoria) async {
    try {
      final response = await _client.post(BackendRoutes.pesquisarLocal,
          data: {"idCategoria": idCategoria});
      if (response.statusCode == 200) {
        List<LocalModel> listaLocal = [];

        for (var json in response.data) {
          listaLocal.add(LocalModel.fromJson(json));
        }

        return Right(listaLocal);
      }
      return Right(List<LocalModel>.empty());
    } on Exception catch (e) {
      return Left(
        Exception(e),
      );
    }
  }

  @override
  void dispose() {}
}
