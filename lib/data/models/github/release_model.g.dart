// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'release_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GithubReleaseModel _$GithubReleaseModelFromJson(Map<String, dynamic> json) {
  return GithubReleaseModel(
    url: json['url'] as String,
    html_url: json['html_url'] as String,
    assets_url: json['assets_url'] as String,
    upload_url: json['upload_url'] as String,
    tarball_url: json['tarball_url'] as String,
    zipball_url: json['zipball_url'] as String,
    id: json['id'] as int,
    node_id: json['node_id'] as String,
    tag_name: json['tag_name'] as String,
    target_commitish: json['target_commitish'] as String,
    name: json['name'] as String,
    body: json['body'] as String,
    draft: json['draft'] as bool,
    prerelease: json['prerelease'] as bool,
    created_at: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    published_at: json['published_at'] == null
        ? null
        : DateTime.parse(json['published_at'] as String),
    author: json['author'] == null
        ? null
        : GithubUserModel.fromJson(json['author'] as Map<String, dynamic>),
    assets: (json['assets'] as List)
        ?.map((e) => e == null
            ? null
            : GithubAssetModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$GithubReleaseModelToJson(GithubReleaseModel instance) =>
    <String, dynamic>{
      'url': instance.url,
      'html_url': instance.html_url,
      'assets_url': instance.assets_url,
      'upload_url': instance.upload_url,
      'tarball_url': instance.tarball_url,
      'zipball_url': instance.zipball_url,
      'id': instance.id,
      'node_id': instance.node_id,
      'tag_name': instance.tag_name,
      'target_commitish': instance.target_commitish,
      'name': instance.name,
      'body': instance.body,
      'draft': instance.draft,
      'prerelease': instance.prerelease,
      'created_at': instance.created_at?.toIso8601String(),
      'published_at': instance.published_at?.toIso8601String(),
      'author': instance.author?.toJson(),
      'assets': instance.assets?.map((e) => e?.toJson())?.toList(),
    };
