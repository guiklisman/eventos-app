import 'package:collection/collection.dart';

class CategoriaModel {
  final int? idCategoria;
  final String? nomeCategoria;
  final String? iconeCategoria;
  final int? ordenacaoCategoria;
  final int? exibirCategoria;
  bool? selection;
  final dynamic createdAt;
  final dynamic updatedAt;

  CategoriaModel({
    this.idCategoria,
    this.nomeCategoria,
    this.iconeCategoria,
    this.ordenacaoCategoria,
    this.exibirCategoria,
    this.selection,
    this.createdAt,
    this.updatedAt,
  });

  @override
  String toString() {
    return 'CategoriaModel(idCategoria: $idCategoria, nomeCategoria: $nomeCategoria, iconeCategoria: $iconeCategoria, ordenacaoCategoria: $ordenacaoCategoria, exibirCategoria: $exibirCategoria, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  factory CategoriaModel.fromJson(Map<String, dynamic> json) {
    return CategoriaModel(
      idCategoria: json['idCategoria'] as int?,
      nomeCategoria: json['nomeCategoria'] as String?,
      iconeCategoria: json['iconeCategoria'] as String?,
      ordenacaoCategoria: json['ordenacaoCategoria'] as int?,
      exibirCategoria: json['exibirCategoria'] as int?,
      createdAt: json['created_at'] as dynamic,
      updatedAt: json['updated_at'] as dynamic,
    );
  }

  Map<String, dynamic> toJson() => {
        'idCategoria': idCategoria,
        'nomeCategoria': nomeCategoria,
        'iconeCategoria': iconeCategoria,
        'ordenacaoCategoria': ordenacaoCategoria,
        'exibirCategoria': exibirCategoria,
        'created_at': createdAt,
        'updated_at': updatedAt,
      };

  CategoriaModel copyWith({
    int? idCategoria,
    String? nomeCategoria,
    String? iconeCategoria,
    int? ordenacaoCategoria,
    int? exibirCategoria,
    dynamic createdAt,
    dynamic updatedAt,
  }) {
    return CategoriaModel(
      idCategoria: idCategoria ?? this.idCategoria,
      nomeCategoria: nomeCategoria ?? this.nomeCategoria,
      iconeCategoria: iconeCategoria ?? this.iconeCategoria,
      ordenacaoCategoria: ordenacaoCategoria ?? this.ordenacaoCategoria,
      exibirCategoria: exibirCategoria ?? this.exibirCategoria,
      selection: selection ?? this.selection,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! CategoriaModel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      idCategoria.hashCode ^
      nomeCategoria.hashCode ^
      iconeCategoria.hashCode ^
      ordenacaoCategoria.hashCode ^
      exibirCategoria.hashCode ^
      selection.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;
}
