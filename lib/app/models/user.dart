import 'package:flutter/cupertino.dart';

class User {
  User({this.userId, this.name, this.email});
  int userId;
  String name;
  String email;

  User.fromMap({Map<String, dynamic> map}) {
    userId = map['userId'];
    name = map['name'];
    email = map['email'];
  }

  Map<String, dynamic> toMap() {
    final data = <String, dynamic>{};
    data['userId'] = userId;
    data['name'] = name;
    data['email'] = email;
    return data;
  }

  setValues({@required User inputUser}) {
    userId = inputUser.userId;
    name = inputUser.name;
    email = inputUser.email;
  }
}
