import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:boockando_app/app/modules/splash_screen/splash_screen_module.dart';
import 'package:boockando_app/app/repositories/shared/themes/app_themes.dart';
import 'controllers/app_user_configs_controller.dart';

class AppWidget extends StatefulWidget {
  @override
  _AppWidgetState createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserConfigsController>(
      builder: (context, value) {
        return MaterialApp(
          title: "Boockando",
          initialRoute: SplashModule.routeName,
          theme: ThemeCollection.getAppTheme(),
          darkTheme: ThemeCollection.darkTheme(),
          navigatorKey: Modular.navigatorKey,
          onGenerateRoute: Modular.generateRoute,
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
