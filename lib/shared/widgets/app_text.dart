// ignore_for_file: non_constant_identifier_names, camel_case_types

import 'package:flutter/material.dart';

class App_Text extends StatelessWidget {
  final String data;
  final Color? color;
  final double? size;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final int? maxLine;
  final TextDecoration? decoration;
  final TextOverflow? overflow;
  final TextDirection? direction;
  final double paddingHorizontal;
  final double paddingVertical;

  const App_Text({
    Key? key,
    required this.data,
    this.color,
    this.size = 18,
    this.fontWeight = FontWeight.bold,
    this.fontFamily = 'Molhim',
    this.maxLine,
    this.decoration,
    this.overflow = TextOverflow.ellipsis,
    this.direction = TextDirection.rtl,
    this.paddingHorizontal = 0,
    this.paddingVertical = 0,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: paddingHorizontal, vertical: paddingVertical),
      child: Text(
        maxLines: maxLine,
        data,
        textDirection: direction,
        style: TextStyle(
          decoration: decoration,
          overflow: overflow,
          color: color,
          fontSize: size,
          fontWeight: fontWeight,
          fontFamily: fontFamily,
        ),
      ),
    );
  }
}
