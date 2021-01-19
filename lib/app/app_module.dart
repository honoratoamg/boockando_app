import 'package:boockando_app/app/data/online/user_online_dao.dart';
import 'package:boockando_app/app/modules/login/login_module.dart';

import 'controllers/app_basket_controller.dart';
import 'controllers/app_book_controller.dart';
import 'package:boockando_app/app/controllers/app_user_configs_controller.dart';
import 'package:boockando_app/app/modules/splash_screen/splash_screen_module.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app_controller.dart';
import 'app_widget.dart';
import 'controllers/app_user_controller.dart';
import 'data/local/basket_books_dao.dart';
import 'data/local/basket_dao.dart';
import 'data/local/book_dao.dart';
import 'data/local/purchase_dao.dart';
import 'data/online/basket_online_dao.dart';
import 'data/online/book_online_dao.dart';
import 'data/online/purchase_online_dao.dart';
import 'modules/home/home_module.dart';
import 'modules/login/login_controller.dart';
import 'modules/purchase/purchase_controller.dart';

class AppModule extends MainModule {
  @override
  // Lista de injecoes de dependencia do projeto
  List<Bind> get binds => [
        Bind((i) => AppController()),
        Bind((i) => UserConfigsController()),
        Bind((i) => AppBookController()),
        Bind((i) => AppUserController()),
        Bind((i) => PurchaseController()),
        Bind((i) => AppBasketController()),
        Bind((i) => LoginController()),
        Bind((i) => UserOnlineDao()),
        Bind((i) => BookOnlineDao()),
        Bind((i) => PurchaseOnlineDao()),
        Bind((i) => BookDao()),
        Bind((i) => BasketDao()),
        Bind((i) => PurchaseDao()),
        Bind((i) => BasketBooksDao()),
        Bind((i) => BasketOnlineDao()),
      ];

  @override
  // Root Widget
  Widget get bootstrap => AppWidget();

  @override
  List<ModularRouter> get routers => [
        ModularRouter(SplashModule.routeName, module: SplashModule()),
        ModularRouter(LoginModule.routeName, module: LoginModule()),
        ModularRouter(HomeModule.routeName, module: HomeModule()),
      ];
}
