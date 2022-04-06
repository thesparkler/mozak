import 'dart:ui';

import 'package:flutter/material.dart';




Color hexToColor(String code) {
  return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
}

String capitalizeFirstLetter(String text) {
  final String firstLetter = text.trim().substring(0, 1).toUpperCase();
  final remainingLetters = text.trim().substring(1);
  String combinedText = firstLetter + remainingLetters;
  return combinedText;
}