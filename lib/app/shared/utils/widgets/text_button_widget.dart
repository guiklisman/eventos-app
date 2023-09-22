import 'package:flutter/material.dart';
import 'package:lib/app/shared/theme/theme.dart';

class TextButtonWidget extends StatefulWidget {
  final String title;
  final double? fontSize;
  final Color? titleColor;
  final Color? colorBackground;
  final double? width;
  final double? height;
  final Function callback;

  TextButtonWidget({
    Key? key,
    required this.title,
    this.colorBackground,
    this.width,
    this.height,
    this.titleColor,
    this.fontSize,
    required this.callback,
  }) : super(key: key);

  @override
  State<TextButtonWidget> createState() => _TextButtonWidgetState();
}

class _TextButtonWidgetState extends State<TextButtonWidget>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height ?? 25,
      width: widget.width ?? 75,
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
              widget.colorBackground ?? ThemeColor.destaqueColor),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            EdgeInsets.zero,
          ),
        ),
        child: Text(
          widget.title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: widget.fontSize ?? 10,
            fontWeight: FontWeight.bold,
            color: widget.titleColor ?? Colors.black,
          ),
        ),
        onPressed: (() {
          widget.callback();
        }),
      ),
    );
  }
}
