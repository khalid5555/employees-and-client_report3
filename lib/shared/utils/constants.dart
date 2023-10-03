import 'dart:math';

import 'package:flutter/material.dart';

const double defaultPadding = 16.0;
const Duration defaultDuration = Duration(milliseconds: 400);
final color = Random();
int colors = 0xff000000;
Color recolor() {
  return Color(color.nextInt(colors));
}


class Utils {
  Size getScreenSize() {
    return MediaQueryData.fromView(WidgetsBinding.instance.window).size;
  }
}