import 'package:flutter_architecture_template/data/mappers/github/asset_mapper.dart';
import 'package:flutter_architecture_template/data/mappers/github/user_mapper.dart';
import 'package:flutter_architecture_template/data/models/github/asset_model.dart';
import 'package:flutter_architecture_template/domain/entities/github/asset.dart';
import 'package:flutter_architecture_template/domain/entities/github/user.dart';
import 'package:flutter_architecture_template/injection_container.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_architecture_template/data/models/github/user_model.dart';
import 'package:injectable/injectable.dart' show Environment;
import 'package:mockito/mockito.dart';

void main() {
  GithubAssetMapper mapper;
  GithubUserMapper mockUserMapper;

  init(env: Environment.test);

  setUp(() {
    mockUserMapper = sl<GithubUserMapper>();
    mapper = GithubAssetMapper(
      userMapper: mockUserMapper,
    );
  });

  final DateTime tDateTime = DateTime.parse("1970-01-01T00:00:00Z");
  final tUploaderModel = const GithubUserModel(
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
  );
  final tAuthorModel = const GithubUserModel(
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
  );
  final tAssetModel = GithubAssetModel(
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
    uploader: tUploaderModel,
  );

  final tUploader = const GithubUser(
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
  );
  final tAuthor = const GithubUser(
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
  );
  final tAsset = GithubAsset(
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
    uploader: tUploader,
  );

  test(
    'mapFrom',
    () async {
      // arrange
      when(mockUserMapper.mapFrom(any)).thenReturn(tAuthorModel);
      // act
      final result = await mapper.mapFrom(tAsset);
      // assert
      expect(result, equals(tAssetModel));
    },
  );

  test(
    'mapTo',
    () async {
      // arrange
      when(mockUserMapper.mapTo(any)).thenReturn(tAuthor);
      // act
      final result = await mapper.mapTo(tAssetModel);
      // assert
      expect(result, equals(tAsset));
    },
  );
}
