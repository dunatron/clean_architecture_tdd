import 'package:clean_architecture_tdd/core/util/input_converter.dart';
import 'package:clean_architecture_tdd/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_architecture_tdd/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:clean_architecture_tdd/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:clean_architecture_tdd/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import 'number_trivia_bloc_test.mocks.dart';
import 'package:bloc_test/bloc_test.dart';

@GenerateMocks([GetConcreteNumberTriviaTest])
class GetConcreteNumberTriviaTest extends Mock
    implements GetConcreteNumberTrivia {}

@GenerateMocks([GetRandomNumberTriviaTest])
class GetRandomNumberTriviaTest extends Mock implements GetRandomNumberTrivia {}

@GenerateMocks([InputConverterTest])
class InputConverterTest extends Mock implements InputConverter {}

@GenerateMocks([ParamsTest])
class ParamsTest extends Mock implements Params {}

void main() {
  late NumberTriviaBloc bloc;
  late MockGetConcreteNumberTriviaTest mockGetConcreteNumberTrivia;
  late MockGetRandomNumberTriviaTest mockGetRandomNumberTrivia;
  late MockInputConverterTest mockInputConverter;
  late MockParamsTest mockParams;

  setUp(() {
    mockGetConcreteNumberTrivia = MockGetConcreteNumberTriviaTest();
    mockGetRandomNumberTrivia = MockGetRandomNumberTriviaTest();
    mockInputConverter = MockInputConverterTest();
    bloc = NumberTriviaBloc(
      concrete: mockGetConcreteNumberTrivia,
      random: mockGetRandomNumberTrivia,
      converter: mockInputConverter,
    );
    mockParams = MockParamsTest();
  });

  test('initial state should be empty', () {
    expect(bloc.state, equals(Emtpy()));
  });

  group('GetTriviaForConcreteNumber', () {
    const tNumberString = '1';
    const tNumberParsed = 1;
    const tNumberTrivia = NumberTrivia(number: 1, text: 'test trivia');

    // test(
    //     'should call the InputConverter to validate and covert the string to an unsigned integer',
    //     () async {
    //   // arrange
    //   when(mockInputConverter.stringToUnsignedInteger(any))
    //       .thenReturn(const Right(tNumberParsed));
    //   // act
    //   bloc.add(GetTriviaForConcreteNumber(tNumberString));
    //   await untilCalled(mockInputConverter.stringToUnsignedInteger(any));
    //   // assert
    //   verify(mockInputConverter.stringToUnsignedInteger(tNumberString));
    // });

    when(mockInputConverter.stringToUnsignedInteger(any))
        .thenReturn(const Right(tNumberParsed));
    when(mockParams.number).thenReturn(tNumberParsed);
    blocTest<NumberTriviaBloc, NumberTriviaState>(
      'emits [1] when increment is called',
      build: () => bloc,
      act: (blocInstance) =>
          blocInstance.add(GetTriviaForConcreteNumber(tNumberString)),
      expect: () => [Emtpy(), Error(message: INVALID_INPUT_FAILURE_MESSAGE)],
    );

    // No idea why the below does not run
    // test('should emit error when the input is invalid', () async {
    //   // arrange
    //   when(mockInputConverter.stringToUnsignedInteger(any))
    //       .thenReturn(Left(InvalidInputFailure()));

    //   // assert later

    //   // act
    //   bloc.add(GetTriviaForConcreteNumber(tNumberString));

    //   final expected = [
    //     Emtpy(),
    //     Error(message: INVALID_INPUT_FAILURE_MESSAGE),
    //   ];
    //   expectLater(bloc.state, emitsInOrder(expected));
    // });
  });
}
