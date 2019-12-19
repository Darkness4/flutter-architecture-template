// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'asset_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GithubAssetModel _$GithubAssetModelFromJson(Map<String, dynamic> json) {
  return GithubAssetModel(
    url: json['url'] as String,
    browser_download_url: json['browser_download_url'] as String,
    id: json['id'] as int,
    node_id: json['node_id'] as String,
    name: json['name'] as String,
    label: json['label'] as String,
    state: json['state'] as String,
    content_type: json['content_type'] as String,
    size: json['size'] as int,
    download_count: json['download_count'] as int,
    created_at: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    updated_at: json['updated_at'] == null
        ? null
        : DateTime.parse(json['updated_at'] as String),
    uploader: json['uploader'] == null
        ? null
        : GithubUserModel.fromJson(json['uploader'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$GithubAssetModelToJson(GithubAssetModel instance) =>
    <String, dynamic>{
      'url': instance.url,
      'browser_download_url': instance.browser_download_url,
      'id': instance.id,
      'node_id': instance.node_id,
      'name': instance.name,
      'label': instance.label,
      'state': instance.state,
      'content_type': instance.content_type,
      'size': instance.size,
      'download_count': instance.download_count,
      'created_at': instance.created_at?.toIso8601String(),
      'updated_at': instance.updated_at?.toIso8601String(),
      'uploader': instance.uploader?.toJson(),
    };
