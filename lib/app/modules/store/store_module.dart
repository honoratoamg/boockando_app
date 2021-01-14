import 'package:boockando_app/app/modules/home/home_page.dart';
import 'package:boockando_app/app/modules/store/store_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';


class HomeModule extends ChildModule {
  @override
  List<Bind> get binds => [
    Bind((i) => StoreController()),
  ];

  @override
  List<ModularRouter> get routers => [
    ModularRouter(
      Modular.initialRoute,
      child: (_, args) => HomePage(),
      transition: TransitionType.fadeIn,
    ),
  ];

  static const routeName = '/store';
}
