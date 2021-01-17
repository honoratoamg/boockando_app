import 'dart:convert';
import 'package:boockando_app/app/modules/login/login_module.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:boockando_app/app/data/online/user_online_dao.dart';
import 'package:boockando_app/app/models/user.dart';
import 'package:boockando_app/app/repositories/local/shared_prefs/shared_prefs.dart';

class AppUserController extends ChangeNotifier {
  final userOnlineDao = Modular.get<UserOnlineDao>();
  User loggedUser;

  initializeUser(User user) async {
    final appController = Modular.get<AppUserController>();
    await userOnlineDao
        .getUser(userId: user.id)
        .then((value) => appController.setUser(value));
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

    // Add the user on memory
    loggedUser = user;

    notifyListeners();
  }

  deleteUser(User user) async {
    // Delete the user from json-server
    await userOnlineDao.RemoveUser(idUser: user.id);
    loggedUser = null;

    notifyListeners();
  }

  userLogout(User user) {
    spRemoveUser(user.name);
    loggedUser = null;
    Modular.to.pushReplacementNamed(LoginModule.routeName);
  }

  //SharedPrefs

  spSaveLoggedUser(User user) {
    SharedPrefs.save("loggedUser", jsonEncode(user));
  }

  spRemoveUser(String name) {
    SharedPrefs.remove("loggedUser");
  }

  Future<User> spGetLoggedUser() async {
    User user;
    await SharedPrefs.contains("loggedUser").then((value) async {
      if (value) {
        await SharedPrefs.read("loggedUser").then((value) {
          //Initialize a user
          user = User(id: 0, email: "", password: "", name: "");

          //Set values
          user.setValues(inputUser: User.fromJson(map: jsonDecode(value)));
          return user;
        });
      } else {
        return null;
      }
    });
    return user;
  }
}
