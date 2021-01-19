import 'dart:convert';

import 'package:boockando_app/app/data/online/consts/consts.dart';
import 'package:boockando_app/app/models/user.dart';
import 'package:boockando_app/app/repositories/local/database/db_consts.dart';
import 'package:http/http.dart' as server;

class UserOnlineDao {
  /// GET a user from the json-server a user with id
  Future<User> getUser({userId}) async {
    final response = await server.get("$URL_USER/$userId");

    if (response.statusCode == 200) {
      //200 OK response
      return User.fromJson(map: jsonDecode(response.body));
    } else {
      // 200 Fail response
      throw Exception('Failed to load the user');
    }
  }

  /// GET all users from json-server
  Future<List<User>> getUsers() async {
    final response = await server.get(URL_USER);

    //200 OK response
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final users = (jsonResponse as List)
          .map((data) => User.fromJson(map: data))
          .toList();
      return users;
    } else {
      // 200 Fail response
      throw Exception('Failed to get all users');
    }
  }

  /// GET a user from the json-server a user with id
  Future<User> getUserIdByName(userName, userPassword) async {
    final response =
        await server.get("$URL_USER?name=${userName}&password=${userPassword}");

    if (response.statusCode == 200) {
      //200 OK response

      final jsonResponse = jsonDecode(response.body);

      // A empty response
      if (jsonResponse.toString() == '[]') {
        return null;
      }

      return User.fromJson(map: jsonResponse[0]);
    } else {
      // 200 Fail response
      throw Exception('Failed to load the user');
    }
  }

  /// Verification of a user name
  Future<User> userVerification(String userName) async {
    final response =
    await server.get("$URL_USER?name=${userName}");

    if (response.statusCode == 200) {
      //200 OK response

      final jsonResponse = jsonDecode(response.body);

      // A empty response
      if (jsonResponse.toString() == '[]') {
        return null;
      }

      return User.fromJson(map: jsonResponse[0]);
    } else {
      // 200 Fail response
      throw Exception('Failed to load the user');
    }
  }

  /// POST a user to the json-server
  Future<int> postUser({User user}) async {
    final headers = <String, String>{
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    final body = jsonEncode(user.toJson());
    final response = await server.post(URL_USER, body: body, headers: headers);
    final jsonResponse = jsonDecode(response.body);

    return jsonResponse[TABLE_USER_ATT_ID];
  }

  /// PUT a user from json-server
  Future<User> putUser({User user}) async {
    final response = await server.put(
      '$URL_USER/${user.id}',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 200) {
      //200 Updated response
      return User.fromJson(map: jsonDecode(response.body));
    } else {
      //200 failed on updated response
      throw Exception('Failed to update a user');
    }
  }

  /// Delete a user from json-server
  Future<server.Response> RemoveUser({int idUser}) async {
    final response = await server.delete(
      '$URL_USER/$idUser',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    // 200 Ok response
    if (response.statusCode == 200) {
      return response;
    } else {
      // 200 Fail response
      throw Exception('Failed to delete a user');
    }
  }
}
