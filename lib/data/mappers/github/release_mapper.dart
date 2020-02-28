import 'package:flutter/foundation.dart';
import 'package:flutter_architecture_template/core/mappers/mapper.dart';
import 'package:flutter_architecture_template/data/mappers/github/asset_mapper.dart';
import 'package:flutter_architecture_template/data/mappers/github/user_mapper.dart';
import 'package:flutter_architecture_template/data/models/github/release_model.dart';
import 'package:flutter_architecture_template/domain/entities/github/release.dart';
import 'package:injectable/injectable.dart';

@prod
@lazySingleton
@injectable
class GithubReleaseMapper implements Mapper<GithubRelease, GithubReleaseModel> {
  final GithubUserMapper userMapper;
  final GithubAssetMapper assetMapper;

  const GithubReleaseMapper({
    @required this.userMapper,
    @required this.assetMapper,
  });

  @override
  GithubReleaseModel mapFrom(GithubRelease entity) {
    return GithubReleaseModel(
      url: entity.url,
      html_url: entity.html_url,
      assets_url: entity.assets_url,
      upload_url: entity.upload_url,
      tarball_url: entity.tarball_url,
      zipball_url: entity.zipball_url,
      id: entity.id,
      node_id: entity.node_id,
      tag_name: entity.tag_name,
      target_commitish: entity.target_commitish,
      name: entity.name,
      body: entity.body,
      draft: entity.draft,
      prerelease: entity.prerelease,
      created_at: entity.created_at,
      published_at: entity.published_at,
      author: userMapper.mapFrom(entity.author),
      assets: entity.assets.map(assetMapper.mapFrom).toList(),
    );
  }

  @override
  GithubRelease mapTo(GithubReleaseModel model) {
    return GithubRelease(
      url: model.url,
      html_url: model.html_url,
      assets_url: model.assets_url,
      upload_url: model.upload_url,
      tarball_url: model.tarball_url,
      zipball_url: model.zipball_url,
      id: model.id,
      node_id: model.node_id,
      tag_name: model.tag_name,
      target_commitish: model.target_commitish,
      name: model.name,
      body: model.body,
      draft: model.draft,
      prerelease: model.prerelease,
      created_at: model.created_at,
      published_at: model.published_at,
      author: userMapper.mapTo(model.author),
      assets: model.assets.map(assetMapper.mapTo).toList(),
    );
  }
}
