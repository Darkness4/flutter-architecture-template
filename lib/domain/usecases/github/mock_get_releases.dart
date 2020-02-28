import 'package:injectable/injectable.dart';
import 'package:mockito/mockito.dart';

import 'get_releases.dart';

@test
@injectable
@RegisterAs(GetGithubReleases)
class MockGetGithubReleases extends Mock implements GetGithubReleases {}
