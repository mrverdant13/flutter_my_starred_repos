import 'package:dartz/dartz.dart';

abstract class FutureUseCase<FailureType, ReturnType, ParamsType> {
  const FutureUseCase();

  Future<Either<FailureType, ReturnType>> call(ParamsType params);
}
