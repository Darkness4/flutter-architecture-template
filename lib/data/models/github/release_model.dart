import 'package:flutter/foundation.dart';
import 'package:flutter_architecture_template/data/models/github/asset_model.dart';
import 'package:flutter_architecture_template/data/models/github/user_model.dart';
import 'package:flutter_architecture_template/domain/entities/github/asset.dart';
import 'package:flutter_architecture_template/domain/entities/github/release.dart';

class GithubReleaseModel extends GithubRelease {
  const GithubReleaseModel({
    @required String url,
    @required String html_url,
    @required String assets_url,
    @required String upload_url,
    @required String tarball_url,
    @required String zipball_url,
    @required int id,
    @required String node_id,
    @required String tag_name,
    @required String target_commitish,
    @required String name,
    @required String body,
    @required bool draft,
    @required bool prerelease,
    @required DateTime created_at,
    @required DateTime published_at,
    @required GithubUserModel author,
    @required List<GithubAssetModel> assets,
  }) : super(
          url: url,
          html_url: html_url,
          assets_url: assets_url,
          upload_url: upload_url,
          tarball_url: tarball_url,
          zipball_url: zipball_url,
          id: id,
          node_id: node_id,
          tag_name: tag_name,
          target_commitish: target_commitish,
          name: name,
          body: body,
          draft: draft,
          prerelease: prerelease,
          created_at: created_at,
          published_at: published_at,
          author: author,
          assets: assets,
        );

  factory GithubReleaseModel.fromJson(Map<String, dynamic> json) {
    final List<Map<String, dynamic>> assets =
        List<Map<String, dynamic>>.from(json["assets"] as List<dynamic>);
    return GithubReleaseModel(
      url: json['url'] as String,
      html_url: json['html_url'] as String,
      assets_url: json['assets_url'] as String,
      upload_url: json['upload_url'] as String,
      tarball_url: json['tarball_url'] as String,
      zipball_url: json['zipball_url'] as String,
      id: int.parse(json['id'].toString()),
      node_id: json['node_id'] as String,
      tag_name: json['tag_name'] as String,
      target_commitish: json['target_commitish'] as String,
      name: json['name'] as String,
      body: json['body'] as String,
      draft: json['draft'].toString() == 'true',
      prerelease: json['prerelease'].toString() == 'true',
      created_at: DateTime.parse(json['created_at'] as String),
      published_at: DateTime.parse(json['published_at'] as String),
      author: GithubUserModel.fromJson(json['author'] as Map<String, dynamic>),
      assets: assets
          .map((Map<String, dynamic> asset) => GithubAssetModel.fromJson(asset))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'url': url,
        'html_url': html_url,
        'assets_url': assets_url,
        'upload_url': upload_url,
        'tarball_url': tarball_url,
        'zipball_url': zipball_url,
        'id': id,
        'node_id': node_id,
        'tag_name': tag_name,
        'target_commitish': target_commitish,
        'name': name,
        'body': body,
        'draft': draft,
        'prerelease': prerelease,
        'created_at': created_at.toIso8601String(),
        'published_at': published_at.toIso8601String(),
        'author': (author as GithubUserModel).toJson(),
        'assets': assets
            .map((GithubAsset asset) => (asset as GithubAssetModel).toJson())
            .toList(),
      };
}
