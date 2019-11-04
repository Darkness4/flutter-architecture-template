import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:flutter_architecture_template/core/error/exceptions.dart';
import 'package:flutter_architecture_template/data/models/github/release_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  final SharedPreferences sharedPreferences;

  GithubLocalDataSourceImpl({@required this.sharedPreferences});

  @override
  Future<void> cacheReleases(
      List<GithubReleaseModel> releasesToCache, String repo) {
    return sharedPreferences.setString(
      repo,
      json.encode(releasesToCache
          .map((GithubReleaseModel release) => release.toJson())
          .toList()),
    );
  }

  @override
  Future<List<GithubReleaseModel>> fetchLastReleases(String repo) {
    final jsonString = sharedPreferences.getString(repo);
    if (jsonString != null) {
      return Future<List<GithubReleaseModel>>.value(
          List<Map<String, dynamic>>.from(
                  json.decode(jsonString) as List<dynamic>)
              .map((Map<String, dynamic> data) =>
                  GithubReleaseModel.fromJson(data))
              .toList());
    } else {
      throw CacheException();
    }
  }
}
