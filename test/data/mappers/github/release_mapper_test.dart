import 'package:flutter_architecture_template/data/mappers/github/asset_mapper.dart';
import 'package:flutter_architecture_template/data/mappers/github/release_mapper.dart';
import 'package:flutter_architecture_template/data/mappers/github/user_mapper.dart';
import 'package:flutter_architecture_template/data/models/github/asset_model.dart';
import 'package:flutter_architecture_template/data/models/github/release_model.dart';
import 'package:flutter_architecture_template/domain/entities/github/asset.dart';
import 'package:flutter_architecture_template/domain/entities/github/release.dart';
import 'package:flutter_architecture_template/domain/entities/github/user.dart';
import 'package:flutter_architecture_template/injection_container.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_architecture_template/data/models/github/user_model.dart';
import 'package:injectable/injectable.dart' show Environment;
import 'package:mockito/mockito.dart';

void main() {
  GithubReleaseMapper mapper;
  GithubUserMapper mockUserMapper;
  GithubAssetMapper mockAssetMapper;

  init(env: Environment.test);

  setUp(() {
    mockAssetMapper = sl<GithubAssetMapper>();
    mockUserMapper = sl<GithubUserMapper>();
    mapper = GithubReleaseMapper(
      assetMapper: mockAssetMapper,
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
    author: tAuthorModel,
    assets: <GithubAssetModel>[
      tAssetModel,
    ],
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
  final tGithubRelease = GithubRelease(
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
    author: tAuthor,
    assets: <GithubAsset>[
      tAsset,
    ],
  );

  test(
    'mapFrom',
    () async {
      // arrange
      when(mockAssetMapper.mapFrom(any)).thenReturn(tAssetModel);
      when(mockUserMapper.mapFrom(any)).thenReturn(tAuthorModel);
      // act
      final result = await mapper.mapFrom(tGithubRelease);
      // assert
      expect(result, equals(tGithubReleaseModel));
    },
  );

  test(
    'mapTo',
    () async {
      // arrange
      when(mockAssetMapper.mapTo(any)).thenReturn(tAsset);
      when(mockUserMapper.mapTo(any)).thenReturn(tAuthor);
      // act
      final result = await mapper.mapTo(tGithubReleaseModel);
      // assert
      expect(result, equals(tGithubRelease));
    },
  );
}
