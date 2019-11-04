import 'package:equatable/equatable.dart';
import 'package:flutter_architecture_template/domain/entities/github/user.dart';

class GithubAsset extends Equatable {
  final String url;
  final String browser_download_url;
  final int id;
  final String node_id;
  final String name;
  final String label;
  final String state;
  final String content_type;
  final int size;
  final int download_count;
  final DateTime created_at;
  final DateTime updated_at;
  final GithubUser uploader;

  const GithubAsset({
    this.url,
    this.browser_download_url,
    this.id,
    this.node_id,
    this.name,
    this.label,
    this.state,
    this.content_type,
    this.size,
    this.download_count,
    this.created_at,
    this.updated_at,
    this.uploader,
  });

  @override
  List<Object> get props => <Object>[
        url,
        browser_download_url,
        id,
        node_id,
        name,
        label,
        state,
        content_type,
        size,
        download_count,
        created_at,
        updated_at,
        uploader,
      ];
}
