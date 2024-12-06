import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quotation_calculation/src/app/app.dart';
import 'package:quotation_calculation/src/core/views/system_error_screen.dart';
import 'package:quotation_calculation/src/app/injection_container.dart' as di;
void main() {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await di.init();
    ErrorWidget.builder = (errorDetails) => const CustomSystemErrorScreen();
    runApp(const App());
  }, (error, stack) =>
      print(error));
}

