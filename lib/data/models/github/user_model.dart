import 'package:flutter/foundation.dart';
import 'package:flutter_architecture_template/domain/entities/github/user.dart';

class GithubUserModel extends GithubUser {
  const GithubUserModel({
    @required String login,
    @required int id,
    @required String node_id,
    @required String avatar_url,
    @required String gravatar_id,
    @required String url,
    @required String html_url,
    @required String followers_url,
    @required String following_url,
    @required String gists_url,
    @required String starred_url,
    @required String subscriptions_url,
    @required String organizations_url,
    @required String repos_url,
    @required String events_url,
    @required String received_events_url,
    @required String type,
    @required bool site_admin,
    String name,
    String company,
    String blog,
    String location,
    String email,
    bool hireable,
    String bio,
    int public_repos,
    int public_gists,
    int followers,
    int following,
    DateTime created_at,
    DateTime updated_at,
  }) : super(
          login: login,
          id: id,
          node_id: node_id,
          avatar_url: avatar_url,
          gravatar_id: gravatar_id,
          url: url,
          html_url: html_url,
          followers_url: followers_url,
          following_url: following_url,
          gists_url: gists_url,
          starred_url: starred_url,
          subscriptions_url: subscriptions_url,
          organizations_url: organizations_url,
          repos_url: repos_url,
          events_url: events_url,
          received_events_url: received_events_url,
          type: type,
          site_admin: site_admin,
          name: name,
          company: company,
          blog: blog,
          location: location,
          email: email,
          hireable: hireable,
          bio: bio,
          public_repos: public_repos,
          public_gists: public_gists,
          followers: followers,
          following: following,
          created_at: created_at,
          updated_at: updated_at,
        );

  factory GithubUserModel.fromJson(Map<String, dynamic> json) {
    return GithubUserModel(
      login: json['login'] as String,
      id: int.parse(json['id'].toString()),
      node_id: json['node_id'] as String,
      avatar_url: json['avatar_url'] as String,
      gravatar_id: json['gravatar_id'] as String,
      url: json['url'] as String,
      html_url: json['html_url'] as String,
      followers_url: json['followers_url'] as String,
      following_url: json['following_url'] as String,
      gists_url: json['gists_url'] as String,
      starred_url: json['starred_url'] as String,
      subscriptions_url: json['subscriptions_url'] as String,
      organizations_url: json['organizations_url'] as String,
      repos_url: json['repos_url'] as String,
      events_url: json['events_url'] as String,
      received_events_url: json['received_events_url'] as String,
      type: json['type'] as String,
      site_admin: json['site_admin'].toString() == 'true',
      name: json['name']?.toString(),
      company: json['company']?.toString(),
      blog: json['blog']?.toString(),
      location: json['location']?.toString(),
      email: json['email']?.toString(),
      hireable: json['hireable'] == null
          ? null
          : json['hireable'].toString() == 'true',
      bio: json['bio']?.toString(),
      public_repos: json['public_repos'] == null
          ? null
          : int.parse(json['public_repos'].toString()),
      public_gists: json['public_gists'] == null
          ? null
          : int.parse(json['public_gists'].toString()),
      followers: json['followers'] == null
          ? null
          : int.parse(json['followers'].toString()),
      following: json['following'] == null
          ? null
          : int.parse(json['following'].toString()),
      created_at: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'].toString()),
      updated_at: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'].toString()),
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'login': login,
        'id': id,
        'node_id': node_id,
        'avatar_url': avatar_url,
        'gravatar_id': gravatar_id,
        'url': url,
        'html_url': html_url,
        'followers_url': followers_url,
        'following_url': following_url,
        'gists_url': gists_url,
        'starred_url': starred_url,
        'subscriptions_url': subscriptions_url,
        'organizations_url': organizations_url,
        'repos_url': repos_url,
        'events_url': events_url,
        'received_events_url': received_events_url,
        'type': type,
        'site_admin': site_admin,
        'name': name,
        'company': company,
        'blog': blog,
        'location': location,
        'email': email,
        'hireable': hireable,
        'bio': bio,
        'public_repos': public_repos,
        'public_gists': public_gists,
        'followers': followers,
        'following': following,
        'created_at': created_at?.toIso8601String(),
        'updated_at': updated_at?.toIso8601String(),
      };
}
