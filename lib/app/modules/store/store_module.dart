import 'package:boockando_app/app/modules/store/page/book_page.dart';
import 'package:boockando_app/app/modules/store/store_controller.dart';
import 'package:boockando_app/app/modules/store/store_page.dart';
import 'package:flutter_modular/flutter_modular.dart';


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
  ];

  static const routeName = '/store';
}
