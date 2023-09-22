import 'package:collection/collection.dart';

class EventoModel {
  int? idLocal;
  int? idEvento;
  String? nomeEvento;
  int? exibirEvento;
  int? idCategoria;
  String? dataEvento;
  String? inicioEvento;
  String? terminoEvento;
  String? infoUteis;
  String? descricaoEvento;
  String? whatsappEvento;
  String? instagramEvento;
  String? siteEvento;
  String? emailEvento;
  String? telefoneEvento;
  String? imgEvento;
  String? nomeBotao;
  String? nomeLocal;

  EventoModel({
    this.idLocal,
    this.idEvento,
    this.nomeEvento,
    this.exibirEvento,
    this.idCategoria,
    this.dataEvento,
    this.inicioEvento,
    this.terminoEvento,
    this.infoUteis,
    this.descricaoEvento,
    this.whatsappEvento,
    this.instagramEvento,
    this.siteEvento,
    this.emailEvento,
    this.telefoneEvento,
    this.imgEvento,
    this.nomeBotao,
    this.nomeLocal,
  });

  @override
  String toString() {
    return 'EventoModel(idLocal: $idLocal, idEvento: $idEvento, nomeEvento: $nomeEvento, exibirEvento: $exibirEvento, idCategoria: $idCategoria, dataEvento: $dataEvento, inicioEvento: $inicioEvento, terminoEvento: $terminoEvento, infoUteis: $infoUteis, descricaoEvento: $descricaoEvento, whatsappEvento: $whatsappEvento, instagramEvento: $instagramEvento, siteEvento: $siteEvento, emailEvento: $emailEvento, telefoneEvento: $telefoneEvento, imgEvento: $imgEvento, nomeBotao: $nomeBotao, nomeLocal: $nomeLocal)';
  }

  factory EventoModel.fromJson(Map<String, dynamic> json) => EventoModel(
        idLocal: json['idLocal'] as int?,
        idEvento: json['idEvento'] as int?,
        nomeEvento: json['nomeEvento'] as String?,
        exibirEvento: json['exibirEvento'] as int?,
        idCategoria: json['idCategoria'] as int?,
        dataEvento: json['dataEvento'] as String?,
        inicioEvento: json['inicioEvento'] as String?,
        terminoEvento: json['terminoEvento'] as String?,
        infoUteis: json['infoUteis'] as String?,
        descricaoEvento: json['descricaoEvento'] as String?,
        whatsappEvento: json['whatsappEvento'] as String?,
        instagramEvento: json['instagramEvento'] as String?,
        siteEvento: json['siteEvento'] as String?,
        emailEvento: json['emailEvento'] as String?,
        telefoneEvento: json['telefoneEvento'] as String?,
        imgEvento: json['imgEvento'] as String?,
        nomeBotao: json['nomeBotao'] as String?,
        nomeLocal: json['nomeLocal'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'idLocal': idLocal,
        'idEvento': idEvento,
        'nomeEvento': nomeEvento,
        'exibirEvento': exibirEvento,
        'idCategoria': idCategoria,
        'dataEvento': dataEvento,
        'inicioEvento': inicioEvento,
        'terminoEvento': terminoEvento,
        'infoUteis': infoUteis,
        'descricaoEvento': descricaoEvento,
        'whatsappEvento': whatsappEvento,
        'instagramEvento': instagramEvento,
        'siteEvento': siteEvento,
        'emailEvento': emailEvento,
        'telefoneEvento': telefoneEvento,
        'imgEvento': imgEvento,
        'nomeBotao': nomeBotao,
        'nomeLocal': nomeLocal,
      };

  EventoModel copyWith(
      {int? idLocal,
      int? idEvento,
      String? nomeEvento,
      int? exibirEvento,
      int? idCategoria,
      String? dataEvento,
      String? inicioEvento,
      String? terminoEvento,
      String? infoUteis,
      String? descricaoEvento,
      String? whatsappEvento,
      String? instagramEvento,
      String? siteEvento,
      String? emailEvento,
      String? telefoneEvento,
      String? imgEvento,
      String? nomeBotao,
      String? nomeLocal}) {
    return EventoModel(
      idLocal: idLocal ?? this.idLocal,
      idEvento: idEvento ?? this.idEvento,
      nomeEvento: nomeEvento ?? this.nomeEvento,
      exibirEvento: exibirEvento ?? this.exibirEvento,
      idCategoria: idCategoria ?? this.idCategoria,
      dataEvento: dataEvento ?? this.dataEvento,
      inicioEvento: inicioEvento ?? this.inicioEvento,
      terminoEvento: terminoEvento ?? this.terminoEvento,
      infoUteis: infoUteis ?? this.infoUteis,
      descricaoEvento: descricaoEvento ?? this.descricaoEvento,
      whatsappEvento: whatsappEvento ?? this.whatsappEvento,
      instagramEvento: instagramEvento ?? this.instagramEvento,
      siteEvento: siteEvento ?? this.siteEvento,
      emailEvento: emailEvento ?? this.emailEvento,
      telefoneEvento: telefoneEvento ?? this.telefoneEvento,
      imgEvento: imgEvento ?? this.imgEvento,
      nomeBotao: nomeBotao ?? this.nomeBotao,
      nomeLocal: nomeLocal ?? this.nomeLocal,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! EventoModel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      idLocal.hashCode ^
      idEvento.hashCode ^
      nomeEvento.hashCode ^
      exibirEvento.hashCode ^
      idCategoria.hashCode ^
      dataEvento.hashCode ^
      inicioEvento.hashCode ^
      terminoEvento.hashCode ^
      infoUteis.hashCode ^
      descricaoEvento.hashCode ^
      whatsappEvento.hashCode ^
      instagramEvento.hashCode ^
      siteEvento.hashCode ^
      emailEvento.hashCode ^
      telefoneEvento.hashCode ^
      imgEvento.hashCode ^
      nomeLocal.hashCode ^
      nomeBotao.hashCode;
}
