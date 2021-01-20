import 'package:flutter_modular/flutter_modular.dart';

import 'package:boockando_app/app/modules/login/Pages/signup_page.dart';
import 'package:boockando_app/app/modules/splash_screen/splash_screen_controller.dart';
import 'package:boockando_app/app/modules/splash_screen/splash_screen_page.dart';

class SplashModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => SplashController()),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(
          Modular.initialRoute,
          child: (_, args) => SplashPage(),
          transition: TransitionType.leftToRightWithFade,
        ),
        ModularRouter(
          SignUpPage.routeName,
          child: (_, args) => SignUpPage(),
          transition: TransitionType.fadeIn,
        )
      ];

  static const routeName = '/splash';
  static Inject get to => Inject<SplashModule>.of();
}
