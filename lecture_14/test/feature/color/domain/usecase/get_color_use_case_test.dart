import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:lecture_12/feature/color/domain/entity/color_entity.dart';
import 'package:lecture_12/feature/color/domain/entity/color_failure.dart';
import 'package:lecture_12/feature/color/domain/repository/color_repository.dart';
import 'package:lecture_12/feature/color/domain/usecase/get_color_use_case.dart';
import 'package:mocktail/mocktail.dart'; // For the Right/Left types// Replace with actual path

// Mock class for ColorRepository
class MockColorRepository extends Mock implements ColorRepository {}

void main() {
  group('GetColorUseCase tests:', () {
    ColorRepository colorRepository = MockColorRepository();
    setUpAll(() {
      // ignore: avoid_print
      print('setUpAll');
    });
    setUp(() {
      // ignore: avoid_print
      print('setUp');
    });

    test('При успешном получении цвета должен возвращать цвет', () async {
      GetColorUseCase getColorUseCase = GetColorUseCase(colorRepository: colorRepository);
      final colorEntity = ColorEntity(color: Colors.black.value.toString());
      when(() => colorRepository.read()).thenAnswer((_) async {
        return Right<ColorFailure, ColorEntity>(colorEntity);
      });

      final result = await getColorUseCase.call();

      verify(() => colorRepository.read()).called(1);

      expect(result, equals(Right<ColorFailure, ColorEntity>(colorEntity)));
    });

     test('При успешном получении цвета должен возвращася failure', () async {
      GetColorUseCase getColorUseCase = GetColorUseCase(colorRepository: colorRepository);
      final ColorFailure failure = ColorFailure(code: 1);
      when(() => colorRepository.read()).thenAnswer((_) async {
        return Left<ColorFailure, ColorEntity>(failure);
      });

      final result = await getColorUseCase.call();

      verify(() => colorRepository.read()).called(1);

      expect(result, equals(Left<ColorFailure, ColorEntity>(failure)));
    });
  });
}
