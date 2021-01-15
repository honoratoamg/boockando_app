import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_stetho/flutter_stetho.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app/app_module.dart';

main() async {
  await Stetho.initialize();
  //SharedPreferences.setMockInitialValues({});
  runApp(ModularApp(module: AppModule()));
}
