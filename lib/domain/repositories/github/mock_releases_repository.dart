import 'package:injectable/injectable.dart';
import 'package:mockito/mockito.dart';

import 'releases_repository.dart';

@test
@injectable
@RegisterAs(ReleasesRepository)
class MockReleasesRepository extends Mock implements ReleasesRepository {}
