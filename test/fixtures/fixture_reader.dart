import 'dart:io';
import 'package:path/path.dart';

String fixture(String name) {
  final testDirectory = join(
    Directory.current.path,
    Directory.current.path.endsWith('test') ? '' : 'test',
  );
  return File('$testDirectory/fixtures/$name').readAsStringSync();
}
