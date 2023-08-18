import 'package:filmcrate/core/app.dart';
import 'package:filmcrate/core/network/local/hive_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  HiveService().init();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
}
