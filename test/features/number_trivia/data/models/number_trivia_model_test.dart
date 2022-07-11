import 'dart:convert';

import 'package:clean_architecture_tdd/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:clean_architecture_tdd/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tNumnerTriviaModel = NumberTriviaModel(
      number: 12, text: 'The number 12 is far better than 10');

  test('should be a subclass of NumberTrivia entity', () async {
    // assert
    expect(tNumnerTriviaModel, isA<NumberTrivia>());
  });

  group('fromJson', () {
    // assert
    test(
      'should return a valid model when the JSON number is an integer',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('trivia.json'));
        // act
        final result = NumberTriviaModel.fromJson(jsonMap);
        // assert
        expect(result, tNumnerTriviaModel);
      },
    );

    test(
      'should return a valid model when the JSON number is a double',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('trivia_double.json'));
        // act
        final result = NumberTriviaModel.fromJson(jsonMap);
        // assert
        expect(result, tNumnerTriviaModel);
      },
    );
  });

  group('toJson', () {
    // assert
    test(
      'should return a JSON map containing the proper data',
      () async {
        // act
        final result = tNumnerTriviaModel.toJson();
        // assert
        final expectedMap = {
          "text": "The number 12 is far better than 10",
          "number": 12,
        };
        expect(result, expectedMap);
      },
    );
  });
}
