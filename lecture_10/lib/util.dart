import 'dart:math';
import 'package:flutter/material.dart';

class Util {
  // Метод для генерации случайного цвета
  static Color randomColor() {
    return Color(Random().nextInt(0xFFFFFFFF));
  }
}