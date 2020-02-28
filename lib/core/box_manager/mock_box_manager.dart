import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:mockito/mockito.dart';

import 'box_manager.dart';

@test
@injectable
@lazySingleton
@RegisterAs(BoxManager)
class MockBoxManager extends Mock implements BoxManager {
  @override
  final Box<String> githubBox = MockBox<String>();
}

class MockBox<T> extends Mock implements Box<T> {}
