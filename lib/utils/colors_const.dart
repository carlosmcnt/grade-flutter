import 'package:flutter/material.dart';

class ColorsConst {

  static const int indigo500 = 0xFF3F51B5;

  static const MaterialColor indigo = MaterialColor(indigo500, <int, Color>{
    50: Color(0xFFE8EAF6),
    100: Color(0xFFC5CAE9),
    200: Color(0xFF9FA8DA),
    300: Color(0xFF7986CB),
    400: Color(0xFF5C6BC0),
    500: Color(indigo500),
    600: Color(0xFF3949AB),
    700: Color(0xFF303F9F),
    800: Color(0xFF283593),
    900: Color(0xFF1A237E),
  });

  static const int roxo500 = 0xFF9C27B0;

  static const MaterialColor purple = MaterialColor(roxo500, <int, Color>{
    50: Color(0xFFF3E5F5),
    100: Color(0xFFE1BEE7),
    200: Color(0xFFCE93D8),
    300: Color(0xFFBA68C8),
    400: Color(0xFFAB47BC),
    500: Color(roxo500),
    600: Color(0xFF8E24AA),
    700: Color(0xFF7B1FA2),
    800: Color(0xFF6A1B9A),
    900: Color(0xFF4A148C),
  });

  static const int cinza500 = 0xFF607D8B;

  static const MaterialColor blueGray = MaterialColor(cinza500, <int, Color>{
    50: Color(0xFFECEFF1),
    100: Color(0xFFCFD8DC),
    200: Color(0xFFB0BEC5),
    300: Color(0xFF90A4AE),
    400: Color(0xFF78909C),
    500: Color(cinza500),
    600: Color(0xFF546E7A),
    700: Color(0xFF455A64),
    800: Color(0xFF37474F),
    900: Color(0xFF263238),
  });

  static const int azulClaro500 = 0xFF03A9F4;

  static const MaterialColor lightBlue = MaterialColor(azulClaro500, <int, Color>{
    50: Color(0xFFE1F5FE),
    100: Color(0xFFB3E0FC),
    200: Color(0xFF81D4FA),
    300: Color(0xFF4FC3F7),
    400: Color(0xFF29B6F6),
    500: Color(azulClaro500),
    600: Color(0xFF039BE5),
    700: Color(0xFF0288D1),
    800: Color(0xFF0277BD),
    900: Color(0xFF01579B),
  });

}