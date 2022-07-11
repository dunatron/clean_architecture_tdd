import 'package:clean_architecture_tdd/core/error/failures.dart';
import 'package:clean_architecture_tdd/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:dartz/dartz.dart';

import '../../domain/repositories/number_trivia_repository.dart';
import '../datasources/number_trivia_remote_datasource.dart';
import '../datasources/number_trivia_local_datasource.dart';
import '../../../../core/platform/network_info.dart';

class NumberTriviaRepositoryImpl implements NumberTriviaRepository {
  final NumberTriviaRemoteDataSource remoteDataSource;
  final NumberTriviaLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  NumberTriviaRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  //  remoteDataSource: mockRemoteDataSource,
  //     localDataSource: mockLocalDataSource,
  //     networkInfo: mockNetworkInfo,
  @override
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(int number) {
    // return Future.value(NumberTrivia(number: number, text: 'Test'));
  }

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() {
    // return Future.value(NumberTrivia(number: 1, text: 'Test'));
  }
}
