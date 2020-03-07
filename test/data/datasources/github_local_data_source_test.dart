import 'dart:convert';

import 'package:flutter_architecture_template/core/error/exceptions.dart';
import 'package:flutter_architecture_template/data/datasources/github_local_data_source.dart';
import 'package:flutter_architecture_template/data/models/github/release_model.dart';
import 'package:flutter_architecture_template/data/models/github/user_model.dart';
import 'package:flutter_architecture_template/injection_container.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart' show Environment;
import 'package:matcher/matcher.dart';
import 'package:mockito/mockito.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
  GithubLocalDataSourceImpl dataSource;
  Box<String> mockBox;
  const String tRepo = 'Darkness4/minitel-app';
  const String tUsername = 'Darkness4';
  init(env: Environment.test);

  setUp(() {
    mockBox = sl<Box<String>>();
    dataSource = GithubLocalDataSourceImpl(box: mockBox);
  });

  group('fetchLastReleases', () {
    final tListGithubReleaseModel = List<Map<String, dynamic>>.from(
            json.decode(fixture('releases.json')) as List<dynamic>)
        .map((Map<String, dynamic> data) => GithubReleaseModel.fromJson(data))
        .toList();
    test(
      'should return ListGithubRelease from Github when there is one in the cache',
      () async {
        // arrange
        when<String>(mockBox.get(any)).thenReturn(fixture('releases.json'));
        // act
        final result = await dataSource.fetchLastReleases(tRepo);
        // assert
        verify<String>(mockBox.get(tRepo));
        expect(result, equals(tListGithubReleaseModel));
      },
    );

    test(
      'should throw a CacheExeption when there is not a cached value',
      () async {
        // arrange
        when<String>(mockBox.get(any)).thenReturn(null);
        // act
        final call = dataSource.fetchLastReleases;
        // assert
        expect(() => call(tRepo), throwsA(const TypeMatcher<CacheException>()));
      },
    );
  });

  group('cacheReleases', () {
    final tListGithubReleaseModel = List<Map<String, dynamic>>.from(
            json.decode(fixture('releases.json')) as List<dynamic>)
        .map((Map<String, dynamic> data) => GithubReleaseModel.fromJson(data))
        .toList();

    test(
      'should call Github to cache the data',
      () async {
        // act
        await dataSource.cacheReleases(tListGithubReleaseModel, tRepo);
        // assert
        final expectedJsonString = json.encode(tListGithubReleaseModel
            .map((GithubReleaseModel release) => release.toJson())
            .toList());
        verify(mockBox.put(
          tRepo,
          expectedJsonString,
        ));
      },
    );
  });

  group('fetchCachedUser', () {
    final tGithubUserModel = GithubUserModel.fromJson(
        json.decode(fixture('user.json')) as Map<String, dynamic>);
    test(
      'should return GithubUserModel from Github when there is one in the cache',
      () async {
        // arrange
        when<String>(mockBox.get(any)).thenReturn(fixture('user.json'));
        // act
        final result = await dataSource.fetchCachedUser(tUsername);
        // assert
        verify<String>(mockBox.get(tUsername));
        expect(result, equals(tGithubUserModel));
      },
    );

    test(
      'should throw a CacheExeption when there is not a cached value',
      () async {
        // arrange
        when<String>(mockBox.get(any)).thenReturn(null);
        // act
        final call = dataSource.fetchCachedUser;
        // assert
        expect(() => call(tRepo), throwsA(const TypeMatcher<CacheException>()));
      },
    );
  });

  group('cacheUser', () {
    final tGithubUserModel = GithubUserModel.fromJson(
        json.decode(fixture('user.json')) as Map<String, dynamic>);

    test(
      'should call Github to cache the data',
      () async {
        // act
        await dataSource.cacheUser(tGithubUserModel, tUsername);
        // assert
        final expectedJsonString = json.encode(tGithubUserModel.toJson());
        verify(mockBox.put(
          tUsername,
          expectedJsonString,
        ));
      },
    );
  });
}
