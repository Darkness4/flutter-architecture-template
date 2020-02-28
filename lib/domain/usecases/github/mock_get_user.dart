import 'package:injectable/injectable.dart';
import 'package:mockito/mockito.dart';

import 'get_user.dart';

@test
@injectable
@RegisterAs(GetGithubUser)
class MockGetGithubUser extends Mock implements GetGithubUser {}
