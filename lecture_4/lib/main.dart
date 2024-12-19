import 'package:flutter/material.dart';
import 'package:lecture_4/column_demo.dart';
import 'package:lecture_4/container_demo.dart';
import 'package:lecture_4/listview_demo.dart';
import 'package:lecture_4/row_demo.dart';
import 'package:lecture_4/stack_demo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});@override

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: ListviewDemo(),
    );
  }}