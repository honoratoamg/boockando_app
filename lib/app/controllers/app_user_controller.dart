import 'package:boockando_app/app/data/online/user_online_dao.dart';
import 'package:boockando_app/app/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';


class AppUserController extends ChangeNotifier {
  final userOnlineDao = Modular.get<UserOnlineDao>();
  List<User> users;

  initializeUsers() async {
    final appController = Modular.get<AppUserController>();
    await userOnlineDao
        .getUsers()
        .then((value) => appController.setUsers(value));
  }

  setUsers(List<User> users) {
    this.users = users;

    notifyListeners();
  }

  updateUser(User user) async {
    await userOnlineDao.putUser(user: user);
    users[getUserIndexById(userId: user.id)].setValues(inputUser: user);

    notifyListeners();
  }

  getUserIndexById({int userId}) {
    for (var i = 0; i < users.length; i++) {
      if (users[i].id == userId) {
        return i;
      }
    }
    return -1;
  }

  addUser(User user) async {
    // Add the user on json-server
    await userOnlineDao.postUser(user: user).then((value) => user.id = value);

    // Add the user on memory
    users.add(user);

    //TODO Adicionar no database local
    notifyListeners();
  }

  deleteUser(User user) async {
    await userOnlineDao.RemoveUser(idUser: user.id);
    users.remove(user);

    notifyListeners();
  }
}
