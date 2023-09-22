import 'dart:developer';
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app_interceptor.dart';

class BackendService extends Disposable {
  late Dio io;
  AppInterceptor? interceptor;

  BackendService() {
    io = Dio();
    interceptor = AppInterceptor();
    io.interceptors.add(interceptor!);

    if (kDebugMode) {
      checkForFiddlerProxy(io);
    }
  }

  Future<void> checkForFiddlerProxy(Dio dio) async {
    String proxyIP = '';

    for (var interface in await NetworkInterface.list()) {
      for (var addr in interface.addresses) {
        if (addr.address.contains('192.168.100.86')) {
          proxyIP = '192.168.100.85';
        }

        /// Android emulator
        if (addr.address.contains('10.0.2')) {
          proxyIP = '10.0.2.2';
          break;
        }

        /// Android emulator
        if (addr.address.contains('192.168.232')) {
          proxyIP = '10.0.2.2';
          break;
        }
      }
    }

    if (proxyIP.isEmpty) return;
    log('#FiddlerProxyEnabled, #addr: $proxyIP');
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      client.findProxy = (uri) => "PROXY $proxyIP:8080;";
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return null;
    };
  }

  @override
  void dispose() {}
}
