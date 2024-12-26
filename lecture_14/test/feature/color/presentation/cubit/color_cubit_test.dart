import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lecture_12/feature/color/domain/entity/color_entity.dart';
import 'package:lecture_12/feature/color/domain/entity/color_failure.dart';
import 'package:lecture_12/feature/color/domain/usecase/get_color_use_case.dart';
import 'package:lecture_12/feature/color/domain/usecase/select_color_use_case.dart';
import 'package:lecture_12/feature/color/presentation/cubit/color_cubit.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';  // Import bloc_test// Import flutter_bloc

class MockSelectColorUseCase extends Mock implements SelectColorUseCase {}

class MockGetColorUseCase extends Mock implements GetColorUseCase {}

class ColorEntityFake extends Fake implements ColorEntity{}

void main() {
  setUpAll((){
      registerFallbackValue(ColorEntityFake());
  });
  group('Кубит тест:', () {
    
    blocTest('Проверка начального состояния кубита (Успешная проверка)', build: () {
      final SelectColorUseCase selectColorUseCase = MockSelectColorUseCase();
      final GetColorUseCase getColorUseCase = MockGetColorUseCase();

      final ColorEntity colorEntity = 
        ColorEntity(color: Colors.black.value.toString());

      when(() => getColorUseCase.call()).thenAnswer((invocation) async => Right<ColorFailure, ColorEntity>(colorEntity));

      return ColorCubit(selectColorUseCase, getColorUseCase);
    },
    expect: () => [
      ColorCurrentState(color: Colors.black)
    ]);

    blocTest('Успешное сохранение цвета', build: (){
      final SelectColorUseCase selectColorUseCase = MockSelectColorUseCase();
      final GetColorUseCase getColorUseCase = MockGetColorUseCase();

      final ColorEntity colorEntity = 
        ColorEntity(color: Colors.black.value.toString());

      final ColorEntity newColorEntity = 
        ColorEntity(color: Color.fromARGB(211, 223, 69, 69).value.toString());

      when(() => getColorUseCase.call()).thenAnswer(
        (invocation) async => Right<ColorFailure, ColorEntity>(colorEntity));

      when(() => selectColorUseCase.call(any())).thenAnswer(
        (invocation) async => Right<ColorFailure, ColorEntity>(newColorEntity));

      return ColorCubit(selectColorUseCase, getColorUseCase);
    },
    act: (cubit)=> cubit.setColor( Color.fromARGB(211, 223, 69, 69)),
    expect: () => [
      ColorCurrentState(color: Colors.black),
      ColorCurrentState(color: Color.fromARGB(211, 223, 69, 69)),
    ],
    );
  }
  
  );
}