import 'package:flutter_modular/flutter_modular.dart';

import 'package:boockando_app/app/modules/home/home_module.dart';
import 'package:boockando_app/app/modules/home/home_page.dart';
import 'package:boockando_app/app/modules/store/page/basket_page.dart';
import 'package:boockando_app/app/modules/store/page/book_page.dart';
import 'package:boockando_app/app/modules/store/store_controller.dart';
import 'package:boockando_app/app/modules/store/store_page.dart';

class StoreModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => StoreController()),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(
          Modular.initialRoute,
          child: (_, args) => StorePage(),
          transition: TransitionType.fadeIn,
        ),
        ModularRouter(
          BookPage.routeName,
          child: (_, args) => BookPage(
            index: args.data.index,
          ),
          transition: TransitionType.fadeIn,
        ),
        ModularRouter(
          BasketPage.routeName,
          child: (_, args) => BasketPage(),
          transition: TransitionType.fadeIn,
        ),
        ModularRouter(
          HomeModule.routeName,
          child: (_, args) => HomePage(),
          transition: TransitionType.fadeIn,
        )
      ];

  static const routeName = '/store';
}
