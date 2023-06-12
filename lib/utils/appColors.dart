// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, file_names

import 'package:flutter/material.dart';
import 'dart:async';

class AppColors {
  static Color primaryColor = Color(0xff1D2E8D);
  static Color secondColor = Color(0xff111F70);
  static Color textColorBlack = Color(0xff303030);
  static Color titleColorBlack = Color(0xff101010);
  static Color textColorRed = Color(0xffA63C3C);
  static Color textColorBlue = Color(0xff4D5FC5);
  static Color textColorGrey = Color(0xff9A9A9A);
  static Color textColorGrey2 = Color(0xff5A5A5A);
  static Color containerColorBlack = Color(0xff010118);
  static Color containerColorWhite = Color(0xffF6F6FA);
  static Color primaryOpacityColor = Color.fromARGB(255, 229, 231, 248);
  static Color yellow = Color.fromARGB(255, 255, 251, 0);
  static Color green = Color.fromARGB(255, 0, 255, 42);
  static Color blue = Color.fromARGB(255, 0, 183, 255);
  static Color purple = Color.fromARGB(255, 84, 0, 122);
  static Color red = Color.fromARGB(255, 255, 0, 0);
  static Gradient colorDegrade = LinearGradient(
      colors: [Color(0xff4D5FC5), Color(0xff1D2E8D)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter);
  static Gradient colorDegradeRed = LinearGradient(colors: [
    Color.fromARGB(255, 165, 65, 65),
    Color.fromARGB(255, 167, 43, 43)
  ], begin: Alignment.topCenter, end: Alignment.bottomCenter);
}

Future<Color> retCorFicha(String status) {
  Completer<Color> completer = Completer<Color>();

  switch (status) {
    case 'Em aberto':
      completer.complete(Colors.green);
      break;
    case 'Orçamento':
      completer.complete(Colors.blue);
      break;
    case 'Em execução':
      completer.complete(Colors.yellow);
      break;
    case 'Fechado':
      completer.complete(Colors.black);
      break;
    case 'Cancelado':
      completer.complete(Colors.red);
      break;
    default:
      completer.complete(Colors.green);
      break;
  }

  return completer.future;
}
