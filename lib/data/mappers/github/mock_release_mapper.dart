import 'package:injectable/injectable.dart';
import 'package:mockito/mockito.dart';

import 'release_mapper.dart';

@test
@injectable
@RegisterAs(GithubReleaseMapper)
class MockGithubReleaseMapper extends Mock implements GithubReleaseMapper {}
