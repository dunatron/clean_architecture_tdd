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
