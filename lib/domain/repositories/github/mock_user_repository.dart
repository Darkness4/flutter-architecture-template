import 'package:injectable/injectable.dart';
import 'package:mockito/mockito.dart';

import 'user_repository.dart';

@test
@injectable
@RegisterAs(UserRepository)
class MockUserRepository extends Mock implements UserRepository {}
