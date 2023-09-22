import 'package:flutter/material.dart';

class SizeConfig {
  final MediaQueryData mediaQueryData;
  SizeConfig({required this.mediaQueryData});

  static SizeConfig of(BuildContext context) =>
      SizeConfig(mediaQueryData: MediaQuery.of(context));

  ///Calcula o tamanho da tela sem a AppBar
  double heightWithoutAppBar() {
    double appbar = AppBar().preferredSize.height; //Pegar o tamanho da AppBar
    return mediaQueryData.size.height - mediaQueryData.padding.top - appbar;
  }

  ///Calcula o tamanho da tela
  double height() {
    return mediaQueryData.size.height;
  }

  ///Calcula o largura da tela
  double width() {
    return mediaQueryData.size.height;
  }

  ///Calcula o tamanho da tela sem o top
  double heightWithoutTheTop() {
    return mediaQueryData.size.height - mediaQueryData.padding.top;
  }

  ///Calcula a largura da tela sem o drawer fixo
  double widthWithoutTheDraewer() {
    return mediaQueryData.size.width - 200;
  }

  double dynamicScaleSize(
      {double? size, double? scaleFactorTablet, double? scaleFactorMini}) {
    if (isTablet()) {
      final scaleFactor = scaleFactorTablet ?? 2;
      return size! * scaleFactor;
    }

    if (isMini()) {
      final scaleFactor = scaleFactorMini ?? 0.8;
      return size! * scaleFactor;
    }

    return size!;
  }

  /// Define o tipo de dispositivo com base em pixels de dispositivo lógico.
  /// Mais de 600 significa que é um tablet
  bool isTablet() {
    final shortestSide = mediaQueryData.size.shortestSide;
    return shortestSide > 600;
  }

  /// Define o tipo de dispositivo com base em pixels de dispositivo lógico.
  /// Menor ou igual a 320 significa que é um mini dispositivo
  bool isMini() {
    final shortestSide = mediaQueryData.size.shortestSide;
    return shortestSide <= 320;
  }
}
