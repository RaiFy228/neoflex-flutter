import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
      theme: ThemeData(fontFamily: 'Secession'),
      home: const MyHomePage(),
      
  ));
}
class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Fonts'),
        centerTitle: true,
      ),
      body: const Align(
        alignment: Alignment.center,
        child: Text(
          'Hombre Regular',
          style: TextStyle(fontFamily: 'Hombre Regular', fontSize: 22),
        ),
      ),
    );
  }
}

class ScaffoldPage extends StatelessWidget {
  const ScaffoldPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Лекция 2'),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.only(top: 25),
        child: Text(
          "Hello World",
          style: TextStyle(fontSize: 22, color: Colors.black87),
          textDirection: TextDirection.ltr,
        ),
      ),
    );
  }
}



class MyStatelessWidget extends StatelessWidget {
  const MyStatelessWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
    );
  }
}

class Counter extends StatefulWidget {
  const Counter({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int value = 0;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        child: Text("Value: $value", style: TextStyle(fontSize: 22)),
        onPressed: () {
          setState(() {
            value++;
          });
        });
  }
}
