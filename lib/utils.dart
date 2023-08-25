
import 'package:flutter/material.dart';
import 'dart:math';

class Utils {

  static String capitalizeFirstLetter(String? text) {
    if (text == null || text.isEmpty) {
      return ""; 
    } else {
      return text[0].toUpperCase() + text.substring(1);
    }
  }

  static Color generateRandomColor() {
    final random = Random();
    final r = random.nextInt(256); // Valeurs entre 0 et 255
    final g = random.nextInt(256);
    final b = random.nextInt(256);
    return Color.fromARGB(255, r, g, b);
  }
}