import 'package:flutter_architecture_template/domain/usecases/get_github_user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_architecture_template/core/error/exceptions.dart';
import 'package:flutter_architecture_template/domain/entities/github/user.dart';
import 'package:flutter_architecture_template/presentation/blocs/github_user/bloc.dart';

void main() {
  GithubUserBloc bloc;
  MockGetGithubUser mockGetGithubUser;

  setUp(() {
    mockGetGithubUser = MockGetGithubUser();

    bloc = GithubUserBloc(getGithubUser: mockGetGithubUser);
  });

  test('initialState should be GithubUserStateInitial', () {
    // assert
    expect(bloc.initialState, equals(const GithubUserStateInitial()));
  });

  group('GetUserEvent', () {
    const tUser = 'Darkness4';
    final DateTime tDateTime = DateTime.parse("1970-01-01T00:00:00.000Z");
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
      'should get data from the concrete use case',
      () async {
        // arrange
        when(mockGetGithubUser(any)).thenAnswer((_) async => tGithubUser);
        // act
        bloc.add(const GetUserEvent(tUser));
        await untilCalled(mockGetGithubUser(any));
        // assert
        verify(mockGetGithubUser(const Params(tUser)));
      },
    );

    test(
      'should emit [GithubUserStateLoading, GithubUserStateLoaded] when data is gotten successfully',
      () async {
        // arrange
        when(mockGetGithubUser(any)).thenAnswer((_) async => tGithubUser);
        // assert later
        final expected = [
          const GithubUserStateInitial(),
          const GithubUserStateLoading(),
          GithubUserStateLoaded(user: tGithubUser),
        ];
        final Future<void> future = expectLater(bloc, emitsInOrder(expected));
        // act
        bloc.add(const GetUserEvent(tUser));
        await future;
      },
    );

    test(
      'should emit [GithubUserStateLoading, GithubUserStateError] when getting data fails',
      () async {
        // arrange
        when(mockGetGithubUser(any)).thenThrow(ServerException());
        // assert later
        final expected = [
          const GithubUserStateInitial(),
          const GithubUserStateLoading(),
          const GithubUserStateError(message: 'ServerException'),
        ];
        final Future<void> future = expectLater(bloc, emitsInOrder(expected));
        // act
        bloc.add(const GetUserEvent(tUser));
        await future;
      },
    );

    test(
      'should emit [GithubUserStateLoading, GithubUserStateError] with a proper message for the error when getting data fails',
      () async {
        // arrange
        when(mockGetGithubUser(any)).thenThrow(CacheException());
        // assert later
        final expected = [
          const GithubUserStateInitial(),
          const GithubUserStateLoading(),
          const GithubUserStateError(message: 'CacheException'),
        ];
        final Future<void> future = expectLater(bloc, emitsInOrder(expected));
        // act
        bloc.add(const GetUserEvent(tUser));
        await future;
      },
    );
  });
}

class MockGetGithubUser extends Mock implements GetGithubUser {}
