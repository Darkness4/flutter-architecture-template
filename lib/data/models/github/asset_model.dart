import 'package:flutter/foundation.dart';
import 'package:flutter_architecture_template/data/models/github/user_model.dart';
import 'package:flutter_architecture_template/domain/entities/github/asset.dart';

class GithubAssetModel extends GithubAsset {
  const GithubAssetModel({
    @required String url,
    @required String browser_download_url,
    @required int id,
    @required String node_id,
    @required String name,
    @required String label,
    @required String state,
    @required String content_type,
    @required int size,
    @required int download_count,
    @required DateTime created_at,
    @required DateTime updated_at,
    @required GithubUserModel uploader,
  }) : super(
          url: url,
          browser_download_url: browser_download_url,
          id: id,
          node_id: node_id,
          name: name,
          label: label,
          state: state,
          content_type: content_type,
          size: size,
          download_count: download_count,
          created_at: created_at,
          updated_at: updated_at,
          uploader: uploader,
        );

  factory GithubAssetModel.fromJson(Map<String, dynamic> json) {
    return GithubAssetModel(
      url: json['url'] as String,
      browser_download_url: json['browser_download_url'] as String,
      id: int.parse(json['id'].toString()),
      node_id: json['node_id'] as String,
      name: json['name'] as String,
      label: json['label'] as String,
      state: json['state'] as String,
      content_type: json['content_type'] as String,
      size: int.parse(json['size'].toString()),
      download_count: int.parse(json['download_count'].toString()),
      created_at: DateTime.parse(json['created_at'] as String),
      updated_at: DateTime.parse(json['updated_at'] as String),
      uploader:
          GithubUserModel.fromJson(json['uploader'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'url': url,
        'browser_download_url': browser_download_url,
        'id': id,
        'node_id': node_id,
        'name': name,
        'label': label,
        'state': state,
        'content_type': content_type,
        'size': size,
        'download_count': download_count,
        'created_at': created_at.toIso8601String(),
        'updated_at': updated_at.toIso8601String(),
        'uploader': (uploader as GithubUserModel).toJson(),
      };
}
