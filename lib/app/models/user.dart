import 'package:flutter/cupertino.dart';

class User {
  User({this.id, this.name, this.password, this.email});
  int id;
  String name;
  String password;
  String email;

  factory User.fromJson({Map<String, dynamic> map}) {
    return User(
    id: map['id'],
    name: map['name'].toString(),
    password: map['password'].toString(),
    email: map['email'].toString());
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['password'] = password;
    data['email'] = email;
    return data;
  }

  setValues({@required User inputUser}) {
    id = inputUser.id;
    name = inputUser.name;
    password = inputUser.password;
    email = inputUser.email;
  }
}
