import 'package:lib/app/shared/global/global_information.dart';

///Classe para gerenciar as rotas
class BackendRoutes {
  static String baseURL = GlobalInformation.baseURL;

  ///Api lista das Cidades
  static String localPorCategoria(String idCategoria) =>
      baseURL + '/locaisPorCategoria/$idCategoria/';

  static String localporId(String localporId) =>
      baseURL + '/localporId/$localporId/';

  static String categoriasAtivas = baseURL + "/categoriasAtivas";
  static String evento = baseURL + "/eventos";

  static String proximosEventos = baseURL + "/buscarProximosEventos";

  static String storyAtivos = baseURL + "/getStories24h";

  static String eventosAtivosLocal(String idLocal) =>
      baseURL + "/eventosAtivosLocal/$idLocal";
  static String pesquisarLocal = baseURL + "/pesquisarLocal";
  static String banners = baseURL + "/banners";
}
