import 'package:clean_architecture_tdd/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_architecture_tdd/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:clean_architecture_tdd/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import 'get_concrete_number_trivia_test.mocks.dart';

class NumberTriviaRepositoryTest extends Mock
    implements NumberTriviaRepository {}

@GenerateMocks([NumberTriviaRepositoryTest])
Future<void> main() async {
  late MockNumberTriviaRepositoryTest numberTriviaRepository;
  late GetConcreteNumberTrivia usecase;

  setUp(() {
    numberTriviaRepository = MockNumberTriviaRepositoryTest();
    usecase = GetConcreteNumberTrivia(numberTriviaRepository);
  });

  const tNumber = 1;
  const tNumberTrivia = NumberTrivia(
    text: '12 much better than the rigid 10',
    number: 12,
  );

  test('should get trivia number from the repository', () async {
    // arrange
    when(numberTriviaRepository.getConcreteNumberTrivia(tNumber))
        .thenAnswer((_) async => const Right(tNumberTrivia));
    // act
    final result = await usecase.execute(number: tNumber);
    // assert
    expect(result, const Right(tNumberTrivia));
    verify(numberTriviaRepository.getConcreteNumberTrivia(tNumber));
  });
}
