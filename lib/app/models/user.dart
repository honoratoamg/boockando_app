import 'package:flutter/cupertino.dart';

class User {
  User({this.id, this.name, this.email});
  int id;
  String name;
  String email;

  factory User.fromJson({Map<String, dynamic> map}) {
    return User(
    id: map['id'],
    name: map['name'].toString(),
    email: map['email'].toString());
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    return data;
  }

  setValues({@required User inputUser}) {
    id = inputUser.id;
    name = inputUser.name;
    email = inputUser.email;
  }
}
