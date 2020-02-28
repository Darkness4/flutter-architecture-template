import 'package:flutter_architecture_template/core/mappers/mapper.dart';
import 'package:flutter_architecture_template/data/models/github/user_model.dart';
import 'package:flutter_architecture_template/domain/entities/github/user.dart';
import 'package:injectable/injectable.dart';

@prod
@lazySingleton
@injectable
class GithubUserMapper implements Mapper<GithubUser, GithubUserModel> {
  const GithubUserMapper();

  @override
  GithubUserModel mapFrom(GithubUser entity) {
    return GithubUserModel(
      login: entity.login,
      id: entity.id,
      node_id: entity.node_id,
      avatar_url: entity.avatar_url,
      gravatar_id: entity.gravatar_id,
      url: entity.url,
      html_url: entity.html_url,
      followers_url: entity.followers_url,
      following_url: entity.following_url,
      gists_url: entity.gists_url,
      starred_url: entity.starred_url,
      subscriptions_url: entity.subscriptions_url,
      organizations_url: entity.organizations_url,
      repos_url: entity.repos_url,
      events_url: entity.events_url,
      received_events_url: entity.received_events_url,
      type: entity.type,
      site_admin: entity.site_admin,
      name: entity.name,
      company: entity.company,
      blog: entity.blog,
      location: entity.location,
      email: entity.email,
      hireable: entity.hireable,
      bio: entity.bio,
      public_repos: entity.public_repos,
      public_gists: entity.public_gists,
      followers: entity.followers,
      following: entity.following,
      created_at: entity.created_at,
      updated_at: entity.updated_at,
    );
  }

  @override
  GithubUser mapTo(GithubUserModel model) {
    return GithubUser(
      login: model.login,
      id: model.id,
      node_id: model.node_id,
      avatar_url: model.avatar_url,
      gravatar_id: model.gravatar_id,
      url: model.url,
      html_url: model.html_url,
      followers_url: model.followers_url,
      following_url: model.following_url,
      gists_url: model.gists_url,
      starred_url: model.starred_url,
      subscriptions_url: model.subscriptions_url,
      organizations_url: model.organizations_url,
      repos_url: model.repos_url,
      events_url: model.events_url,
      received_events_url: model.received_events_url,
      type: model.type,
      site_admin: model.site_admin,
      name: model.name,
      company: model.company,
      blog: model.blog,
      location: model.location,
      email: model.email,
      hireable: model.hireable,
      bio: model.bio,
      public_repos: model.public_repos,
      public_gists: model.public_gists,
      followers: model.followers,
      following: model.following,
      created_at: model.created_at,
      updated_at: model.updated_at,
    );
  }
}
