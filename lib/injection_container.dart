import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_architecture_template/domain/usecases/get_github_releases.dart';
import 'package:flutter_architecture_template/domain/usecases/get_github_user.dart';
import 'package:flutter_architecture_template/presentation/blocs/main/main_page_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
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
import 'package:path_provider/path_provider.dart' as path_provider;

final GetIt sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  sl.registerFactory(
    () => MainPageBloc(),
  );
  sl.registerFactory(
    () => GithubReleasesBloc(
      getGithubReleases: sl<GetGithubReleases>(),
    ),
  );
  sl.registerFactory(() => GithubUserBloc(
        getGithubUser: sl<GetGithubUser>(),
      ));

  // Use cases
  sl.registerLazySingleton(
    () => GetGithubUser(sl<UserRepository>()),
  );
  sl.registerLazySingleton(
    () => GetGithubReleases(sl<ReleasesRepository>()),
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
    () => GithubLocalDataSourceImpl(box: sl.get<Box<dynamic>>()),
  );

  //! Core
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(sl<Connectivity>()),
  );

  //! External
  if (!kIsWeb) {
    final appDocumentsDirectory =
        await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDocumentsDirectory.path);
  }
  await Hive.openBox<dynamic>('prefs');
  sl.registerLazySingleton<Box<dynamic>>(() => Hive.box<dynamic>('prefs'));
  sl.registerLazySingleton<http.Client>(() => http.Client());
  sl.registerLazySingleton<Connectivity>(() => Connectivity());

  //! Ui
}
