import 'package:clean_architecture_tdd/core/usecases/usecase.dart';
import 'package:clean_architecture_tdd/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_architecture_tdd/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:clean_architecture_tdd/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
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
  late GetRandomNumberTrivia usecase;

  setUp(() {
    numberTriviaRepository = MockNumberTriviaRepositoryTest();
    usecase = GetRandomNumberTrivia(numberTriviaRepository);
  });

  const tNumberTrivia = NumberTrivia(
    text: '12 much better than the rigid 10',
    number: 12,
  );

  test('should get trivia from the repository', () async {
    // arrange
    when(numberTriviaRepository.getRandomNumberTrivia())
        .thenAnswer((_) async => const Right(tNumberTrivia));
    // act
    final result = await usecase(NoParams());
    // assert
    expect(result, const Right(tNumberTrivia));
    verify(numberTriviaRepository.getRandomNumberTrivia());
  });
}
