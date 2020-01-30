import 'package:flutter_architecture_template/data/mappers/github/user_mapper.dart';
import 'package:flutter_architecture_template/domain/entities/github/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_architecture_template/data/models/github/user_model.dart';

void main() {
  GithubUserMapper mapper;

  setUp(() {
    mapper = GithubUserMapper();
  });

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
    'mapFrom',
    () async {
      // act
      final result = await mapper.mapFrom(tGithubUser);
      // assert
      expect(result, equals(tGithubUserModel));
    },
  );

  test(
    'mapTo',
    () async {
      // act
      final result = await mapper.mapTo(tGithubUserModel);
      // assert
      expect(result, equals(tGithubUser));
    },
  );
}
