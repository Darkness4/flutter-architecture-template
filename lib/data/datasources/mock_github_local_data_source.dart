import 'package:injectable/injectable.dart';
import 'package:mockito/mockito.dart';

import 'github_local_data_source.dart';

@test
@injectable
@RegisterAs(GithubLocalDataSource)
class MockGithubLocalDataSource extends Mock implements GithubLocalDataSource {}
