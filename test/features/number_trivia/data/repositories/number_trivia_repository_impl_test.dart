import 'package:clean_architecture_tdd/core/platform/network_info.dart';
import 'package:clean_architecture_tdd/features/number_trivia/data/datasources/number_trivia_local_datasource.dart';
import 'package:clean_architecture_tdd/features/number_trivia/data/datasources/number_trivia_remote_datasource.dart';
import 'package:clean_architecture_tdd/features/number_trivia/data/repositories/number_trivia_repository.dart';
import 'package:clean_architecture_tdd/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_architecture_tdd/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:clean_architecture_tdd/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import 'number_trivia_repository_impl_test.mocks.dart';

class RemoteDataSourceTest extends Mock
    implements NumberTriviaRemoteDataSource {}

class LocalDataSourceTest extends Mock implements NumberTriviaLocalDataSource {}

class NetworkInfoTest extends Mock implements NetworkInfo {}

@GenerateMocks([RemoteDataSourceTest])
@GenerateMocks([LocalDataSourceTest])
@GenerateMocks([NetworkInfoTest])
Future<void> main() async {
  late NumberTriviaRepositoryImpl repository;
  late MockRemoteDataSourceTest mockRemoteDataSource;
  late MockLocalDataSourceTest mockLocalDataSource;
  late MockNetworkInfoTest mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSourceTest();
    mockLocalDataSource = MockLocalDataSourceTest();
    mockNetworkInfo = MockNetworkInfoTest();
    repository = NumberTriviaRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });
}
