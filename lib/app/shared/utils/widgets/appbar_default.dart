import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lib/app/shared/theme/app_images.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';

import '../../theme/theme_color.dart';

class AppBarDefault extends StatefulWidget implements PreferredSizeWidget {
  final bool share;
  final ScreenshotController? screenshotController;

  AppBarDefault({
    super.key,
    this.share = false,
    this.screenshotController,
  });

  @override
  State<AppBarDefault> createState() => _AppBarDefaultState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AppBarDefaultState extends State<AppBarDefault> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Image.asset(
        ImagePath.logoAppBar,
        height: 50,
      ),
      centerTitle: true,
      backgroundColor: ThemeColor.appbarColor,
      elevation: 3,
      iconTheme: IconThemeData(
        color: ThemeColor.destaqueColor,
      ),
      actions: [
        (widget.share)
            ? PopupMenuButton(
                itemBuilder: (BuildContext context) => [
                  PopupMenuItem(
                    child: Text('Compartilhar'),
                    value: 'compartilhar',
                  ),
                ],
                onSelected: (value) {
                  if (value == 'compartilhar') {
                    // Lógica de compartilhamento aqui
                    // ...
                  }
                },
                child: IconButton(
                  icon: Icon(Icons.share),
                  onPressed: () async {
                    Uint8List? image =
                        await widget.screenshotController!.capture(
                      delay: const Duration(milliseconds: 10),
                      pixelRatio: MediaQuery.of(context).devicePixelRatio,
                    );

                    if (image != null) {
                      final directory =
                          await getApplicationDocumentsDirectory();
                      final imagePath =
                          await File('${directory.path}/image.png').create();
                      await imagePath.writeAsBytes(image);

                      /// Share Plugin
                      await Share.shareFiles([imagePath.path]);
                    }
                  },
                ),
              )
            : SizedBox()
      ],
    );
  }
}
