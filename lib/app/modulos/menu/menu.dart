import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class MenuHome extends StatefulWidget {
  @override
  State<MenuHome> createState() => _MenuHomeState();
}

class _MenuHomeState extends State<MenuHome> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        children: <Widget>[
          SizedBox(
            height: 150,
            width: 150,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
              ),
              child: Container(
                // Defina a largura desejada
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'images/logo-normal.png',
                    ),
                  ),
                ),
              ),
            ),
          ),
          // ListTile(
          //   leading: Icon(Icons.add_to_home_screen),
          //   title: Text('Versão Web'),
          //   onTap: () {
          //     launch('https://037eventos.com.br/app');
          //     Navigator.pop(context);
          //   },
          // ),
          ListTile(
            leading: Icon(Icons.add),
            title: Text('Fazer parte'),
            onTap: () {
              launch(
                  "https://api.whatsapp.com/send?phone=5537988027696&text=Ol%C3%A1%2C%20gostaria%20de%20saber%20como%20adicionar%20um%20evento%20no%20aplicativo%20037%20Eventos");
              Navigator.pop(context);
            },
          ),
          // ListTile(
          //   leading: Icon(Icons.share),
          //   title: Text('Compartilhar'),
          //   onTap: () {
          //     Share.share('https://037eventos.com.br/app/',
          //         subject:
          //             'Encontrei esse aplicativo que mostra os eventos de Divinópolis! Baixe você também!');
          //     Navigator.pop(context);
          //   },
          // ),
          ListTile(
            leading: Icon(FontAwesomeIcons.whatsapp),
            title: Text('Contato'),
            onTap: () {
              launch("https://api.whatsapp.com/send?phone=5537988027696");
              Navigator.pop(context);
            },
          ),
          Center(
              child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 200, 0, 0),
            child: Text(
              "Versão 1.0.0",
              style: TextStyle(fontSize: 12),
            ),
          )),
        ],
      ),
    );
  }
}
