import 'package:flutter/material.dart';

class App2 extends StatelessWidget {
  const App2({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) {
          return Page1();
        },
        '/page2': (context) {
          final arguments = (ModalRoute.of(context)?.settings.arguments ??
              <String, dynamic>{}) as Map;
          return Page2(title: arguments['title']);
        }
      },
    );
  }
}

class Page1 extends StatelessWidget {
  const Page1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          children: [
            Text('Page 1'),
            ElevatedButton(
              onPressed: () async {
                Navigator.pushNamed(context, '/page2',
                    arguments: {'title': 'New title2'});
              },
              child: Text('Go to Page2'),
            ),
          ],
        ),
      ),
    );
  }
}

class Page2 extends StatelessWidget {
  const Page2({super.key, required title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          children: [
            Text('Page 2'),
            ElevatedButton(
              onPressed: () async {
                Navigator.pushNamed(context, '/');
              },
              child: Text('Return')),
          ],
        ),
      ),
    );
  }

}