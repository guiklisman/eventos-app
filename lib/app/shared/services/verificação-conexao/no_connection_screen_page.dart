import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lib/app/shared/utils/widgets/appbar_default.dart';

import '../../utils/widgets/text_button_widget.dart';

class NoConnectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        return Scaffold(
          appBar: AppBarDefault(),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: ListView(
                children: [
                  Image.asset(
                    'images/no-connection.png',
                    width: MediaQuery.of(context).size.width / 1.5,
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Você parece estar sem conexão com a internet!',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    "Conecte-se a uma rede para usar aproveitar o 037Eventos.",
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 32.0),
                  TextButtonWidget(
                      titleColor: Colors.white,
                      fontSize: 16,
                      title: 'Tentar Novamente',
                      width: MediaQuery.of(context).size.width / 1.5,
                      height: 45,
                      callback: () => Modular.to.pushNamed('/')),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
