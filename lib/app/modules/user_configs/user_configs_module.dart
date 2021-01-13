import 'package:boockando_app/app/controllers/user_configs_controller.dart';
import 'package:boockando_app/app/modules/user_configs/user_configs_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ConfigModule extends ChildModule {
  @override
  List<Bind> get binds => [
    Bind((i) => UserConfigsController())
  ];

  @override
  List<ModularRouter> get routers => [
    ModularRouter<String>(
      Modular.initialRoute,
      child: (_, args) => UserConfigsPage(),
      transition: TransitionType.leftToRight,
    ),
  ];

  static const routeName = "/userconfigs";
}