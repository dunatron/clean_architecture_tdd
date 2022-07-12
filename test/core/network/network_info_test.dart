import 'package:clean_architecture_tdd/core/network/network_info.dart';
import 'package:dartz/dartz.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import 'network_info_test.mocks.dart';

class InternetConnectionCheckerTest extends Mock
    implements InternetConnectionChecker {}

@GenerateMocks([InternetConnectionCheckerTest])
void main() {
  late NetworkInfoImpl networkInfo;
  late MockInternetConnectionCheckerTest mockInternetConnectionChecker;

  setUp(() {
    mockInternetConnectionChecker = MockInternetConnectionCheckerTest();
    networkInfo = NetworkInfoImpl(mockInternetConnectionChecker);
  });

  group('is connected', () {
    test('should forward the call the InternetConnectionChecker', () async {
      // arrange
      final tHasConnectionFuture = Future.value(true);

      when(mockInternetConnectionChecker.hasConnection).thenAnswer(
        (_) => tHasConnectionFuture,
      );
      when(mockInternetConnectionChecker.hasConnection)
          .thenAnswer((_) async => true);
      // act
      // Note: we do not await the result of networkInfo.isConnected here
      // we want to ensure the call is actually forwarded to the InternetConnectionChecker
      final result = networkInfo.isConnected;
      // assert
      verify(mockInternetConnectionChecker.hasConnection);
      expect(result, tHasConnectionFuture);
    });
  });
}
