import 'dart:math';

import 'package:flutter/material.dart';

class ContainerDemo extends StatelessWidget {
  const ContainerDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      width: 300,
      height: 300,
      padding: EdgeInsets.all(50),
      foregroundDecoration: BoxDecoration(color: Colors.amber.withAlpha(100)),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.all(Radius.circular(16)),
            gradient: LinearGradient(colors: [
              Colors.pink,
              Colors.yellow,
            ]),
            boxShadow: [BoxShadow(color: Colors.grey, offset: Offset(15, 25))]),
        transform: Matrix4.skewY(0.3)..rotateZ(pi / 12),
      ),
    );
  }
}
