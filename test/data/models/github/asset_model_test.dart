import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_architecture_template/data/models/github/asset_model.dart';
import 'package:flutter_architecture_template/data/models/github/user_model.dart';
import 'package:flutter_architecture_template/domain/entities/github/asset.dart';

import '../../../fixtures/fixture_reader.dart';

void main() {
  final DateTime tDateTime = DateTime.parse("1970-01-01T00:00:00Z");
  final tGithubAssetModel = GithubAssetModel(
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
  );

  test(
    'should be a subclass of GithubAsset entity',
    () async {
      // assert
      expect(tGithubAssetModel, isA<GithubAsset>());
    },
  );

  group('fromJson', () {
    test(
      'should return a valid model',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('asset.json')) as Map<String, dynamic>;
        // act
        final result = GithubAssetModel.fromJson(jsonMap);
        // assert
        expect(result, tGithubAssetModel);
      },
    );
  });

  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
      () async {
        // act
        final result = tGithubAssetModel.toJson();
        // assert
        final expectedMap = {
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
          "browser_download_url": "browser_download_url",
        };
        expect(result, expectedMap);
      },
    );
  });
}
