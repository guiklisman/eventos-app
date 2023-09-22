import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

import 'package:flutter_modular/flutter_modular.dart';

class AppInterceptor extends Interceptor {
  final Connectivity _connectivity = Connectivity();

  List? errors;
  bool returnLogin = false;

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    var connectivityResult = await _connectivity.checkConnectivity();

    if (connectivityResult != ConnectivityResult.none) {
    } else {
      handler.reject(
        DioError(
          requestOptions: options,
          error: 'Sem conexão com a internet',
          type: DioErrorType.other,
        ),
      );
      Modular.to.pushNamed('/no-connection', forRoot: true);
    }
    return super.onRequest(options, handler);
  }

  @override
  void onError(DioError? erro, ErrorInterceptorHandler handler) {
    //400,401,403,500
    int? statusCode = erro!.response?.statusCode;
    if (statusCode != null) {
      var data;
      try {
        data = json.decode(erro.response?.data);
      } catch (e) {
        data = erro.response?.data;
      }
      switch (statusCode) {
        case 400:
          errors = [data["message"] ?? data['mensagem']];
          break;
        case 401:
          errors = [data["message"] ?? data['mensagem']];
          break;
        case 403:
          errors = ["Você não tem permissão de acesso, faça login novamente"];
          break;
        case 500:
          errors = ["Erro interno do servidor"];
          break;
        default:
          errors = [jsonDecode(erro.response?.data)];
      }
    } else {
      errors = ["Erro interno do servidor"];
    }

    return super.onError(erro, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    return super.onResponse(response, handler);
  }
}
