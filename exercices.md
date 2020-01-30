# Exercice : Test-Driven Development et Clean Architecture

Utilisez ce template https://github.com/Darkness4/flutter-architecture-template.

Objectif : **Afficher les propriétés d'un utilisateur de Gitlab**

Théorie : https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html

Le cours de Resocoder : https://resocoder.com/flutter-clean-architecture-tdd/

## Cahier des Charges

### Use Case

- L'utilisateur doit pouvoir récupérer les propriérés d'un utilisateur de Gitlab à partir de son id.

### Back-End

#### Data Source

**Remote** : **Gitlab API v4** (API REST, sortie en json) :  `GET https://gitlab.com/api/v4/users/:id`

#### Model

Utilisateur Gitlab : https://docs.gitlab.com/ee/api/users.html#for-user

- id
- username
- name
- state
- ... (le reste n'est pas utile)

### Front-end

#### Reactive Programing

On utilisera un **BLoC**.

##### Events

Récupérer un utilisateur Gitlab.

##### States

4 states :

- Initial
- Chargement
- Chargé
- Erreur

#### Page

##### Initial

Doit entrer des inputs numerique qui correspond à l'id utilisateur. On confirme la recherche via le clavier.

##### Chargé

Affiche du texte brut.

##### Erreur

Affiche du texte brut en rouge.

##### Chargement

CircleProgressIndicator.

#### Routing

Via BottomNavigationBar.

### Autres

Vous assurerez l'**injection des dépendances**.

## Consignes

### 1. Implémentez le model `GitlabUserModel` et son entity `GitlabUser`.

1. `domain/entities/gitlab_user.dart` : `GitlabUser`  **hérite** de Equatable et contient :
   1. Quelques  les données cités ci-dessus.
   2. Le constructeur
   3. L’implémentation de Equatable
   4. Voir `domain/entities/github/user.dart`
2. `data/models/gitlab_user_model.dart` : Faites une class `GitlabUserModel` qui **hérite** de `GitlabUser` et contient :
   1. Le constructeur et son super
   2. fromJson
   3. toJson
   4. Voir data/models/github/user_model.dart

### 2. Implémentez le datasource `GitlabRemoteDataSource`

1. `data/datasources/gitlab_remote_data_source.dart` : Faites une class `GitlabRemoteDataSource` et contient :
   1. `Future<GitlabUserModel> getUser(int id);`
2. `data/datasources/gitlab_remote_data_source.dart` : Faites une class `GitlabRemoteDataSourceImpl` qui **implémente** `GitlabRemoteDataSource` et contient :
   1. Un attribut public http.Client en dépendances (mettre dans le constructeur, argument nommé @required)
   2. La fonction à override et implémenter
3. GET https://gitlab.com/api/v4/users/:id
4. Voir data/datasources/github_remote_data_source.dart

### 3. Implémentez un repository ` GitlabUserRepository ` et son implémentation ` GitlabUserRepositoryImpl`

1. `domain/repositories/gitlab_user_repository.dart` : Faites une class `GitlabUserRepository` qui contient :
   1. `Future<GitlabUser> getUser(int id);`
2. `data/repositories/gitlab_user_repository_impl.dart` : Faites une class `GitlabUserRepositoryImpl` qui **implémente** de `GitlabUserRepository` et contient :
   1. Attrib. pub. : GitlabRemoteDataSource
   2. Le constructeur
   3. Les implémentations

### 4. Implémentez le usecase `GetGitlabUser`

NOTE: La class Usecase est déjà faite.

1. `domain/usecases/get_gitlab_user.dart` : Faites une class `GetGitlabUser` qui **hérite** de `Usecase<GitlabUser, Params>` et contient :
   1. Le `GitlabUserRepository`
   2. `@override Future<GitlabUser> call(Params params) async …`
   3. **Faites en même temps la class Params qui hérite de Equatable.**

### 5. Implémentez l'event `GetGitlabEvent`

`presentation/blocs/gitlab_user/gitlab_user_event.dart` : 

NOTE : Un BLoC doit correspondre au **usecase**.

```dart
@immutable
abstract class GitlabUserEvent extends Equatable {
  const GitlabUserEvent();
}

class GetGitlabUserEvent extends GitlabUserEvent {
  final int id;

  const GetGitlabUserEvent(this.id);

  @override
  List<Object> get props => [id];
}
```

### 6. Implémentez les states

`presentation/blocs/gitlab_user/gitlab_user_state.dart` : 

```dart
@immutable
abstract class GitlabUserState extends Equatable {
  const GitlabUserState();
}

class GitlabUserStateError extends GitlabUserState {
  final String message;

  const GitlabUserStateError({@required this.message});

  @override
  List<Object> get props => [message];
}

class GitlabUserStateInitial extends GitlabUserState {}

class GitlabUserStateLoaded extends GitlabUserState {
  final GitlabUser user;

  const GitlabUserStateLoaded({@required this.user});

  @override
  List<Object> get props => [releases];
}

class GitlabUserStateLoading extends GitlabUserState {}
```

#### 7. Implémentez le BLoC

`presentation/blocs/gitlab_user/gitlab_user_bloc.dart` : 

```dart
class GitlabUserBloc
    extends Bloc<GitlabUserEvent, GitlabUserState> {
  final GetGitlabUser getGitlabUser;

  GitlabUserBloc({
    @required this.getGitlabUser,
  }) : assert(getGitlabUser != null);

  @override
  GitlabUserState get initialState => const GitlabUserStateInitial();

  @override
  Stream<GitlabUserState> mapEventToState(
    GitlabUserEvent event,
  ) async* {
    if (event is GetGitlabUserEvent) {
      yield const GitlabUserStateLoading();
      try {
        final user = await getGitlabUser(Params(event.user));
        yield GitlabUserStateLoaded(user: user);
      } catch (e) {
        yield GitlabUserStateError(message: e.toString());
      }
    }
  }
}
```

### 8. Ajoutez les dépendances

```dart
  // Bloc
  sl.registerFactory(
    () => GitlabUserBloc(
      getGitlabUser: sl<GitlabUserRepository>(),
    ),
  );
  // Use cases
  sl.registerLazySingleton(
    () => GetGitlabUser(sl<GitlabUserRepository>()),
  );
  sl.registerLazySingleton<GitlabUserRepository>(
    () => GitlabUserRepositoryImpl(
      remoteDataSource: sl<GitlabRemoteDataSource>(),
    ),
  );
  // Data sources
  sl.registerLazySingleton<GitlabRemoteDataSource>(
    () => GitlabRemoteDataSourceImpl(client: sl<http.Client>()),
  );
```

### 9. Faites votre page

Inspirez vous sans hésiter de la page `github_user_page.dart`.

`CURRENT_PAGE = 2`

Routage :

- Ajoutez le nom de votre route dans **core/routes.dart**
- Ajoutez votre route vers votre page dans **presentation/router.dart**
- Dans **presentation/widgets/bottom_navigation_bar.dart**,
  - Réglez le MainBottomNavigationBar  
  - Ajoutez un BottomNavigationBarItem
  - Complétez le case 2.

### 10. Faites vos controls et display

Controls : Textfield

Loading : CircleProgressIndicator

Loaded/Error : Text

## Il ne reste plus que les tests unitaires !

Essayez de recopier `github_user`.