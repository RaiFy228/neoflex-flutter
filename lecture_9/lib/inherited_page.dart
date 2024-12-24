import 'package:flutter/material.dart';
import 'package:lecture_9/app_data_provider.dart';
import 'package:lecture_9/util.dart';

class InheritedPage extends StatefulWidget {
  const InheritedPage({super.key});

  @override
  State<StatefulWidget> createState() => _InheritedPage();
}

class _InheritedPage extends State<StatefulWidget> {
  @override
  Widget build(BuildContext context) {
    var data = AppdataProvider.of(context);
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: ListenableBuilder(
            listenable: data!.appData,
            builder: (context, child) {
              return Container(
                width: 200,
                height: 200,
                color: data.appData.backgroundColor,
                child: Column(
                  children: [
                    Text(data.appData.backgroundColor.toString()),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            data.appData
                                .changeBackgroundColor(Util.randomColor());
                          });
                        },
                        child: const Text('Change color')),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed('/second');
                        },
                        child: const Text('Second Page'))
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
