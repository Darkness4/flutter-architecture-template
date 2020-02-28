import 'package:flutter_architecture_template/domain/entities/github/asset.dart';
import 'package:flutter_architecture_template/domain/entities/github/release.dart';
import 'package:flutter_architecture_template/domain/entities/github/user.dart';
import 'package:flutter_architecture_template/domain/repositories/github/releases_repository.dart';
import 'package:flutter_architecture_template/domain/usecases/github/get_releases.dart';
import 'package:flutter_architecture_template/injection_container.dart';
import 'package:injectable/injectable.dart' show Environment;
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  GetGithubReleases usecase;
  ReleasesRepository mockReleasesRepository;

  init(env: Environment.test);

  setUp(() {
    mockReleasesRepository = sl<ReleasesRepository>();
    usecase = GetGithubReleases(mockReleasesRepository);
  });

  const tRepo = 'Darkness4/minitel-app';
  final DateTime tDateTime = DateTime.parse("1970-01-01T00:00:00.000Z");
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
    author: const GithubUser(
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
    assets: <GithubAsset>[
      GithubAsset(
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
        uploader: const GithubUser(
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
  final tListGithubRelease = <GithubRelease>[tGithubRelease];

  test(
    'should get releases from the repository',
    () async {
      // arrange
      when(mockReleasesRepository.getReleases(any))
          .thenAnswer((_) async => tListGithubRelease);
      // act
      final result = await usecase(tRepo);
      // assert
      expect(result, tListGithubRelease);
      verify(mockReleasesRepository.getReleases(tRepo));
      verifyNoMoreInteractions(mockReleasesRepository);
    },
  );
}
