import 'package:bloc/bloc.dart';
import 'package:clean_architecture_tdd/core/error/failures.dart';
import 'package:clean_architecture_tdd/core/usecases/usecase.dart';
import 'package:clean_architecture_tdd/core/util/input_converter.dart';
import 'package:clean_architecture_tdd/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_architecture_tdd/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:clean_architecture_tdd/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid Input - The number must be a positive integer or zero.';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetConcreteNumberTrivia concrete;
  final GetRandomNumberTrivia random;
  final InputConverter converter;

  NumberTriviaBloc({
    required this.concrete,
    required this.random,
    required this.converter,
  }) : super(Emtpy()) {
    on<GetTriviaForConcreteNumber>(_onGetTriviaForConcreteStarted);
    on<GetTriviaForRandomNumber>(_onGetTriviaForRandomStarted);
  }

  void _onGetTriviaForConcreteStarted(
    GetTriviaForConcreteNumber event,
    Emitter<NumberTriviaState> emit,
  ) async {
    try {
      final inputEither = converter.stringToUnsignedInteger(event.numberString);
      await inputEither.fold(
        (failure) {
          emit(Error(message: INVALID_INPUT_FAILURE_MESSAGE));
        },
        (integer) async {
          emit(Loading());
          final failureOrTrivia = await concrete(Params(number: integer));
          failureOrTrivia.fold(
            (failure) {
              emit(Error(message: _mapFailureToMessage(failure)));
            },
            (trivia) {
              emit(Loaded(trivia: trivia));
            },
          );
        },
      );
    } catch (e) {
      emit(Error(message: e.toString()));
    }
  }

  void _onGetTriviaForRandomStarted(
    GetTriviaForRandomNumber event,
    Emitter<NumberTriviaState> emit,
  ) async {
    emit(Loading());
    try {
      final failureOrTrivia = await random(NoParams());
      // failureOrTrivia.fold(
      //   (failure) {
      //     emit(Error(message: _mapFailureToMessage(failure)));
      //   },
      //   (trivia) {
      //     emit(Loaded(trivia: trivia));
      //   },
      // );
      _eitherLoadedOrErrorState(failureOrTrivia, emit);
    } catch (e) {
      emit(Error(message: e.toString()));
    }
  }

  void _eitherLoadedOrErrorState(Either<Failure, NumberTrivia> failureOrTrivia,
      Emitter<NumberTriviaState> emit) async {
    return await failureOrTrivia.fold(
      (failure) {
        emit(Error(message: _mapFailureToMessage(failure)));
      },
      (trivia) {
        emit(Loaded(trivia: trivia));
      },
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected error';
    }
  }
}
