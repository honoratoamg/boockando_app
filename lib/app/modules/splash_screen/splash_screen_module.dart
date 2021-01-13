import 'package:boockando_app/app/modules/splash_screen/splash_screen_controller.dart';
import 'package:boockando_app/app/modules/splash_screen/splash_screen_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

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
      ];

  static const routeName = '/splash';
  static Inject get to => Inject<SplashModule>.of();
}
