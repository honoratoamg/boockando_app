import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:boockando_app/app/controllers/app_book_controller.dart';
import 'package:boockando_app/app/controllers/app_user_controller.dart';
import 'package:boockando_app/app/models/user.dart';
import 'package:boockando_app/app/modules/home/home_module.dart';
import 'package:boockando_app/app/modules/login/login_module.dart';
import 'package:boockando_app/app/repositories/shared/utils/internet_connection_checker.dart';
import '../../app_controller.dart';

class SplashController {
  Future runInitTasks(BuildContext context) async {
    final bookController = Modular.get<AppBookController>();
    final userController = Modular.get<AppUserController>();
    final appController = Modular.get<AppController>();

    bool isConnectedUser;
    await InternetConnectionChecker.checkConnection()
        .then((value) => isConnectedUser = value);

    //Books - Initialize Books
    if (isConnectedUser) {
      await bookController.initializeBooksfromJson();
      bookController.hasInternet = true;
    } else {
      await bookController.initializeBooksfromLocal();
      bookController.hasInternet = false;
    }

    //User - Get logged user from cache
    User user;
    await userController.spGetLoggedUser().then((value) => user = value);

    //If already had a logged user
    if (user != null) {
      appController.initializeAll(user);
      await Modular.to.pushReplacementNamed(HomeModule.routeName);
    } else {
      await Modular.to.pushReplacementNamed(LoginModule.routeName);
    }
  }
}
