import 'package:boockando_app/app/controllers/app_user_configs_controller.dart';
import 'package:boockando_app/app/modules/login/Pages/signup_page.dart';
import 'package:boockando_app/app/modules/user_configs/user_configs_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class UserConfigsModule extends ChildModule {
  @override
  List<Bind> get binds => [Bind((i) => UserConfigsController())];

  @override
  List<ModularRouter> get routers => [
        ModularRouter<String>(
          Modular.initialRoute,
          child: (_, args) => UserConfigsPage(),
          transition: TransitionType.leftToRight,
        ),
        ModularRouter(
          SignUpPage.routeName,
          child: (_, args) => SignUpPage(),
          transition: TransitionType.fadeIn,
        )
      ];

  static const routeName = "/userconfigs";
}
