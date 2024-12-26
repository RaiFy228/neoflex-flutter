import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:lecture_12/feature/color/data/data_source/local_color_datasource.dart';
import 'package:lecture_12/feature/color/domain/entity/color_failure.dart';
import 'package:path_provider/path_provider.dart';

class FileLocalColorDatasource implements LocalColorDatasource{
  @override
  Future<Either<ColorFailure, String>> read() async {
    try {
      final color = await readData();

      return Right(color);
    } catch (e) {
      return Left(ColorFailure(code: 1, message: e.toString()));
    }
  }

  @override
  Future<Either<ColorFailure, String>> write(String color) async {
    try {
      await writeData(color);

      return Right(color);
    } catch (e) {
      return Left(ColorFailure(code: 1, message: e.toString()));
    }
  }

  Future<String> get _localPath async {
    final directory = await getApplicationCacheDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;

    return File('$path/color.txt');
  }

  Future<File> writeData(String data) async {
    final file = await _localFile;

    return file.writeAsString(data);
  }

  Future<String> readData() async {
    final file = await _localFile;

    if (!file.existsSync()){
      file.writeAsString('0xFFFFFFFF');
    }
    
    return await file.readAsString();
  }

}