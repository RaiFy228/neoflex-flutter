import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lecture_10/util.dart';

part 'color_event.dart';
part 'color_state.dart';

class ColorBloc extends Bloc<ColorEvent, ColorState> {
  ColorBloc() : super(const ColorInitialState()) {
    on<NewColorEvent>(onNewColorEvent);
    on<NewRandomColorEvent>(onNewRandomColorEvent);
    on<ResetColorEvent>(onResetColorEvent);
  }

  void onNewColorEvent(NewColorEvent event, Emitter<ColorState> emit) {
    emit(ColorCurrentState(event.color));
  }

  void onNewRandomColorEvent(NewRandomColorEvent event, Emitter<ColorState> emit) {
    emit(ColorCurrentState(Util.randomColor()));
  }

  void onResetColorEvent(ResetColorEvent event, Emitter<ColorState> emit) {
    emit(ColorInitialState());
  }
}
