// Imports the Flutter Driver API.
import 'dart:io';

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import 'constants.dart' as pym;

void main() {
  group('PYM Navigation Testing', () {
    FlutterDriver driver;

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      await driver?.close();
    });

    test('Check flutter driver health', () async {
      final Health health = await driver.checkHealth();
      print(health.status);
      expect(health.status, equals(HealthStatus.ok));
    });

    group('Automated screenshot', () {
      test('Screenshot login', () async {
        await takeScreenshot(driver, pym.ScreenshotsPaths.login);
      });

      test('Screenshot apps', () async {
        await driver.tap(find.byTooltip(pym.Tooltips.drawer));
        await driver.tap(find.byValueKey(pym.Keys.authentication));
      });
    });
  });
}

Future<void> takeScreenshot(FlutterDriver driver, String path) async {
  await driver.waitUntilNoTransientCallbacks();
  final List<int> pixels = await driver.screenshot();
  final File file = File(path);
  await file.writeAsBytes(pixels);
  print(path);
}
