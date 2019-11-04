import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_architecture_template/core/error/exceptions.dart';
import 'package:flutter_architecture_template/data/models/github/release_model.dart';
import 'package:flutter_architecture_template/data/models/github/user_model.dart';

abstract class GithubRemoteDataSource {
  Future<List<GithubReleaseModel>> fetchReleases(String repo);

  Future<GithubUserModel> fetchUser(String username);
}

class GithubRemoteDataSourceImpl implements GithubRemoteDataSource {
  final http.Client client;

  GithubRemoteDataSourceImpl({@required this.client});

  /// [repo] = author/repo
  @override
  Future<List<GithubReleaseModel>> fetchReleases(String repo) async {
    final response =
        await client.get('https://api.github.com/repos/$repo/releases');

    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(
              json.decode(response.body) as List<dynamic>)
          .map((Map<String, dynamic> data) => GithubReleaseModel.fromJson(data))
          .toList();
    } else {
      throw ServerException('Failed to load releases : ${response.statusCode}');
    }
  }

  @override
  Future<GithubUserModel> fetchUser(String username) async {
    final response = await client.get('https://api.github.com/users/$username');

    if (response.statusCode == 200) {
      return GithubUserModel.fromJson(
          json.decode(response.body) as Map<String, dynamic>);
    } else {
      throw ServerException('Failed to load User : ${response.statusCode}');
    }
  }
}
