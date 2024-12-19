import 'package:flutter/material.dart';
import 'package:lecture_6/page.dart';

class App1 extends StatelessWidget {
  const App1({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: Builder(
          builder: (context) {
            return Center(
              child: ElevatedButton(
                onPressed: () async {
                  final String? result = 
                    await Navigator.of(context).push<String>(
                      MaterialPageRoute(
                        builder:  (context) => const Page1(title: 'New title'),
                      ),
                    );
                    print(result);
                },
                child: Text('Open Page 1'),
              ),
            );
          }
        ),
      ),
    );
  }

}