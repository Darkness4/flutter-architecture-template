import 'package:injectable/injectable.dart';
import 'package:mockito/mockito.dart';

import 'user_mapper.dart';

@test
@injectable
@RegisterAs(GithubUserMapper)
class MockGithubUserMapper extends Mock implements GithubUserMapper {}
