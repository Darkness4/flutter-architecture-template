/// Github Release Model
///
/// Après avoir récupéré les données de Github API, les données doivent être
/// stocké dans des models.
///
/// [GithubReleaseModel] alimente [GithubRelease] et représente une release
/// d'après la documentation de Github API.
import 'package:equatable/equatable.dart';
import 'package:flutter_architecture_template/data/models/github/asset_model.dart';
import 'package:flutter_architecture_template/data/models/github/user_model.dart';
import 'package:flutter_architecture_template/domain/entities/github/release.dart';
import 'package:json_annotation/json_annotation.dart';

part 'release_model.g.dart';

@JsonSerializable(explicitToJson: true)
class GithubReleaseModel extends Equatable {
  final String url;
  final String html_url;
  final String assets_url;
  final String upload_url;
  final String tarball_url;
  final String zipball_url;
  final int id;
  final String node_id;
  final String tag_name;
  final String target_commitish;
  final String name;
  final String body;
  final bool draft;
  final bool prerelease;
  final DateTime created_at;
  final DateTime published_at;
  final GithubUserModel author;
  final List<GithubAssetModel> assets;

  const GithubReleaseModel({
    this.url,
    this.html_url,
    this.assets_url,
    this.upload_url,
    this.tarball_url,
    this.zipball_url,
    this.id,
    this.node_id,
    this.tag_name,
    this.target_commitish,
    this.name,
    this.body,
    this.draft,
    this.prerelease,
    this.created_at,
    this.published_at,
    this.author,
    this.assets,
  });

  factory GithubReleaseModel.fromJson(Map<String, dynamic> json) =>
      _$GithubReleaseModelFromJson(json);

  @override
  List<Object> get props => <Object>[
        url,
        html_url,
        assets_url,
        upload_url,
        tarball_url,
        zipball_url,
        id,
        node_id,
        tag_name,
        target_commitish,
        name,
        body,
        draft,
        prerelease,
        created_at,
        published_at,
        author,
        assets,
      ];
  Map<String, dynamic> toJson() => _$GithubReleaseModelToJson(this);
}
