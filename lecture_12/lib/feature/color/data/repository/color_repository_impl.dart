import 'package:dartz/dartz.dart';
import 'package:lecture_12/feature/color/data/data_source/local_color_datasource.dart';
import 'package:lecture_12/feature/color/domain/entity/color_entity.dart';
import 'package:lecture_12/feature/color/domain/entity/color_failure.dart';
import 'package:lecture_12/feature/color/domain/repository/color_repository.dart';

class ColorRepositoryImpl implements ColorRepository{
final LocalColorDatasource _localColorDatasource;

  ColorRepositoryImpl({required LocalColorDatasource localColorDatasource})
     : _localColorDatasource = localColorDatasource;

  @override
  Future<Either<ColorFailure, ColorEntity>> read() async {
    final result = await _localColorDatasource.read();

    return result.fold((failure) => Left(failure),
        (color) => Right(ColorEntity(color: color)));
  }

  @override
  Future<Either<ColorFailure, ColorEntity>> write(ColorEntity color) async {
    final result = await _localColorDatasource.write(color.color);

    return result.fold((failure) => Left(failure),
        (color) => Right(ColorEntity(color: color)));
  }
}