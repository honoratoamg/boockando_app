import 'package:boockando_app/app/repositories/shared/utils/local_notification_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_stetho/flutter_stetho.dart';
import 'app/app_module.dart';

main() async {
  await Stetho.initialize();
  await LocalNotificationUtils.initializeSettings();
  runApp(ModularApp(module: AppModule()));
}
