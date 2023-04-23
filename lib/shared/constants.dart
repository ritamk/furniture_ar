// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

const Color buttonCol = Color.fromARGB(255, 55, 55, 55);
const Color buttonTextCol = Color.fromARGB(255, 255, 255, 255);
const Color formFieldCol = Color.fromARGB(255, 219, 219, 219);

const List<String> FURNITURE_TYPE_LIST = <String>[
  "chair",
  "table",
  "bed",
  "sofa",
  "lights",
];

String capitaliseText(String word) {
  return word[0].toUpperCase() + word.substring(1);
}
