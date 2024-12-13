import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
      title: 'Flutter Demo',
      home: const PositionedTile(),
    )
  );
}

class PositionedTile extends StatefulWidget {
  const PositionedTile({super.key});

  @override
  State<PositionedTile> createState() => _PositionedTileState();
}

class _PositionedTileState extends State<PositionedTile> {
  late List<Widget> tiles;

  @override
  void initState() {
    super.initState();
    tiles = [
      StatefullColorTile(key: UniqueKey()),
      StatefullColorTile(key: UniqueKey())
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: tiles,
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: swapTiles,
          child: const Icon(
            Icons.switch_access_shortcut,
          )),
    );
  }

  void swapTiles() {
    setState(() {
      tiles.insert(1, tiles.removeAt(0));
    });
  }
}

class StatefullColorTile extends StatefulWidget {
  const StatefullColorTile({super.key});

  @override
  State<StatefullColorTile> createState() => _StatelfulColorfulTileState();
}

class _StatelfulColorfulTileState extends State<StatefullColorTile> {
  late Color color;

  @override
  void initState() {
    super.initState();
    color = Colors.primaries[Random().nextInt(Colors.primaries.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Container(width: 100, height: 100, color: color);
  }
}