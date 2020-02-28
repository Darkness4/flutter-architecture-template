import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:flutter_architecture_template/data/mappers/github/release_mapper.dart';
import 'package:flutter_architecture_template/data/repositories/github/releases_repository_impl.dart';
import 'package:flutter_architecture_template/domain/entities/github/asset.dart';
import 'package:flutter_architecture_template/domain/entities/github/user.dart';
import 'package:flutter_architecture_template/injection_container.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:injectable/injectable.dart' show Environment;
import 'package:mockito/mockito.dart';
import 'package:flutter_architecture_template/core/error/exceptions.dart';
import 'package:flutter_architecture_template/core/network/network_info.dart';
import 'package:flutter_architecture_template/data/datasources/github_local_data_source.dart';
import 'package:flutter_architecture_template/data/datasources/github_remote_data_source.dart';
import 'package:flutter_architecture_template/data/models/github/release_model.dart';
import 'package:flutter_architecture_template/domain/entities/github/release.dart';

import '../../../fixtures/fixture_reader.dart';

void main() {
  ReleasesRepositoryImpl repository;
  GithubRemoteDataSource mockRemoteDataSource;
  GithubLocalDataSource mockLocalDataSource;
  NetworkInfo mockNetworkInfo;
  GithubReleaseMapper mockReleaseMapper;

  init(env: Environment.test);

  setUp(() {
    mockRemoteDataSource = sl<GithubRemoteDataSource>();
    mockLocalDataSource = sl<GithubLocalDataSource>();
    mockNetworkInfo = sl<NetworkInfo>();
    mockReleaseMapper = sl<GithubReleaseMapper>();
    repository = ReleasesRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
      releaseMapper: mockReleaseMapper,
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

  group('getReleases', () {
    const tRepo = 'Darkness4/minitel-app';
    final DateTime tDateTime = DateTime.parse("1970-01-01T00:00:00Z");
    final tGithubReleaseModel = GithubReleaseModel.fromJson(
        json.decode(fixture('release.json')) as Map<String, dynamic>);

    final tUploader = const GithubUser(
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
    );
    final tAuthor = tUploader;
    final tAsset = GithubAsset(
      url: 'url',
      browser_download_url: 'browser_download_url',
      id: 0,
      node_id: 'node_id',
      name: 'name',
      label: 'label',
      state: 'state',
      content_type: 'content_type',
      size: 0,
      download_count: 0,
      created_at: tDateTime,
      updated_at: tDateTime,
      uploader: tUploader,
    );
    final tGithubRelease = GithubRelease(
      url: 'url',
      html_url: 'html_url',
      assets_url: 'assets_url',
      upload_url: 'upload_url',
      tarball_url: 'tarball_url',
      zipball_url: 'zipball_url',
      id: 0,
      node_id: 'node_id',
      tag_name: 'tag_name',
      target_commitish: 'target_commitish',
      name: 'name',
      body: 'body',
      draft: false,
      prerelease: false,
      created_at: tDateTime,
      published_at: tDateTime,
      author: tAuthor,
      assets: <GithubAsset>[
        tAsset,
      ],
    );

    test(
      'should check if the device is online',
      () async {
        // arrange
        when(mockNetworkInfo.result)
            .thenAnswer((_) async => ConnectivityResult.wifi);
        when(mockRemoteDataSource.fetchReleases(any))
            .thenAnswer((_) async => <GithubReleaseModel>[]);
        when(mockReleaseMapper.mapTo(any)).thenReturn(null);
        // act
        await repository.getReleases(tRepo);
        // assert
        verify(mockNetworkInfo.result);
      },
    );

    runTestsOnline(() {
      test(
        'should return remote data when the call to remote data source is successful',
        () async {
          // arrange
          when(mockRemoteDataSource.fetchReleases(any)).thenAnswer(
              (_) async => <GithubReleaseModel>[tGithubReleaseModel]);
          when(mockReleaseMapper.mapTo(tGithubReleaseModel))
              .thenReturn(tGithubRelease);
          // act
          final result = await repository.getReleases(tRepo);
          // assert
          verify(mockRemoteDataSource.fetchReleases(tRepo));
          expect(result, equals(<GithubRelease>[tGithubRelease]));
        },
      );

      test(
        'should cache the data locally when the call to remote data source is successful',
        () async {
          // arrange
          when(mockRemoteDataSource.fetchReleases(any)).thenAnswer(
              (_) async => <GithubReleaseModel>[tGithubReleaseModel]);
          // act
          await repository.getReleases(tRepo);
          // assert
          verify(mockRemoteDataSource.fetchReleases(tRepo));
          verify(mockLocalDataSource
              .cacheReleases(<GithubReleaseModel>[tGithubReleaseModel], tRepo));
        },
      );

      test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(mockRemoteDataSource.fetchReleases(any))
              .thenThrow(ServerException());
          // act
          final call = repository.getReleases;
          try {
            await call(tRepo);
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
          when(mockLocalDataSource.fetchLastReleases(tRepo)).thenAnswer(
              (_) async => <GithubReleaseModel>[tGithubReleaseModel]);
          when(mockReleaseMapper.mapTo(tGithubReleaseModel))
              .thenReturn(tGithubRelease);
          // act
          final result = await repository.getReleases(tRepo);
          // assert
          verifyZeroInteractions(mockRemoteDataSource);
          verify(mockLocalDataSource.fetchLastReleases(tRepo));
          expect(result, equals(<GithubRelease>[tGithubRelease]));
        },
      );

      test(
        'should return CacheFailure when there is no cached data present',
        () async {
          // arrange
          when(mockLocalDataSource.fetchLastReleases(tRepo))
              .thenThrow(CacheException());
          // act
          final call = repository.getReleases;
          // assert
          try {
            await call(tRepo);
            fail("exception not thrown");
          } catch (e) {
            expect(e, isInstanceOf<CacheException>());
          }
        },
      );
    });
  });
}
