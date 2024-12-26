import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lecture_12/feature/color/domain/entity/color_entity.dart';
import 'package:lecture_12/feature/color/domain/usecase/get_color_use_case.dart';
import 'package:lecture_12/feature/color/domain/usecase/select_color_use_case.dart';
part 'color_state.dart';

class ColorCubit extends Cubit<ColorState> {
  final SelectColorUseCase _selectColorUseCase;
  final GetColorUseCase _getColorUseCase;

  ColorCubit(this._selectColorUseCase, this._getColorUseCase)
      : super(ColorCurrentState(color: Colors.transparent, isLoading: true)) {
    getColor();
  }

  void getColor() async {
    emit(ColorCurrentState(color: state.color, isLoading: true));
    final result = await _getColorUseCase();
    result.fold(
      (failure) => emit(ColorCurrentState(
        color: state.color,
        isLoading: false,
        error: failure.getLocalizedString(),
      )),
      (entity) => emit(ColorCurrentState(
        color: Color(int.tryParse(entity.color) ?? 0xFFFFFFFF),
        isLoading: false,
      )),
    );
  }

  void setColor(Color color) async{
    emit(ColorCurrentState(color: state.color, isLoading: true));

    final result = await _selectColorUseCase(ColorEntity(color: color.value.toString()));
    result.fold(
      (failure) => emit(ColorCurrentState(
        color: state.color,
        isLoading: false,
        error: failure.getLocalizedString(),
      )),
      (entity) => emit(ColorCurrentState(
        color: Color(int.tryParse(entity.color) ?? 0xFFFFFFFF),
        isLoading: false,
      )),
    );

  }
}
