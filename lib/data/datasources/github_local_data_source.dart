/// Github Local Data Source
///
/// C'est ici que vous récupérez les données local de Github socké sur le
/// téléphone.
///
/// SharedPreferences est la source local.

import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:flutter_architecture_template/core/error/exceptions.dart';
import 'package:flutter_architecture_template/data/models/github/release_model.dart';

abstract class GithubLocalDataSource {
  Future<void> cacheReleases(
      List<GithubReleaseModel> releasesToCache, String repo);

  /// Gets the cached [List<GithubReleaseModel>] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [CacheException] if no cached data is present.
  Future<List<GithubReleaseModel>> fetchLastReleases(String repo);
}

class GithubLocalDataSourceImpl implements GithubLocalDataSource {
  final Box<dynamic> box;

  GithubLocalDataSourceImpl({@required this.box});

  @override
  Future<void> cacheReleases(
      List<GithubReleaseModel> releasesToCache, String repo) {
    return box.put(
      repo,
      json.encode(releasesToCache
          .map((GithubReleaseModel release) => release.toJson())
          .toList()),
    );
  }

  @override
  Future<List<GithubReleaseModel>> fetchLastReleases(String repo) async {
    final jsonString = box.get(repo) as String;
    if (jsonString != null) {
      return List<Map<String, dynamic>>.from(
              json.decode(jsonString) as List<dynamic>)
          .map((Map<String, dynamic> data) => GithubReleaseModel.fromJson(data))
          .toList();
    } else {
      throw CacheException();
    }
  }
}
