import 'package:flutter/material.dart';
import 'package:lecture_9/app_data.dart';
import 'package:lecture_9/app_data_provider.dart';
import 'package:lecture_9/inherited_page.dart';
import 'package:lecture_9/provider_page.dart';
import 'package:lecture_9/state_ful.dart';
import 'package:lecture_9/util.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppData(
        backgroundColor: Util.randomColor(),),
    // AppdataProvider(
    // appData: AppData(backgroundColor: Util.randomColor()),
    child: MaterialApp(
      routes: {
        // '/': (context) => const InheritedPage(),
        // '/second': (context) => const InheritedPage(),
        '/': (context) => const ProviderPage(),
        '/second': (context) => const ProviderPage(),
      },
    ),
  ));
}