import 'package:boockando_app/app/modules/login/Pages/signup_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'login_controller.dart';
import 'login_page.dart';

class LoginModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => LoginController()),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(
          Modular.initialRoute,
          child: (_, args) => LoginPage(),
          transition: TransitionType.fadeIn,
        ),
        ModularRouter(
          SignUpPage.routeName,
          child: (_, args) => SignUpPage(),
          transition: TransitionType.fadeIn,
        )
      ];

  static const routeName = '/login';
}
