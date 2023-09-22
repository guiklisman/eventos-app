import 'package:intl/intl.dart';

class Formatters {
  static String formatarValor(double valor) {
    return NumberFormat.currency(locale: "pt_BR", symbol: "").format(valor);
  }

  static String formatarValorInt(int valor) {
    return NumberFormat.currency(locale: "pt_BR", symbol: "", decimalDigits: 0)
        .format(valor);
  }

   static String formatarData(String data) {
    return DateFormat("dd/MM/yyyy").format(DateTime.parse(data));
  }

  static String ConcatComVirgula(String? string1, String? string2) {
    //Exibe String 1, String 2 e verifica null para remover ,
    if (string1 == null || string1.isEmpty) {
      return string2 ?? '';
    } else if (string2 == null || string2.isEmpty) {
      return string1;
    } else {
      return string1 + ', ' + string2;
    }
  }

    static String ConcatComTraco(String? string1, String? string2) {
    //Exibe String 1, String 2 e verifica null para remover ,
    if (string1 == null || string1.isEmpty) {
      return string2 ?? '';
    } else if (string2 == null || string2.isEmpty) {
      return string1;
    } else {
      return string1 + ' - ' + string2;
    }
  }
  
}
