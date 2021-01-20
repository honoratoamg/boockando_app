import 'package:boockando_app/app/controllers/app_user_controller.dart';
import 'package:boockando_app/app/data/online/user_online_dao.dart';
import 'package:boockando_app/app/models/user.dart';
import 'package:boockando_app/app/modules/home/home_module.dart';
import 'package:boockando_app/app/repositories/shared/utils/alerts.dart';
import 'package:boockando_app/app/repositories/shared/utils/internet_connection_checker.dart';
import 'package:boockando_app/app/repositories/shared/utils/local_notification_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../app_controller.dart';

class LoginController extends ChangeNotifier implements Disposable {
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordSgnController = TextEditingController();
  TextEditingController nameSgnController = TextEditingController();
  TextEditingController emailSgnController = TextEditingController();
  final isActionSuccess = ValueNotifier<bool>(false);

  final userController = Modular.get<AppUserController>();
  final appController = Modular.get<AppController>();
  final userOnlineDao = Modular.get<UserOnlineDao>();

  @override
  void dispose() {
    passwordController.dispose();
    nameController.dispose();
    passwordSgnController.dispose();
    nameSgnController.dispose();
    emailSgnController.dispose();
  }

  //Clear Forms
  clearForms() {
    passwordController.text = '';
    nameController.text = '';
    passwordSgnController.text = '';
    nameSgnController.text = '';
    emailSgnController.text = '';
    notifyListeners();
  }

  /// Login user
  loginUser(BuildContext context, String userName, String password) async {
    bool isConnectedUser;
    await InternetConnectionChecker.checkConnection()
        .then((value) => isConnectedUser = value);

    if (isConnectedUser) {
      User user;
      await userOnlineDao
          .getUserIdByName(userName, password)
          .then((value) => user = value);

      //If user is not found, display a Alert
      if (user == null) {
        AlertsUtils.showAlert(context, "Alert!", "User or Password not found!");
        return;
      }

      //Save loggedUser on Shared
      userController.spSaveLoggedUser(user);

      appController.initializeAll(user);

      // Animation
      isActionSuccess.value = true;
      removeFocus(context);
      await Future.delayed(Duration(seconds: 2), () async {
        await Modular.to.pushReplacementNamed(HomeModule.routeName);
      });
    } else {
      AlertsUtils.connectionFailed(context);
    }
  }

  userSignOrUpdate(BuildContext context) async {
    User user;
    bool isConnectedUser;
    bool userNameCheker;

    //Check Connection
    await InternetConnectionChecker.checkConnection()
        .then((value) => isConnectedUser = value);

    if (isConnectedUser) {
      user = User(
        name: nameSgnController.text.trim().toLowerCase(),
        password: passwordSgnController.text,
        email: emailSgnController.text,
      );

      await userController
          .usernameSignVerification(user)
          .then((value) => (userNameCheker = value));

      if (userNameCheker == true) {
        AlertsUtils.showAlert(
            context, "Ops!", "Username already exists. Try another!");
        return;
      }

      if (userController.loggedUser == null) {
        userController.addUser(user);
        await LocalNotificationUtils.showNotification(
          title: "Welcome to Boockando, ${user.name}! ;)",
          body: "Feel free to get to know our books!",
        );
        Modular.to.pop();
        clearForms();
      } else {
        user.id = userController.loggedUser.id;
        userController.updateUserAccount(user);
        Navigator.pop(context);
      }
    } else {
      AlertsUtils.connectionFailed(context);
    }
  }

  /// initialize Sign in fields of LoggedUser for update
  initializeFieldsOfLoggedUser() {
    if (userController.loggedUser != null) {
      nameSgnController.text = userController.loggedUser.name;
      passwordSgnController.text = userController.loggedUser.password;
      emailSgnController.text = userController.loggedUser.email;
    }
  }

  /// Remove focus of a Widget.
  removeFocus(BuildContext context) {
    final currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }
}
