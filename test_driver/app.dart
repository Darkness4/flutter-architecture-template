import 'package:flutter_driver/driver_extension.dart';
import 'package:flutter_architecture_template/main.dart' as app;

void main() {
  // This line enables the extension.
  enableFlutterDriverExtension();
  print("FLUTTER DRIVER ENABLED");

  // Call the `main()` function of the app, or call `runApp` with
  // any widget you are interested in testing.
  app.main();
}
