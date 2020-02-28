/// Github Local Data Source
///
/// C'est ici que vous récupérez les données local de Github socké sur le
/// téléphone.
///
/// SharedPreferences est la source local.

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_architecture_template/core/box_manager/box_manager.dart';
import 'package:flutter_architecture_template/data/models/github/user_model.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_architecture_template/core/error/exceptions.dart';
import 'package:flutter_architecture_template/data/models/github/release_model.dart';

abstract class GithubLocalDataSource {
  Future<void> cacheReleases(
      List<GithubReleaseModel> releasesToCache, String repo);

  Future<List<GithubReleaseModel>> fetchLastReleases(String repo);

  Future<void> cacheUser(GithubUserModel userToCache, String username);

  Future<GithubUserModel> fetchCachedUser(String username);
}

@RegisterAs(GithubLocalDataSource)
@prod
@lazySingleton
@injectable
class GithubLocalDataSourceImpl implements GithubLocalDataSource {
  final BoxManager boxManager;

  GithubLocalDataSourceImpl({@required this.boxManager});

  @override
  Future<void> cacheReleases(
      List<GithubReleaseModel> releasesToCache, String repo) {
    return boxManager.githubBox.put(
      repo,
      json.encode(releasesToCache
          .map((GithubReleaseModel release) => release.toJson())
          .toList()),
    );
  }

  @override
  Future<List<GithubReleaseModel>> fetchLastReleases(String repo) async {
    final jsonString = boxManager.githubBox.get(repo);
    if (jsonString != null) {
      return List<Map<String, dynamic>>.from(
              json.decode(jsonString) as List<dynamic>)
          .map((Map<String, dynamic> data) => GithubReleaseModel.fromJson(data))
          .toList();
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheUser(GithubUserModel userToCache, String username) {
    return boxManager.githubBox.put(
      username,
      json.encode(userToCache.toJson()),
    );
  }

  @override
  Future<GithubUserModel> fetchCachedUser(String username) async {
    final jsonString = boxManager.githubBox.get(username);
    if (jsonString != null) {
      return GithubUserModel.fromJson(
          json.decode(jsonString) as Map<String, dynamic>);
    } else {
      throw CacheException();
    }
  }
}
