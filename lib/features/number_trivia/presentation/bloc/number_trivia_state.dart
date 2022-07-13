part of 'number_trivia_bloc.dart';

abstract class NumberTriviaState extends Equatable {
  const NumberTriviaState();

  @override
  List<Object> get props => [];
}

class Emtpy extends NumberTriviaState {}

class Loading extends NumberTriviaState {}

class Loaded extends NumberTriviaState {
  final NumberTrivia trivia;

  const Loaded({required this.trivia});

  @override
  List<Object> get props => [trivia];
}

/// will be trigerred whenever an error occurrs during the fetching of the data.
///
/// e.g a CacheException, CacheFailure, ServerException, ServerFailure.
/// basically whenever somethinggoes wrong this gets passed to the ui
class Error extends NumberTriviaState {
  final String message;

  const Error({required this.message});

  @override
  List<Object> get props => [message];
}
