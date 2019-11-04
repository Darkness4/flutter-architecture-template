import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_architecture_template/core/error/exceptions.dart';
import 'package:flutter_architecture_template/data/datasources/github_local_data_source.dart';
import 'package:flutter_architecture_template/data/models/github/asset_model.dart';
import 'package:flutter_architecture_template/data/models/github/release_model.dart';
import 'package:flutter_architecture_template/data/models/github/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
  GithubLocalDataSourceImpl dataSource;
  MockSharedPreferences mockSharedPreferences;
  const String tRepo = 'Darkness4/minitel-app';

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = GithubLocalDataSourceImpl(
      sharedPreferences: mockSharedPreferences,
    );
  });

  group('fetchLastReleases', () {
    final tListGithubReleaseModel = List<Map<String, dynamic>>.from(
            json.decode(fixture('releases.json')) as List<dynamic>)
        .map((Map<String, dynamic> data) => GithubReleaseModel.fromJson(data))
        .toList();
    test(
      'should return ListGithubRelease from SharedPreferences when there is one in the cache',
      () async {
        // arrange
        when(mockSharedPreferences.getString(any))
            .thenReturn(fixture('releases.json'));
        // act
        final result = await dataSource.fetchLastReleases(tRepo);
        // assert
        verify(mockSharedPreferences.getString(tRepo));
        expect(result, equals(tListGithubReleaseModel));
      },
    );

    test(
      'should throw a CacheExeption when there is not a cached value',
      () async {
        // arrange
        when(mockSharedPreferences.getString(any)).thenReturn(null);
        // act
        final call = dataSource.fetchLastReleases;
        // assert
        expect(() => call(tRepo), throwsA(const TypeMatcher<CacheException>()));
      },
    );
  });

  group('cacheNumberTrivia', () {
    final tListGithubReleaseModel = <GithubReleaseModel>[
      GithubReleaseModel(
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
        created_at: DateTime.now(),
        published_at: DateTime.now(),
        author: const GithubUserModel(
          login: 'login',
          id: 1,
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
        ),
        assets: <GithubAssetModel>[],
      ),
    ];

    test(
      'should call SharedPreferences to cache the data',
      () async {
        // act
        await dataSource.cacheReleases(tListGithubReleaseModel, tRepo);
        // assert
        final expectedJsonString = json.encode(tListGithubReleaseModel
            .map((GithubReleaseModel release) => release.toJson())
            .toList());
        verify(mockSharedPreferences.setString(
          tRepo,
          expectedJsonString,
        ));
      },
    );
  });
}

class MockSharedPreferences extends Mock implements SharedPreferences {}
