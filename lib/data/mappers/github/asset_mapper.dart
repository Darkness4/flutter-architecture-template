import 'package:flutter/foundation.dart';
import 'package:flutter_architecture_template/core/mappers/mapper.dart';
import 'package:flutter_architecture_template/data/mappers/github/user_mapper.dart';
import 'package:flutter_architecture_template/data/models/github/asset_model.dart';
import 'package:flutter_architecture_template/domain/entities/github/asset.dart';
import 'package:injectable/injectable.dart';

@prod
@lazySingleton
@injectable
class GithubAssetMapper implements Mapper<GithubAsset, GithubAssetModel> {
  final GithubUserMapper userMapper;

  const GithubAssetMapper({@required this.userMapper});

  @override
  GithubAssetModel mapFrom(GithubAsset entity) {
    return GithubAssetModel(
      url: entity.url,
      browser_download_url: entity.browser_download_url,
      id: entity.id,
      node_id: entity.node_id,
      name: entity.name,
      label: entity.label,
      state: entity.state,
      content_type: entity.content_type,
      size: entity.size,
      download_count: entity.download_count,
      created_at: entity.created_at,
      updated_at: entity.updated_at,
      uploader: userMapper.mapFrom(entity.uploader),
    );
  }

  @override
  GithubAsset mapTo(GithubAssetModel model) {
    return GithubAsset(
      url: model.url,
      browser_download_url: model.browser_download_url,
      id: model.id,
      node_id: model.node_id,
      name: model.name,
      label: model.label,
      state: model.state,
      content_type: model.content_type,
      size: model.size,
      download_count: model.download_count,
      created_at: model.created_at,
      updated_at: model.updated_at,
      uploader: userMapper.mapTo(model.uploader),
    );
  }
}
