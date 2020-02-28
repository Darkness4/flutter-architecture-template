import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

abstract class BoxManager {
  Box<String> get githubBox;
}

@prod
@injectable
@lazySingleton
@RegisterAs(BoxManager)
class BoxManagerImpl implements BoxManager {
  @override
  Box<String> get githubBox => Hive.box<String>('prefs');
}
