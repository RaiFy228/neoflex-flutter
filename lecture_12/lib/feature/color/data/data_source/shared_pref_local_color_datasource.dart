import 'package:dartz/dartz.dart';
import 'package:lecture_12/feature/color/data/data_source/local_color_datasource.dart';
import 'package:lecture_12/feature/color/domain/entity/color_failure.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefLocalColorDataSource implements LocalColorDatasource {
  @override
  Future<Either<ColorFailure, String>> read() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final color = prefs.getString('color') ?? '0xFFFFFFFF';
      return Right(color);
    } catch (e) {
      return Left(ColorFailure(code: 1, message: e.toString()));
    }
  }

  @override
  Future<Either<ColorFailure, String>> write(String color) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('color', color);
      return Right(prefs.getString('color') ?? '0xFFFFFFFF');
    } catch (e) {
      return Left(ColorFailure(code: 1, message: e.toString()));
    }
  }
}