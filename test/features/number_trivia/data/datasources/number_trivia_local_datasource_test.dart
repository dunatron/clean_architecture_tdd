import 'dart:convert';

import 'package:clean_architecture_tdd/core/error/exceptions.dart';
import 'package:clean_architecture_tdd/features/number_trivia/data/datasources/number_trivia_local_datasource.dart';
import 'package:clean_architecture_tdd/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/annotations.dart';
import '../../../../fixtures/fixture_reader.dart';
import 'number_trivia_local_datasource_test.mocks.dart';

class MockHiveInterface extends Mock implements HiveInterface {}

class HiveBoxTest extends Mock implements Box {}

@GenerateMocks([HiveBoxTest])
void main() {
  late NumberTriviaLocalDataSourceImpl datasource;
  late MockHiveBoxTest mockBox;

  setUp(() {
    mockBox = MockHiveBoxTest();
    datasource = NumberTriviaLocalDataSourceImpl(box: mockBox);
  });

  group('getLastNumberTrivia', () {
    final tNumberTriviaModel =
        NumberTriviaModel.fromJson(json.decode(fixture('trivia_cached.json')));
    test(
        'should return NumberTriviaModel from Hive when there is one in the cache',
        () async {
      // arrange
      when(mockBox.get(CACHED_NUMBER_TRIVIA)).thenReturn(
        fixture('trivia_cached.json'),
      );
      // act
      final result = await datasource.getLastNumberTrivia();
      // assert
      verify(mockBox.get(CACHED_NUMBER_TRIVIA));
      expect(result, tNumberTriviaModel);
    });

    test('should throw a CacheException when there is not a cached value',
        () async {
      // arrange
      when(mockBox.get(CACHED_NUMBER_TRIVIA)).thenReturn(
        null,
      );
      // act
      // below is just setting it to a variable so we can call it later
      // so the code is smaller and easier to read
      final call = datasource.getLastNumberTrivia;
      // assert
      expect(() => call(), throwsA(isA<CacheException>()));
    });
  });

  group('cacheNumberTrivia', () {
    const tNumberTriviaModel =
        NumberTriviaModel(number: 12, text: 'The best number didnt you know?');
    test('should call box.put with the key and the value', () {
      // // act
      // datasource.cacheNumberTrivia(tNumberTriviaModel);
      // // assert
      // verify(
      //     mockBox.put(CACHED_NUMBER_TRIVIA, json.encode(tNumberTriviaModel)));
      // expect(mockBox.put(CACHED_NUMBER_TRIVIA, json.encode(tNumberTriviaModel)),
      //     completes);

      // act
      datasource.cacheNumberTrivia(tNumberTriviaModel);
      // assert
      final expectedJsonString = json.encode(tNumberTriviaModel.toJson());
      verify(mockBox.put(CACHED_NUMBER_TRIVIA, expectedJsonString));
    });
  });
}
