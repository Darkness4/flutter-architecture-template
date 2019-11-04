import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_architecture_template/data/models/github/user_model.dart';
import 'package:flutter_architecture_template/domain/entities/github/user.dart';

import '../../../fixtures/fixture_reader.dart';

void main() {
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

  test(
    'should be a subclass of GithubUser entity',
    () async {
      // assert
      expect(tGithubUserModel, isA<GithubUser>());
    },
  );

  group('fromJson', () {
    test(
      'should return a valid model',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('user.json')) as Map<String, dynamic>;
        // act
        final result = GithubUserModel.fromJson(jsonMap);
        // assert
        expect(result, tGithubUserModel);
      },
    );
  });

  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
      () async {
        // act
        final result = tGithubUserModel.toJson();
        // assert
        final expectedMap = {
          "login": "login",
          "id": 0,
          "node_id": "node_id",
          "avatar_url": "avatar_url",
          "gravatar_id": "gravatar_id",
          "url": "url",
          "html_url": "html_url",
          "followers_url": "followers_url",
          "following_url": "following_url",
          "gists_url": "gists_url",
          "starred_url": "starred_url",
          "subscriptions_url": "subscriptions_url",
          "organizations_url": "organizations_url",
          "repos_url": "repos_url",
          "events_url": "events_url",
          "received_events_url": "received_events_url",
          "type": "type",
          "site_admin": false,
          "name": "name",
          "company": "company",
          "blog": "blog",
          "location": "location",
          "email": "email",
          "hireable": false,
          "bio": "bio",
          "public_repos": 0,
          "public_gists": 0,
          "followers": 0,
          "following": 0,
          "created_at": "1970-01-01T00:00:00.000Z",
          "updated_at": "1970-01-01T00:00:00.000Z"
        };
        expect(result, expectedMap);
      },
    );
  });
}
