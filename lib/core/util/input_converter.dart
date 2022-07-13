import 'package:clean_architecture_tdd/core/error/failures.dart';
import 'package:dartz/dartz.dart';

// NOTE MAY NEED STUFF DONE for equatable, check around 13 mins
// Flutter TDD Clean Architecture Course [10] – Bloc Scaffolding & Input Conversion
class InputConverter {
  Either<Failure, int> stringToUnsignedInteger(String str) {
    try {
      final int integer = int.parse(str);
      if (integer < 0) {
        throw const FormatException();
      }
      return Right(integer);
    } on FormatException {
      return Left(InvalidInputFailure());
    }
  }
}

class InvalidInputFailure extends Failure {}
