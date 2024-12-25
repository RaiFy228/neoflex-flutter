import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lecture_10/bloc/color_bloc.dart';

final colorBloc = ColorBloc();

class BlocPage extends StatelessWidget {
  const BlocPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: colorBloc,
      child: Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: Center(
            child: BlocBuilder<ColorBloc, ColorState>(builder: (context, state) {
              return Column(
                children: [
                  Container(
                    width: 200,
                    height: 300,
                    color: state.color,
                    child: Column(
                      children: [
                        Text(state.color.toString()),
                        ElevatedButton(
                            onPressed: () {
                              context
                                  .read<ColorBloc>()
                                  .add(NewRandomColorEvent());
                            },
                            child: Text('Set random color')),
                        ElevatedButton(
                            onPressed: () {
                              context
                                  .read<ColorBloc>()
                                  .add(ResetColorEvent());
                            },
                            child: Text('Reset color')),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed('/second');
                            },
                            child: Text('Second page'))
                      ],
                    ),
                  ),
                  ColorPicker(onColorChanged: (color) {
                    state.color;
                    context.read<ColorBloc>().add(NewColorEvent(color: color));
                  })
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}