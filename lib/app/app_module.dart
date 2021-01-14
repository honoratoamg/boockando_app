import 'package:boockando_app/app/data/online/user_online_dao.dart';

import 'controllers/app_basket_controller.dart';
import 'controllers/app_book_controller.dart';
import 'package:boockando_app/app/controllers/app_user_configs_controller.dart';
import 'package:boockando_app/app/modules/splash_screen/splash_screen_module.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app_controller.dart';
import 'app_widget.dart';
import 'controllers/app_user_controller.dart';
import 'data/online/basket_online_dao.dart';
import 'data/online/book_online_dao.dart';
import 'modules/home/home_module.dart';

class AppModule extends MainModule {
  @override
  // Lista de injecoes de dependencia do projeto
  List<Bind> get binds => [
        Bind((i) => AppController()),
        Bind((i) => UserConfigsController()),
        Bind((i) => AppBookController()),
        Bind((i) => AppUserController()),
        Bind((i) => AppBasketController()),
        Bind((i) => UserOnlineDao()),
        Bind((i) => BookOnlineDao()),
        Bind((i) => BasketOnlineDao()),
      ];

  @override
  // Root Widget
  Widget get bootstrap => AppWidget();

  @override
  // Modulos associados a este aplicativo
  List<ModularRouter> get routers => [
        ModularRouter(SplashModule.routeName, module: SplashModule()),
        ModularRouter(HomeModule.routeName, module: HomeModule()),
      ];
}
