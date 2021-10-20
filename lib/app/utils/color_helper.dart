import 'package:flutter/material.dart';

Color createColorFromHex(String hexColor) {
  var hexCode = hexColor.replaceAll('#', '');
  if (hexCode.length == 3) {
    hexCode =
        '${hexCode[0]}${hexCode[0]}${hexCode[1]}${hexCode[1]}${hexCode[2]}${hexCode[2]}';
  }
  return Color(int.parse('FF$hexCode', radix: 16));
}
