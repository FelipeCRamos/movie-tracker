import 'package:fpdart/fpdart.dart';
import 'package:movie_tracker/core/error/failure.dart';

abstract interface class UseCase<Output, Params> {
  Future<Either<Failure, Output>> call(Params params);
}

class NoParams {
  const NoParams();
}
