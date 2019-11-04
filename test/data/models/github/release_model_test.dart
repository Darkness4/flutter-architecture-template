import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_architecture_template/data/models/github/asset_model.dart';
import 'package:flutter_architecture_template/data/models/github/release_model.dart';
import 'package:flutter_architecture_template/data/models/github/user_model.dart';
import 'package:flutter_architecture_template/domain/entities/github/release.dart';

import '../../../fixtures/fixture_reader.dart';

void main() {
  final DateTime tDateTime = DateTime.parse("1970-01-01T00:00:00.000Z");
  final tGithubReleaseModel = GithubReleaseModel(
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
    author: const GithubUserModel(
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
    ),
    assets: <GithubAssetModel>[
      GithubAssetModel(
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
        uploader: const GithubUserModel(
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
        ),
      ),
    ],
  );

  test(
    'should be a subclass of GithubRelease entity',
    () async {
      // assert
      expect(tGithubReleaseModel, isA<GithubRelease>());
    },
  );

  group('fromJson', () {
    test(
      'should return a valid model',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('release.json')) as Map<String, dynamic>;
        // act
        final result = GithubReleaseModel.fromJson(jsonMap);
        // assert
        expect(result, tGithubReleaseModel);
      },
    );
  });

  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
      () async {
        // act
        final result = tGithubReleaseModel.toJson();
        // assert
        final expectedMap = {
          "url": "url",
          "assets_url": "assets_url",
          "upload_url": "upload_url",
          "html_url": "html_url",
          "id": 0,
          "node_id": "node_id",
          "tag_name": "tag_name",
          "target_commitish": "target_commitish",
          "name": "name",
          "draft": false,
          "author": {
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
            'name': null,
            'company': null,
            'blog': null,
            'location': null,
            'email': null,
            'hireable': null,
            'bio': null,
            'public_repos': null,
            'public_gists': null,
            'followers': null,
            'following': null,
            'created_at': null,
            'updated_at': null,
          },
          "prerelease": false,
          "created_at": "1970-01-01T00:00:00.000Z",
          "published_at": "1970-01-01T00:00:00.000Z",
          "assets": [
            {
              "url": "url",
              "id": 0,
              "node_id": "node_id",
              "name": "name",
              "label": "label",
              "uploader": {
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
                'name': null,
                'company': null,
                'blog': null,
                'location': null,
                'email': null,
                'hireable': null,
                'bio': null,
                'public_repos': null,
                'public_gists': null,
                'followers': null,
                'following': null,
                'created_at': null,
                'updated_at': null,
              },
              "content_type": "content_type",
              "state": "state",
              "size": 0,
              "download_count": 0,
              "created_at": "1970-01-01T00:00:00.000Z",
              "updated_at": "1970-01-01T00:00:00.000Z",
              "browser_download_url": "browser_download_url"
            }
          ],
          "tarball_url": "tarball_url",
          "zipball_url": "zipball_url",
          "body": "body"
        };
        expect(result, expectedMap);
      },
    );
  });
}
