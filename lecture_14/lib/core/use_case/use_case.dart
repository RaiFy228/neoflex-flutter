import 'package:dartz/dartz.dart';
import 'package:lecture_12/core/failure/failure.dart';

// Используем типы для ошибок и успешных значений
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}


abstract class UseCaseNoParams<Type> {
  Future<Either<Failure, Type>> call();
}