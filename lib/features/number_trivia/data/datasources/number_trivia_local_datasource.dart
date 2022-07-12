import 'dart:convert';

import 'package:clean_architecture_tdd/core/error/exceptions.dart';
import 'package:hive/hive.dart';

import '../models/number_trivia_model.dart';

abstract class NumberTriviaLocalDataSource {
  /// Gets the cached [NumberTriviaModel] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws a [CacheFailure] if no cached data is present.
  Future<NumberTriviaModel> getLastNumberTrivia();

  /// Saves the given [NumberTriviaModel] to the cache.
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache);
}

// ignore: constant_identifier_names
const String CACHED_NUMBER_TRIVIA = 'CACHED_NUMBER_TRIVIA';

class NumberTriviaLocalDataSourceImpl implements NumberTriviaLocalDataSource {
  // final Box<NumberTriviaModel> box;
  final Box box;

  NumberTriviaLocalDataSourceImpl({required this.box});

  @override
  Future<NumberTriviaModel> getLastNumberTrivia() {
    final modelsString = box.get(CACHED_NUMBER_TRIVIA);
    if (modelsString == null) {
      throw CacheException();
    }
    // perhaps these dont need to be futures?its is trivial to resolve if not
    // perhaps we can return futures for future proofing
    return Future.value(NumberTriviaModel.fromJson(json.decode(modelsString)));
  }

  @override
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache) {
    return box.put(CACHED_NUMBER_TRIVIA, json.encode(triviaToCache));
    // return box.put(CACHED_NUMBER_TRIVIA, json.encode(triviaToCache.toJson()));
  }
}
