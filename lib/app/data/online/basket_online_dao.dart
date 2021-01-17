import 'dart:convert';

import 'package:boockando_app/app/data/online/consts/consts.dart';
import 'package:boockando_app/app/models/basket.dart';
import 'package:boockando_app/app/models/user.dart';
import 'package:http/http.dart' as server;

class BasketOnlineDao {

  /// GET a basket from the json-server
  Future<Basket> getBasketById(basketId) async {
    final response = await server.get("$URL_USER/$basketId");

    if (response.statusCode == 200) {
      //200 OK response
      return Basket.fromJson(map: jsonDecode(response.body));
    } else {
      // 200 Fail response
      throw Exception('Failed to load the basket');
    }
  }

  /// PUT a basket from json-server
  Future<Basket> putBasket({Basket basket}) async {
    final response = await server.put(
      '$URL_USER/${basket.basketId}',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(basket.toJson()),
    );

    if (response.statusCode == 200) {
      //200 Updated response
      return Basket.fromJson(map: jsonDecode(response.body));
    } else {
      //200 failed on updated response
      throw Exception('Failed to update a basket');
    }
  }

  /// Delete a basket from json-server
  Future<server.Response> RemoveBasket({int idBasket}) async {
    final response = await server.delete(
      '$URL_USER/$idBasket',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    // 200 Ok response
    if (response.statusCode == 200) {
      return response;
    } else {
      // 200 Fail response
      throw Exception('Failed to delete a basket');
    }
  }

  /// POST a user basket to the json-server
  Future<int> postBasketUser(User user, Basket basket) async {
    final headers = <String, String>{
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    final jsonBasket = <String, dynamic>{};
    jsonBasket['finalValue'] = basket.totalValue;
    jsonBasket['userId'] = user.id;
    jsonBasket['basketBooks'] = [];

    final body = jsonEncode(jsonBasket);
    final response =
    await server.post(URL_BASKET, body: body, headers: headers);
    final jsonResponse = jsonDecode(response.body);

    return jsonResponse['idBasket'];
  }
}
