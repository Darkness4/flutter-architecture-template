import 'package:flutter_architecture_template/domain/usecases/github/get_user.dart';
import 'package:flutter_architecture_template/injection_container.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:injectable/injectable.dart' show Environment;
import 'package:mockito/mockito.dart';
import 'package:flutter_architecture_template/core/error/exceptions.dart';
import 'package:flutter_architecture_template/domain/entities/github/user.dart';
import 'package:flutter_architecture_template/presentation/blocs/github_user/github_user_bloc.dart';

void main() {
  GithubUserBloc bloc;
  GetGithubUser mockGetGithubUser;

  init(env: Environment.test);

  setUp(() {
    mockGetGithubUser = sl<GetGithubUser>();

    bloc = GithubUserBloc(getGithubUser: mockGetGithubUser);
  });

  test('initialState should be GithubUserStateInitial', () {
    // assert
    expect(bloc.initialState, equals(GithubUserStateInitial()));
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
        bloc.add(GetUserEvent(tUser));
        await untilCalled(mockGetGithubUser(any));
        // assert
        verify(mockGetGithubUser(tUser));
      },
    );

    test(
      'should emit [GithubUserStateLoading, GithubUserStateLoaded] when data is gotten successfully',
      () async {
        // arrange
        when(mockGetGithubUser(any)).thenAnswer((_) async => tGithubUser);
        // assert later
        final expected = [
          GithubUserStateInitial(),
          GithubUserStateLoading(),
          GithubUserStateLoaded(user: tGithubUser),
        ];
        final Future<void> future = expectLater(bloc, emitsInOrder(expected));
        // act
        bloc.add(GetUserEvent(tUser));
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
          GithubUserStateInitial(),
          GithubUserStateLoading(),
          GithubUserStateError(message: 'ServerException'),
        ];
        final Future<void> future = expectLater(bloc, emitsInOrder(expected));
        // act
        bloc.add(GetUserEvent(tUser));
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
          GithubUserStateInitial(),
          GithubUserStateLoading(),
          GithubUserStateError(message: 'CacheException'),
        ];
        final Future<void> future = expectLater(bloc, emitsInOrder(expected));
        // act
        bloc.add(GetUserEvent(tUser));
        await future;
      },
    );
  });
}
