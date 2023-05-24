import 'package:flutter/material.dart';

class AppDecorations {
  static defaultDeco({double? radius, Color? color}) => BoxDecoration(
        borderRadius: BorderRadius.circular(radius ?? 10),
        color: color,
      );
}
