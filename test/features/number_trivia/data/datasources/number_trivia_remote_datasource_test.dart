import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:clean_architecture_tdd/core/error/exceptions.dart';
import 'package:clean_architecture_tdd/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import '../../../../fixtures/fixture_reader.dart';
import 'package:clean_architecture_tdd/features/number_trivia/data/datasources/number_trivia_remote_datasource.dart';

import 'number_trivia_remote_datasource_test.mocks.dart';

@GenerateMocks([HttpClientTest])
class HttpClientTest extends Mock implements http.Client {}

void main() {
  late NumberTriviaRemoteDataSourceImpl datasource;
  late MockHttpClientTest mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClientTest();
    datasource = NumberTriviaRemoteDataSourceImpl(client: mockHttpClient);
  });

  void setUpMockHttpClientSuccess200() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(fixture('trivia.json'), 200));
  }

  void setUpMockHttpClientFailure404() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  group('getConcreteNumberTrivia', () {
    final tNumber = 1;
    final tNumberTriviaModel =
        NumberTriviaModel.fromJson(json.decode(fixture('trivia.json')));

    test('''should perform a GET request on a URL with number
      being the endpoint and with application/json header''', () async {
      // arrange
      setUpMockHttpClientSuccess200();
      // act
      datasource.getConcreteNumberTrivia(tNumber);
      // assert
      verify(mockHttpClient.get(
        Uri.parse('http://numbersapi.com/$tNumber'),
        headers: {'Content-Type': 'application/json'},
      ));
    });

    test('should return NumberTrivia when the response is 200 (success)',
        () async {
      // arrange
      setUpMockHttpClientSuccess200();
      // act
      final result = await datasource.getConcreteNumberTrivia(tNumber);
      // assert
      expect(result, equals(tNumberTriviaModel));
    });

    test('should throw a ServerException when the response is 404 or other',
        () async {
      // arrange
      setUpMockHttpClientFailure404();
      // act
      final call = datasource.getConcreteNumberTrivia;
      // assert
      expect(() => call(tNumber), throwsA(isInstanceOf<ServerException>()));
      // expect(
      //     () => call(tNumber), throwsA(const TypeMatcher<ServerException>()));
    });
  });

  group('getRandomNumberTrivia', () {
    final tNumberTriviaModel =
        NumberTriviaModel.fromJson(json.decode(fixture('trivia.json')));

    test('''should perform a GET request on a URL with number
      being the endpoint and with application/json header''', () async {
      // arrange
      setUpMockHttpClientSuccess200();
      // act
      datasource.getRandomNumberTrivia();
      // assert
      verify(mockHttpClient.get(
        Uri.parse('http://numbersapi.com/random'),
        headers: {'Content-Type': 'application/json'},
      ));
    });

    test('should return NumberTrivia when the response is 200 (success)',
        () async {
      // arrange
      setUpMockHttpClientSuccess200();
      // act
      final result = await datasource.getRandomNumberTrivia();
      // assert
      expect(result, equals(tNumberTriviaModel));
    });

    test('should throw a ServerException when the response is 404 or other',
        () async {
      // arrange
      setUpMockHttpClientFailure404();
      // act
      final call = datasource.getRandomNumberTrivia;
      // assert
      expect(() => call(), throwsA(isInstanceOf<ServerException>()));
      // expect(
      //     () => call(tNumber), throwsA(const TypeMatcher<ServerException>()));
    });
  });
}
