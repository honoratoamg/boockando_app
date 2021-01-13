import 'package:boockando_app/app/controllers/user_configs_controller.dart';
import 'package:boockando_app/app/modules/splash_screen/splash_screen_module.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app_controller.dart';
import 'app_widget.dart';

class AppModule extends MainModule {
  @override
  // Lista de injecoes de dependencia do projeto
  List<Bind> get binds =>
      [Bind((i) => AppController()), Bind((i) => UserConfigsController())];

  @override
  // Root Widget
  Widget get bootstrap => AppWidget();

  @override
  // Modulos associados a este aplicativo
  List<ModularRouter> get routers => [
        ModularRouter(SplashModule.routeName, module: SplashModule()),
      ];
}
