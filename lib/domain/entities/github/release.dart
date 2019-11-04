import 'package:equatable/equatable.dart';
import 'package:flutter_architecture_template/domain/entities/github/asset.dart';
import 'package:flutter_architecture_template/domain/entities/github/user.dart';

class GithubRelease extends Equatable {
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
  final GithubUser author;
  final List<GithubAsset> assets;

  const GithubRelease({
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
}
