import 'package:flutter/material.dart';
import 'package:lecture_9/app_data.dart';

class AppdataProvider extends InheritedWidget {
  const AppdataProvider({required this.appData, super.key, required super.child});

  final AppData appData;
  
  static AppdataProvider? of(BuildContext context) =>
    context.dependOnInheritedWidgetOfExactType<AppdataProvider>();

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }

}