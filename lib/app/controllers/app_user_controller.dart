import 'dart:convert';
import 'package:boockando_app/app/repositories/shared/themes/app_themes.dart';
import 'package:boockando_app/app/repositories/shared/utils/local_notification_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:boockando_app/app/modules/login/login_controller.dart';
import 'package:boockando_app/app/modules/login/login_module.dart';
import 'package:boockando_app/app/data/online/user_online_dao.dart';
import 'package:boockando_app/app/models/user.dart';
import 'package:boockando_app/app/repositories/local/shared_prefs/shared_prefs.dart';

import '../app_controller.dart';
import 'app_user_configs_controller.dart';

class AppUserController extends ChangeNotifier {
  final userOnlineDao = Modular.get<UserOnlineDao>();
  User loggedUser;

  initializeUser(User user) async {
    await userOnlineDao
        .getUser(userId: user.id)
        .then((value) => setUser(value));
  }

  setUser(User user) {
    loggedUser = user;

    notifyListeners();
  }

  updateUser(User user) async {
    await userOnlineDao.putUser(user: user);
    loggedUser.setValues(inputUser: user);

    notifyListeners();
  }

  addUser(User user) async {
    // Add the user on json-server
    await userOnlineDao.postUser(user: user).then((value) => user.id = value);

    notifyListeners();
  }

  deleteUser(User user) async {
    // Delete the user from json-server
    await userOnlineDao.RemoveUser(idUser: user.id);
    loggedUser = null;

    notifyListeners();
  }

  userLogout(User user) async {
    final appController = Modular.get<AppController>();
    final loginController = Modular.get<LoginController>();
    final userConfigsController = Modular.get<UserConfigsController>();

    await LocalNotificationUtils.showNotification(
      title: "Thanks for the visit ${user.name}!! :)",
      body: "Feel free to visit us more often! :)!",
    );

    spRemoveUser(user.name);
    loggedUser = null;
    userConfigsController.fontSize = userConfigsController.defaultFontSize;
    userConfigsController.userTheme = AppThemesEnum.system;
    appController.clearAllLists();
    loginController.clearForms();
    await Modular.to.pushReplacementNamed(LoginModule.routeName);
    notifyListeners();
  }

  /// Save a loggedUser on SharedPrefs
  spSaveLoggedUser(User user) {
    SharedPrefs.save("loggedUser", jsonEncode(user));
  }

  /// Remove a loggedUser on SharedPrefs
  spRemoveUser(String name) {
    SharedPrefs.remove("loggedUser");
  }

  /// Try to get loggedUser from SharedPrefs
  Future<User> spGetLoggedUser() async {
    User user;
    await SharedPrefs.contains("loggedUser").then((value) async {
      if (value) {
        user = await SharedPrefs.read("loggedUser")
            .then((value) => User.fromJson(map: jsonDecode(value)));
      } else {
        user = null;
      }
    });
    return user;
  }

  updateUserAccount(User user) {
    updateUser(user);
    notifyListeners();
  }

  /// Verification of username. If already exists, return true
  Future<bool> usernameSignVerification(User user) async {
    final userController = Modular.get<AppUserController>();

    // Verification
    User userFounded;
    await userOnlineDao
        .userVerification(user.name)
        .then((value) => userFounded = value);

    //If userFounded is loggedUser
    if (userFounded?.name == userController?.loggedUser?.name) {
      return false;
    }

    if (userFounded != null) {
      return true;
    } else {
      return false;
    }
  }
}
