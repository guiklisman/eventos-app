import 'package:collection/collection.dart';

class StoryModel {
  int? idStory;
  String? imagem;
  int? aprovado;
  int? ativo;
  String? data;
  int? idLocal;
  String? nome;
  String? imgLocal;

  StoryModel({
    this.idStory,
    this.imagem,
    this.aprovado,
    this.ativo,
    this.data,
    this.idLocal,
    this.nome,
    this.imgLocal,
  });

  @override
  String toString() {
    return 'StoryModel(idStory: $idStory, imagem: $imagem, aprovado: $aprovado, ativo: $ativo, data: $data, idLocal: $idLocal, nome: $nome, imgLocal: $imgLocal)';
  }

  factory StoryModel.fromJson(Map<String, dynamic> json) => StoryModel(
        idStory: json['idStory'] as int?,
        imagem: json['imagem'] as String?,
        aprovado: json['aprovado'] as int?,
        ativo: json['ativo'] as int?,
        data: json['data'] as String?,
        idLocal: json['idLocal'] as int?,
        nome: json['nome'] as String?,
        imgLocal: json['imgLocal'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'idStory': idStory,
        'imagem': imagem,
        'aprovado': aprovado,
        'ativo': ativo,
        'data': data,
        'idLocal': idLocal,
        'nome': nome,
        'imgLocal': imgLocal,
      };

  StoryModel copyWith({
    int? idStory,
    String? imagem,
    int? aprovado,
    int? ativo,
    String? data,
    int? idLocal,
    String? nome,
    String? imgLocal,
  }) {
    return StoryModel(
      idStory: idStory ?? this.idStory,
      imagem: imagem ?? this.imagem,
      aprovado: aprovado ?? this.aprovado,
      ativo: ativo ?? this.ativo,
      data: data ?? this.data,
      idLocal: idLocal ?? this.idLocal,
      nome: nome ?? this.nome,
      imgLocal: imgLocal ?? this.imgLocal,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! StoryModel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      idStory.hashCode ^
      imagem.hashCode ^
      aprovado.hashCode ^
      ativo.hashCode ^
      data.hashCode ^
      imgLocal.hashCode ^
      nome.hashCode ^
      idLocal.hashCode;
}
