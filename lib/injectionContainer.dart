import 'dart:io';

import 'package:clean_architecture_tdd/core/network/network_info.dart';
import 'package:clean_architecture_tdd/core/util/input_converter.dart';
import 'package:clean_architecture_tdd/features/number_trivia/data/datasources/number_trivia_local_datasource.dart';
import 'package:clean_architecture_tdd/features/number_trivia/data/datasources/number_trivia_remote_datasource.dart';
import 'package:clean_architecture_tdd/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:clean_architecture_tdd/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:clean_architecture_tdd/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:clean_architecture_tdd/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:clean_architecture_tdd/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';

/// * cache the injection container at the top level
final sl = GetIt.instance;

/// A single top level function which we call from main.dart
/// We need an instance of getIt to register individual objects
/// When we need to instantiate it GetIt will know what to do
///
/// * Registering Singletons vs Factories
///
/// Factories are good for Blocs and presnetation layers that need to dispose of these objects for cleanup
/// Singletons are good for services that are not expected to be disposed of
///
/// * Factory
///
/// When the get it instance is called to look for something registered with the factory,
/// it will return a new instance of the class.
///
/// * Singleton
///
/// Singletons are good for things that do not get disposed of, the instance gets used by GetIt
/// and is returned when the getIt instance is called.
///
/// * Notes
///
/// Factories always instantiate a new instanceof that given class whenever we request it.
///
/// Singletons are created only once and then reused.
///
/// Lazy singletons are created only when we request it.
///
///
Future<void> init() async {
  //! Features - Number Trivia
  // Bloc
  sl.registerFactory(
    () => NumberTriviaBloc(
      concrete: sl.call(),
      random: sl(),
      converter: sl(),
    ),
  );
  // UseCase
  sl.registerLazySingleton(() => GetConcreteNumberTrivia(sl()));
  sl.registerLazySingleton(() => GetRandomNumberTrivia(sl()));

  // Repository
  sl.registerLazySingleton<NumberTriviaRepository>(
    () => NumberTriviaRepositoryImpl(
      localDataSource: sl(),
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // DataSource
  sl.registerLazySingleton<NumberTriviaLocalDataSource>(
      () => NumberTriviaLocalDataSourceImpl(
            box: sl(),
          ));

  sl.registerLazySingleton<NumberTriviaRemoteDataSource>(
      () => NumberTriviaRemoteDataSourceImpl(
            client: sl(),
          ));

  //! Core
  sl.registerLazySingleton(() => InputConverter());
  sl.registerLazySingleton(() => NetworkInfoImpl(sl()));

  //! External
  // You can use Hive just like a map. It is not necessary to await Futures
  // sl.registerLazySingleton(() => Hive.box('trivia_box'));

  // Hive.init(path);

  final Box box = await Hive.openBox("trivia_box");
  sl.registerSingleton(box);
  // sl.registerLazySingleton(() => Hive.openBox('trivia_box'));
  // sl.registerLazySingleton(() => Hive.box('trivia_box'));
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
}

// can divide and conquer the code into smaller functions
void initFeatures() {
  //! Features - Number Trivia
}

///
/// The code here sl() or sl.Call() is just calling itself
/// and starts lookinf for the registered types
/// because it is a factory it will create a new instance of the class
/// everytime we call it/look for it. with the getIt instance
/// When we have some disposal/cleanupo logic on our presentation layer
/// we should register them as factories and not singletons so that they can be disposed of
/// when the presentation layer is disposed of. Then when it is needed again it can recreate itself
///
// sl.registerFactory(
//   () => NumberTriviaBloc(
//     concrete: sl.call(),
//     random: sl(),
//     converter: sl(),
//   ),
// );

///
/// The code here sl() or sl.Call() is just calling itself
/// and starts lookinf for the registered types
/// because it is a factory it will create a new instance of the class
/// everytime we call it/look for it. with the getIt instance
///
// sl.registerLazySingleton(
//   () => NumberTriviaBloc(
//     concrete: sl.call(),
//     random: sl(),
//     converter: sl(),
//   ),
// );
