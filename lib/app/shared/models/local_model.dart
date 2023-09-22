import 'package:collection/collection.dart';

class LocalModel {
  int? idLocal;
  String? nome;
  int? idCategoria;
  String? informacoes;
  String? endereco;
  String? numero;
  String? complemento;
  String? bairro;
  String? cidade;
  String? telefone;
  String? whatsapp;
  String? instagram;
  String? abreSegunda;
  String? fechaSegunda;
  String? abreTerca;
  String? fechaTerca;
  String? abreQuarta;
  String? fechaQuarta;
  String? abreQuinta;
  String? fechaQuinta;
  String? abreSexta;
  String? fechaSexta;
  String? abreSabado;
  String? fechaSabado;
  String? abreDomingo;
  String? fechaDomingo;
  String? img;

  LocalModel({
    this.idLocal,
    this.nome,
    this.idCategoria,
    this.informacoes,
    this.endereco,
    this.numero,
    this.complemento,
    this.bairro,
    this.telefone,
    this.whatsapp,
    this.instagram,
    this.abreSegunda,
    this.fechaSegunda,
    this.abreTerca,
    this.fechaTerca,
    this.abreQuarta,
    this.fechaQuarta,
    this.abreQuinta,
    this.fechaQuinta,
    this.abreSexta,
    this.fechaSexta,
    this.abreSabado,
    this.fechaSabado,
    this.abreDomingo,
    this.fechaDomingo,
    this.img,
    this.cidade,
  });

  @override
  String toString() {
    return 'LocalModel(idLocal: $idLocal, nome: $nome, idCategoria: $idCategoria, informacoes: $informacoes, endereco: $endereco, numero: $numero, complemento: $complemento, bairro: $bairro, telefone: $telefone, whatsapp: $whatsapp, instagram: $instagram, abreSegunda: $abreSegunda, fechaSegunda: $fechaSegunda, abreTerca: $abreTerca, fechaTerca: $fechaTerca, abreQuarta: $abreQuarta, fechaQuarta: $fechaQuarta, abreQuinta: $abreQuinta, fechaQuinta: $fechaQuinta, abreSexta: $abreSexta, fechaSexta: $fechaSexta, abreSabado: $abreSabado, fechaSabado: $fechaSabado, abreDomingo: $abreDomingo, fechaDomingo: $fechaDomingo, img: $img, cidade: $cidade)';
  }

  factory LocalModel.fromJson(Map<String, dynamic> json) => LocalModel(
        idLocal: json['idLocal'] as int?,
        nome: json['nome'] as String?,
        idCategoria: json['idCategoria'] as int?,
        informacoes: json['informacoes'] as String?,
        endereco: json['endereco'] as String?,
        numero: json['numero'] as String?,
        complemento: json['complemento'] as String?,
        bairro: json['bairro'] as String?,
        telefone: json['telefone'] as String?,
        whatsapp: json['whatsapp'] as String?,
        instagram: json['instagram'] as String?,
        abreSegunda: json['abreSegunda'] as String?,
        fechaSegunda: json['fechaSegunda'] as String?,
        abreTerca: json['abreTerca'] as String?,
        fechaTerca: json['fechaTerca'] as String?,
        abreQuarta: json['abreQuarta'] as String?,
        fechaQuarta: json['fechaQuarta'] as String?,
        abreQuinta: json['abreQuinta'] as String?,
        fechaQuinta: json['fechaQuinta'] as String?,
        abreSexta: json['abreSexta'] as String?,
        fechaSexta: json['fechaSexta'] as String?,
        abreSabado: json['abreSabado'] as String?,
        fechaSabado: json['fechaSabado'] as String?,
        abreDomingo: json['abreDomingo'] as String?,
        fechaDomingo: json['fechaDomingo'] as String?,
        img: json['img'] as String?,
        cidade: json['cidade'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'idLocal': idLocal,
        'nome': nome,
        'idCategoria': idCategoria,
        'informacoes': informacoes,
        'endereco': endereco,
        'numero': numero,
        'complemento': complemento,
        'bairro': bairro,
        'telefone': telefone,
        'whatsapp': whatsapp,
        'instagram': instagram,
        'abreSegunda': abreSegunda,
        'fechaSegunda': fechaSegunda,
        'abreTerca': abreTerca,
        'fechaTerca': fechaTerca,
        'abreQuarta': abreQuarta,
        'fechaQuarta': fechaQuarta,
        'abreQuinta': abreQuinta,
        'fechaQuinta': fechaQuinta,
        'abreSexta': abreSexta,
        'fechaSexta': fechaSexta,
        'abreSabado': abreSabado,
        'fechaSabado': fechaSabado,
        'abreDomingo': abreDomingo,
        'fechaDomingo': fechaDomingo,
        'img': img,
        'cidade': cidade,
      };

  LocalModel copyWith({
    int? idLocal,
    String? nome,
    int? idCategoria,
    String? informacoes,
    String? endereco,
    String? numero,
    String? complemento,
    String? bairro,
    String? telefone,
    String? whatsapp,
    String? instagram,
    String? abreSegunda,
    String? fechaSegunda,
    String? abreTerca,
    String? fechaTerca,
    String? abreQuarta,
    String? fechaQuarta,
    String? abreQuinta,
    String? fechaQuinta,
    String? abreSexta,
    String? fechaSexta,
    String? abreSabado,
    String? fechaSabado,
    String? abreDomingo,
    String? fechaDomingo,
    String? img,
    String? cidade,
  }) {
    return LocalModel(
      idLocal: idLocal ?? this.idLocal,
      nome: nome ?? this.nome,
      idCategoria: idCategoria ?? this.idCategoria,
      informacoes: informacoes ?? this.informacoes,
      endereco: endereco ?? this.endereco,
      numero: numero ?? this.numero,
      complemento: complemento ?? this.complemento,
      bairro: bairro ?? this.bairro,
      telefone: telefone ?? this.telefone,
      whatsapp: whatsapp ?? this.whatsapp,
      instagram: instagram ?? this.instagram,
      abreSegunda: abreSegunda ?? this.abreSegunda,
      fechaSegunda: fechaSegunda ?? this.fechaSegunda,
      abreTerca: abreTerca ?? this.abreTerca,
      fechaTerca: fechaTerca ?? this.fechaTerca,
      abreQuarta: abreQuarta ?? this.abreQuarta,
      fechaQuarta: fechaQuarta ?? this.fechaQuarta,
      abreQuinta: abreQuinta ?? this.abreQuinta,
      fechaQuinta: fechaQuinta ?? this.fechaQuinta,
      abreSexta: abreSexta ?? this.abreSexta,
      fechaSexta: fechaSexta ?? this.fechaSexta,
      abreSabado: abreSabado ?? this.abreSabado,
      fechaSabado: fechaSabado ?? this.fechaSabado,
      abreDomingo: abreDomingo ?? this.abreDomingo,
      fechaDomingo: fechaDomingo ?? this.fechaDomingo,
      img: img ?? this.img,
      cidade: cidade ?? this.cidade,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! LocalModel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      idLocal.hashCode ^
      nome.hashCode ^
      idCategoria.hashCode ^
      informacoes.hashCode ^
      endereco.hashCode ^
      numero.hashCode ^
      complemento.hashCode ^
      bairro.hashCode ^
      telefone.hashCode ^
      whatsapp.hashCode ^
      instagram.hashCode ^
      abreSegunda.hashCode ^
      fechaSegunda.hashCode ^
      abreTerca.hashCode ^
      fechaTerca.hashCode ^
      abreQuarta.hashCode ^
      fechaQuarta.hashCode ^
      abreQuinta.hashCode ^
      fechaQuinta.hashCode ^
      abreSexta.hashCode ^
      fechaSexta.hashCode ^
      abreSabado.hashCode ^
      fechaSabado.hashCode ^
      abreDomingo.hashCode ^
      fechaDomingo.hashCode ^
      cidade.hashCode ^
      img.hashCode;
}
