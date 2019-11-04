import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:matcher/matcher.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_architecture_template/core/error/exceptions.dart';
import 'package:flutter_architecture_template/data/datasources/github_remote_data_source.dart';
import 'package:flutter_architecture_template/data/models/github/release_model.dart';
import 'package:flutter_architecture_template/data/models/github/user_model.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
  GithubRemoteDataSourceImpl dataSource;
  MockHttpClient mockHttpClient;
  const String tRepo = 'Darkness4/minitel-app';
  const String tUser = 'Darkness4';

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = GithubRemoteDataSourceImpl(client: mockHttpClient);
  });

  void setUpMockHttpClientSuccess200() {
    when(mockHttpClient.get(
      argThat(startsWith('https://api.github.com/repos/')),
    )).thenAnswer((_) async => http.Response(fixture('releases.json'), 200));
    when(mockHttpClient.get(
      argThat(startsWith('https://api.github.com/users/')),
    )).thenAnswer((_) async => http.Response(fixture('user.json'), 200));
  }

  void setUpMockHttpClientFailure404() {
    when(mockHttpClient.get(any))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  group('fetchReleases', () {
    final tListGithubReleaseModel = List<Map<String, dynamic>>.from(
            json.decode(fixture('releases.json')) as List<dynamic>)
        .map((Map<String, dynamic> data) => GithubReleaseModel.fromJson(data))
        .toList();

    test(
      "should perform a GET request on a URL with tRepo being the endpoint",
      () async {
        // arrange
        setUpMockHttpClientSuccess200();
        // act
        await dataSource.fetchReleases(tRepo);
        // assert
        verify(mockHttpClient.get(
          'https://api.github.com/repos/$tRepo/releases',
        ));
      },
    );

    test(
      'should return ListGithubRelease when the response code is 200 (success)',
      () async {
        // arrange
        setUpMockHttpClientSuccess200();
        // act
        final result = await dataSource.fetchReleases(tRepo);
        // assert
        expect(result, equals(tListGithubReleaseModel));
      },
    );

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        setUpMockHttpClientFailure404();
        // act
        final call = dataSource.fetchReleases;
        // assert
        expect(
            () => call(tRepo), throwsA(const TypeMatcher<ServerException>()));
      },
    );
  });

  group('fetchUser', () {
    final tGithubUserModel = GithubUserModel.fromJson(
        json.decode(fixture('user.json')) as Map<String, dynamic>);

    test(
      "should perform a GET request on a URL with tUser being the endpoint",
      () async {
        // arrange
        setUpMockHttpClientSuccess200();
        // act
        await dataSource.fetchUser(tUser);
        // assert
        verify(mockHttpClient.get(
          'https://api.github.com/users/$tUser',
        ));
      },
    );

    test(
      'should return GithubUserModel when the response code is 200 (success)',
      () async {
        // arrange
        setUpMockHttpClientSuccess200();
        // act
        final result = await dataSource.fetchUser(tUser);
        // assert
        expect(result, equals(tGithubUserModel));
      },
    );

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        setUpMockHttpClientFailure404();
        // act
        final call = dataSource.fetchUser;
        // assert
        expect(
            () => call(tUser), throwsA(const TypeMatcher<ServerException>()));
      },
    );
  });
}

class MockHttpClient extends Mock implements http.Client {}
