import 'package:injectable/injectable.dart';
import 'package:mockito/mockito.dart';

import 'github_remote_data_source.dart';

@test
@injectable
@RegisterAs(GithubRemoteDataSource)
class MockGithubRemoteDataSource extends Mock
    implements GithubRemoteDataSource {}
