import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_architecture_template/core/error/exceptions.dart';
import 'package:flutter_architecture_template/data/datasources/github_remote_data_source.dart';
import 'package:flutter_architecture_template/data/models/github/user_model.dart';
import 'package:flutter_architecture_template/data/repositories/user_repository_impl.dart';
import 'package:flutter_architecture_template/domain/entities/github/user.dart';

void main() {
  UserRepositoryImpl repository;
  MockRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    repository = UserRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
    );
  });
  group('getUser', () {
    const tUser = 'Darkness4';
    final DateTime tDateTime = DateTime.parse("1970-01-01T00:00:00Z");
    final tGithubUserModel = GithubUserModel(
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
    final GithubUser tGithubUser = tGithubUserModel;

    test(
      'should return remote data when the call to remote data source is successful',
      () async {
        // arrange
        when(mockRemoteDataSource.fetchUser(any))
            .thenAnswer((_) async => tGithubUserModel);
        // act
        final result = await repository.getUser(tUser);
        // assert
        verify(mockRemoteDataSource.fetchUser(tUser));
        expect(result, equals(tGithubUser));
      },
    );

    test(
      'should return server failure when the call to remote data source is unsuccessful',
      () async {
        // arrange
        when(mockRemoteDataSource.fetchUser(any)).thenThrow(ServerException());
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
}

class MockRemoteDataSource extends Mock implements GithubRemoteDataSource {}
