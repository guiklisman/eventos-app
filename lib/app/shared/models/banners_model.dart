import 'package:collection/collection.dart';

class BannersModel {
  final int? idBanner;
  final String? url;
  final int? posicao;

  BannersModel({
    this.idBanner,
    this.url,
    this.posicao,
  });

  @override
  String toString() {
    return 'CategoriaModel(idBanner: $idBanner, url: $url, posicao: $posicao)';
  }

  factory BannersModel.fromJson(Map<String, dynamic> json) {
    return BannersModel(
      idBanner: json['idBanner'] as int?,
      url: json['url'] as String?,
      posicao: json['posicao'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        'idBanner': idBanner,
        'url': url,
        'posicao': posicao,
      };

  BannersModel copyWith({
    int? idBanner,
    String? url,
    int? posicao,
  }) {
    return BannersModel(
      idBanner: idBanner ?? this.idBanner,
      url: url ?? this.url,
      posicao: posicao ?? this.posicao,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! BannersModel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => idBanner.hashCode ^ url.hashCode ^ posicao.hashCode;
}
