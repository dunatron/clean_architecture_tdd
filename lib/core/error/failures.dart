import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  Failure([List properties = const <dynamic>[]]);

  @override
  List<Object?> get props => [];
}

// abstract class Failure extends Equatable {}

class ServerFailure extends Failure {}

class CacheFailure extends Failure {}

// abstract class Failure {}

// class ServerFailure extends Failure {}

// class CacheFailure extends Failure {}
