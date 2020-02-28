// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:flutter_architecture_template/data/datasources/github_local_data_source.dart';
import 'package:hive/hive.dart';
import 'package:flutter_architecture_template/data/mappers/firebase_auth/app_user_mapper.dart';
import 'package:flutter_architecture_template/data/mappers/github/user_mapper.dart';
import 'package:flutter_architecture_template/data/mappers/gitlab_user_mapper.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter_architecture_template/injection_container.dart';
import 'package:http/src/client.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_architecture_template/presentation/blocs/main/main_page_bloc.dart';
import 'package:flutter_architecture_template/data/datasources/mock_github_remote_data_source.dart';
import 'package:flutter_architecture_template/data/datasources/github_remote_data_source.dart';
import 'package:flutter_architecture_template/data/datasources/mock_github_local_data_source.dart';
import 'package:flutter_architecture_template/data/mappers/github/mock_asset_mapper.dart';
import 'package:flutter_architecture_template/data/mappers/github/asset_mapper.dart';
import 'package:flutter_architecture_template/data/mappers/github/mock_user_mapper.dart';
import 'package:flutter_architecture_template/data/mappers/github/mock_release_mapper.dart';
import 'package:flutter_architecture_template/data/mappers/github/release_mapper.dart';
import 'package:flutter_architecture_template/domain/repositories/github/mock_user_repository.dart';
import 'package:flutter_architecture_template/domain/repositories/github/user_repository.dart';
import 'package:flutter_architecture_template/domain/repositories/github/mock_releases_repository.dart';
import 'package:flutter_architecture_template/domain/repositories/github/releases_repository.dart';
import 'package:flutter_architecture_template/domain/usecases/github/mock_get_releases.dart';
import 'package:flutter_architecture_template/domain/usecases/github/get_releases.dart';
import 'package:flutter_architecture_template/domain/usecases/github/mock_get_user.dart';
import 'package:flutter_architecture_template/domain/usecases/github/get_user.dart';
import 'package:flutter_architecture_template/core/network/network_info.dart';
import 'package:flutter_architecture_template/data/datasources/firebase_auth_data_source.dart';
import 'package:flutter_architecture_template/data/datasources/gitlab_remote_data_source.dart';
import 'package:flutter_architecture_template/data/repositories/firebase_auth/app_user_repository_impl.dart';
import 'package:flutter_architecture_template/domain/repositories/firebase_auth/app_user_repository.dart';
import 'package:flutter_architecture_template/data/repositories/github/releases_repository_impl.dart';
import 'package:flutter_architecture_template/data/repositories/github/user_repository_impl.dart';
import 'package:flutter_architecture_template/data/repositories/gitlab_user_repository_impl.dart';
import 'package:flutter_architecture_template/domain/repositories/gitlab_user_repository.dart';
import 'package:flutter_architecture_template/domain/usecases/firebase_auth/get_auth_state.dart';
import 'package:flutter_architecture_template/domain/usecases/firebase_auth/get_user.dart';
import 'package:flutter_architecture_template/domain/usecases/firebase_auth/set_user_data.dart';
import 'package:flutter_architecture_template/domain/usecases/firebase_auth/signin.dart';
import 'package:flutter_architecture_template/domain/usecases/firebase_auth/signout.dart';
import 'package:flutter_architecture_template/domain/usecases/firebase_auth/signup.dart';
import 'package:flutter_architecture_template/domain/usecases/get_gitlab_user.dart';
import 'package:flutter_architecture_template/presentation/blocs/firebase_auth/authentication/authentication_bloc.dart';
import 'package:flutter_architecture_template/presentation/blocs/firebase_auth/login/login_bloc.dart';
import 'package:flutter_architecture_template/presentation/blocs/firebase_auth/register/register_bloc.dart';
import 'package:flutter_architecture_template/presentation/blocs/firebase_auth/user_data/user_data_bloc.dart';
import 'package:flutter_architecture_template/presentation/blocs/github_releases/github_releases_bloc.dart';
import 'package:flutter_architecture_template/presentation/blocs/github_user/github_user_bloc.dart';
import 'package:flutter_architecture_template/presentation/blocs/gitlab_user/gitlab_user_bloc.dart';
import 'package:get_it/get_it.dart';

void $initGetIt(GetIt g, {String environment}) {
  final registerModule = _$RegisterModule();

  //Register prod Dependencies --------
  if (environment == 'prod') {
    g.registerLazySingleton<GithubLocalDataSource>(
        () => GithubLocalDataSourceImpl(
              box: g<Box<String>>(),
            ));
    g.registerLazySingleton<AppUserMapper>(() => AppUserMapper());
    g.registerLazySingleton<GithubUserMapper>(() => GithubUserMapper());
    g.registerLazySingleton<GitlabUserMapper>(() => GitlabUserMapper());
    g.registerLazySingleton<Connectivity>(() => registerModule.prefs);
    g.registerLazySingleton<Client>(() => registerModule.httpClient);
    g.registerFactory<FirebaseAuth>(() => registerModule.firebaseAuth);
    g.registerFactory<Firestore>(() => registerModule.firestore);
    g.registerFactory<Box>(() => registerModule.box);
    g.registerFactory<MainPageBloc>(() => MainPageBloc());
    g.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(
          g<Connectivity>(),
        ));
    g.registerLazySingleton<FirebaseAuthDataSource>(
        () => FirebaseAuthDataSourceImpl(
              auth: g<FirebaseAuth>(),
              db: g<Firestore>(),
            ));
    g.registerLazySingleton<GithubRemoteDataSource>(
        () => GithubRemoteDataSourceImpl(
              client: g<Client>(),
            ));
    g.registerLazySingleton<GitlabRemoteDataSource>(
        () => GitlabRemoteDataSourceImpl(
              client: g<Client>(),
            ));
    g.registerLazySingleton<GithubAssetMapper>(() => GithubAssetMapper(
          userMapper: g<GithubUserMapper>(),
        ));
    g.registerLazySingleton<GithubReleaseMapper>(() => GithubReleaseMapper(
          userMapper: g<GithubUserMapper>(),
          assetMapper: g<GithubAssetMapper>(),
        ));
    g.registerLazySingleton<AppUserRepository>(() => AppUserRepositoryImpl(
          dataSource: g<FirebaseAuthDataSource>(),
          userMapper: g<AppUserMapper>(),
        ));
    g.registerLazySingleton<ReleasesRepository>(() => ReleasesRepositoryImpl(
          localDataSource: g<GithubLocalDataSource>(),
          remoteDataSource: g<GithubRemoteDataSource>(),
          networkInfo: g<NetworkInfo>(),
          releaseMapper: g<GithubReleaseMapper>(),
        ));
    g.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(
          remoteDataSource: g<GithubRemoteDataSource>(),
          localDataSource: g<GithubLocalDataSource>(),
          networkInfo: g<NetworkInfo>(),
          mapper: g<GithubUserMapper>(),
        ));
    g.registerLazySingleton<GitlabUserRepository>(
        () => GitlabUserRepositoryImpl(
              g<GitlabRemoteDataSource>(),
              g<GitlabUserMapper>(),
            ));
    g.registerLazySingleton<GetAuthState>(() => GetAuthState(
          g<AppUserRepository>(),
        ));
    g.registerLazySingleton<GetAppUser>(() => GetAppUser(
          g<AppUserRepository>(),
        ));
    g.registerLazySingleton<SetUserData>(() => SetUserData(
          g<AppUserRepository>(),
        ));
    g.registerLazySingleton<FirebaseAuthSignIn>(() => FirebaseAuthSignIn(
          g<AppUserRepository>(),
        ));
    g.registerLazySingleton<FirebaseAuthSignOut>(() => FirebaseAuthSignOut(
          g<AppUserRepository>(),
        ));
    g.registerLazySingleton<FirebaseAuthSignUp>(() => FirebaseAuthSignUp(
          g<AppUserRepository>(),
        ));
    g.registerLazySingleton<GetGitlabUser>(() => GetGitlabUser(
          g<GitlabUserRepository>(),
        ));
    g.registerLazySingleton<GetGithubReleases>(() => GetGithubReleases(
          g<ReleasesRepository>(),
        ));
    g.registerLazySingleton<GetGithubUser>(() => GetGithubUser(
          g<UserRepository>(),
        ));
    g.registerFactory<AuthenticationBloc>(() => AuthenticationBloc(
          getAuthState: g<GetAuthState>(),
          getAppUser: g<GetAppUser>(),
        ));
    g.registerFactory<LoginBloc>(() => LoginBloc(
          firebaseAuthSignIn: g<FirebaseAuthSignIn>(),
        ));
    g.registerFactory<RegisterBloc>(() => RegisterBloc(
          firebaseAuthSignUp: g<FirebaseAuthSignUp>(),
        ));
    g.registerFactory<UserDataBloc>(() => UserDataBloc(
          setUserData: g<SetUserData>(),
        ));
    g.registerFactory<GithubReleasesBloc>(() => GithubReleasesBloc(
          getGithubReleases: g<GetGithubReleases>(),
        ));
    g.registerFactory<GithubUserBloc>(() => GithubUserBloc(
          getGithubUser: g<GetGithubUser>(),
        ));
    g.registerFactory<GitlabUserBloc>(() => GitlabUserBloc(
          getGitlabUser: g<GetGitlabUser>(),
        ));
  }

  //Register test Dependencies --------
  if (environment == 'test') {
    g.registerFactory<Connectivity>(() => MockDataConnectionChecker());
    g.registerFactory<Client>(() => MockHttpClient());
    g.registerFactory<MockBox>(() => MockBox());
    g.registerFactory<GithubRemoteDataSource>(
        () => MockGithubRemoteDataSource());
    g.registerFactory<GithubLocalDataSource>(() => MockGithubLocalDataSource());
    g.registerFactory<GithubAssetMapper>(() => MockGithubAssetMapper());
    g.registerFactory<GithubUserMapper>(() => MockGithubUserMapper());
    g.registerFactory<GithubReleaseMapper>(() => MockGithubReleaseMapper());
    g.registerFactory<UserRepository>(() => MockUserRepository());
    g.registerFactory<ReleasesRepository>(() => MockReleasesRepository());
    g.registerFactory<GetGithubReleases>(() => MockGetGithubReleases());
    g.registerFactory<GetGithubUser>(() => MockGetGithubUser());
  }
}

class _$RegisterModule extends RegisterModule {
  Connectivity get prefs => Connectivity();
}