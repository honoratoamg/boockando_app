import 'dart:convert';

import 'package:boockando_app/app/data/online/consts/consts.dart';
import 'package:boockando_app/app/models/purchase.dart';
import 'package:boockando_app/app/repositories/local/database/db_consts.dart';
import 'package:http/http.dart' as server;

class PurchaseOnlineDao {
  /// GET a purchase from the json-server a purchase with id
  Future<Purchase> getPurchase(purchaseId) async {
    final response = await server.get("$URL_PURCHASE/$purchaseId");

    if (response.statusCode == 200) {
      //200 OK response
      return Purchase.fromJson(map: jsonDecode(response.body));
    } else {
      // 200 Fail response
      throw Exception('Failed to load the purchase');
    }
  }

  /// GET all purchases from json-server
  Future<List<Purchase>> getAllUserPurchases(int userId) async {
    final response =
        await server.get("$URL_PURCHASE?userId=${userId}&isDeleted=0");
    //200 OK response
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);

      // A empty response
      if (jsonResponse.toString() == '[]') {
        return null;
      }

      final purchases = (jsonResponse as List)
          .map((data) => Purchase.fromJson(map: data))
          .toList();
      return purchases;
    } else {
      // 200 Fail response
      throw Exception('Failed to get all purchases');
    }
  }

  /// POST a purchase to the json-server
  Future<int> postPurchase(Purchase purchase) async {
    final headers = <String, String>{
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    final body = jsonEncode(purchase.toJson());
    final response =
        await server.post(URL_PURCHASE, body: body, headers: headers);
    final jsonResponse = jsonDecode(response.body);

    return jsonResponse[TABLE_PURCHASE_ATT_ID];
  }

  /// PUT a purchase from json-server
  Future<Purchase> putPurchase(Purchase purchase) async {
    final response = await server.put(
      '$URL_PURCHASE/${purchase.id}',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(purchase.toJson()),
    );

    if (response.statusCode == 200) {
      //200 Updated response
      return Purchase.fromJson(map: jsonDecode(response.body));
    } else {
      //200 failed on updated response
      throw Exception('Failed to update a purchase');
    }
  }

  /// Delete a purchase from json-server
  Future<server.Response> RemovePurchase(int idPurchase) async {
    final response = await server.delete(
      '$URL_PURCHASE/$idPurchase',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    // 200 Ok response
    if (response.statusCode == 200) {
      return response;
    } else {
      // 200 Fail response
      throw Exception('Failed to delete a purchase');
    }
  }
}
