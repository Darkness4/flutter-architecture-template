import 'package:injectable/injectable.dart';
import 'package:mockito/mockito.dart';

import 'network_info.dart';

@RegisterAs(NetworkInfo)
@test
@injectable
class MockNetworkInfo extends Mock implements NetworkInfo {}
