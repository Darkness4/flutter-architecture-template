import 'package:connectivity/connectivity.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_architecture_template/core/network/network_info.dart';
import 'package:flutter_architecture_template/data/datasources/github_local_data_source.dart';
import 'package:flutter_architecture_template/data/datasources/github_remote_data_source.dart';
import 'package:flutter_architecture_template/data/repositories/releases_repository_impl.dart';
import 'package:flutter_architecture_template/data/repositories/user_repository_impl.dart';
import 'package:flutter_architecture_template/domain/repositories/releases_repository.dart';
import 'package:flutter_architecture_template/domain/repositories/user_repository.dart';
import 'package:flutter_architecture_template/presentation/blocs/github_releases/bloc.dart';
import 'package:flutter_architecture_template/presentation/blocs/github_user/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  sl.registerFactory(
    () => GithubReleasesBloc(
      repository: sl<ReleasesRepository>(),
    ),
  );
  sl.registerFactory(
    () => GithubUserBloc(
      repository: sl<UserRepository>(),
    ),
  );

  // Repository
  sl.registerLazySingleton<ReleasesRepository>(
    () => ReleasesRepositoryImpl(
      localDataSource: sl<GithubLocalDataSource>(),
      networkInfo: sl<NetworkInfo>(),
      remoteDataSource: sl<GithubRemoteDataSource>(),
    ),
  );
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      remoteDataSource: sl<GithubRemoteDataSource>(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<GithubRemoteDataSource>(
    () => GithubRemoteDataSourceImpl(client: sl<http.Client>()),
  );

  sl.registerLazySingleton<GithubLocalDataSource>(
    () => GithubLocalDataSourceImpl(sharedPreferences: sl<SharedPreferences>()),
  );

  //! Core
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(sl<Connectivity>()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => Connectivity());
}
