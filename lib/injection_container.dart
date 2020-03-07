import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injection_container.iconfig.dart';

final sl = GetIt.instance;

@injectableInit
Future<void> init({String env = Environment.prod}) async {
  $initGetIt(sl, environment: env);
}
