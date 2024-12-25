import 'package:flutter/material.dart';
// import 'package:lecture_10/bloc_page.dart';
import 'package:lecture_10/cubit_page.dart';


void main() {
  runApp(MaterialApp(
    routes: {
      '/': (context) => CubitPage(),
      '/second': (context) => CubitPage(),
    },
  ));
}
