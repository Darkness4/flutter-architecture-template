import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:flutter_architecture_template/core/network/network_info.dart';
import 'package:flutter_architecture_template/data/datasources/github_local_data_source.dart';
import 'package:flutter_architecture_template/data/mappers/github/user_mapper.dart';
import 'package:flutter_architecture_template/data/repositories/github/user_repository_impl.dart';
import 'package:flutter_architecture_template/domain/entities/github/user.dart';
import 'package:flutter_architecture_template/injection_container.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:injectable/injectable.dart' show Environment;
import 'package:mockito/mockito.dart';
import 'package:flutter_architecture_template/core/error/exceptions.dart';
import 'package:flutter_architecture_template/data/datasources/github_remote_data_source.dart';
import 'package:flutter_architecture_template/data/models/github/user_model.dart';

import '../../../fixtures/fixture_reader.dart';

void main() {
  UserRepositoryImpl repository;
  GithubRemoteDataSource mockRemoteDataSource;
  GithubUserMapper mockGithubUserMapper;
  NetworkInfo mockNetworkInfo;
  GithubLocalDataSource mockLocalDataSource;

  init(env: Environment.test);

  setUp(() {
    mockRemoteDataSource = sl<GithubRemoteDataSource>();
    mockGithubUserMapper = sl<GithubUserMapper>();
    mockLocalDataSource = sl<GithubLocalDataSource>();
    mockNetworkInfo = sl<NetworkInfo>();
    repository = UserRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
      mapper: mockGithubUserMapper,
    );
  });

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.result)
            .thenAnswer((_) async => ConnectivityResult.wifi);
      });

      body();
    });
  }

  void runTestsOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.result)
            .thenAnswer((_) async => ConnectivityResult.none);
      });

      body();
    });
  }

  group('getUser', () {
    const tUser = 'Darkness4';
    final DateTime tDateTime = DateTime.parse("1970-01-01T00:00:00Z");
    final tGithubUserModel = GithubUserModel.fromJson(
        json.decode(fixture('user.json')) as Map<String, dynamic>);
    final tGithubUser = GithubUser(
      login: 'login',
      id: 0,
      node_id: 'node_id',
      avatar_url: 'avatar_url',
      gravatar_id: 'gravatar_id',
      url: 'url',
      html_url: 'html_url',
      followers_url: 'followers_url',
      following_url: 'following_url',
      gists_url: 'gists_url',
      starred_url: 'starred_url',
      subscriptions_url: 'subscriptions_url',
      organizations_url: 'organizations_url',
      repos_url: 'repos_url',
      events_url: 'events_url',
      received_events_url: 'received_events_url',
      type: 'type',
      site_admin: false,
      name: 'name',
      company: 'company',
      blog: 'blog',
      location: 'location',
      email: 'email',
      hireable: false,
      bio: 'bio',
      public_repos: 0,
      public_gists: 0,
      followers: 0,
      following: 0,
      created_at: tDateTime,
      updated_at: tDateTime,
    );

    test(
      'should check if the device is online',
      () async {
        // arrange
        when(mockNetworkInfo.result)
            .thenAnswer((_) async => ConnectivityResult.wifi);
        when(mockRemoteDataSource.fetchUser(any)).thenAnswer((_) async => null);
        when(mockGithubUserMapper.mapTo(any)).thenReturn(null);
        // act
        await repository.getUser(tUser);
        // assert
        verify(mockNetworkInfo.result);
      },
    );

    runTestsOnline(() {
      test(
        'should return remote data when the call to remote data source is successful',
        () async {
          // arrange
          when(mockRemoteDataSource.fetchUser(any))
              .thenAnswer((_) async => tGithubUserModel);
          when(mockGithubUserMapper.mapTo(tGithubUserModel))
              .thenReturn(tGithubUser);
          // act
          final result = await repository.getUser(tUser);
          // assert
          verify(mockRemoteDataSource.fetchUser(tUser));
          expect(result, equals(tGithubUser));
        },
      );

      test(
        'should cache the data locally when the call to remote data source is successful',
        () async {
          // arrange
          when(mockRemoteDataSource.fetchUser(any))
              .thenAnswer((_) async => tGithubUserModel);
          // act
          await repository.getUser(tUser);
          // assert
          verify(mockRemoteDataSource.fetchUser(tUser));
          verify(mockLocalDataSource.cacheUser(tGithubUserModel, tUser));
        },
      );

      test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(mockRemoteDataSource.fetchUser(any))
              .thenThrow(ServerException());
          // act
          final call = repository.getUser;
          try {
            await call(tUser);
            fail("exception not thrown");
          } catch (e) {
            expect(e, isInstanceOf<ServerException>());
          }
        },
      );
    });

    runTestsOffline(() {
      test(
        'should return last locally cached data when the cached data is present',
        () async {
          // arrange
          when(mockLocalDataSource.fetchCachedUser(tUser))
              .thenAnswer((_) async => tGithubUserModel);
          when(mockGithubUserMapper.mapTo(tGithubUserModel))
              .thenReturn(tGithubUser);
          // act
          final result = await repository.getUser(tUser);
          // assert
          verifyZeroInteractions(mockRemoteDataSource);
          verify(mockLocalDataSource.fetchCachedUser(tUser));
          expect(result, equals(tGithubUser));
        },
      );

      test(
        'should return CacheFailure when there is no cached data present',
        () async {
          // arrange
          when(mockLocalDataSource.fetchCachedUser(tUser))
              .thenThrow(CacheException());
          // act
          final call = repository.getUser;
          // assert
          try {
            await call(tUser);
            fail("exception not thrown");
          } catch (e) {
            expect(e, isInstanceOf<CacheException>());
          }
        },
      );
    });
  });
}
