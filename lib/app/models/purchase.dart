import 'package:flutter/cupertino.dart';

class Purchase {
  Purchase(
      {this.id,
      this.basketId,
      this.userId,
      this.day,
      this.month,
      this.isDeleted});

  int id;
  int basketId;
  int userId;
  String day;
  String month;
  int isDeleted;

  factory Purchase.fromJson({Map<String, dynamic> map}) {
    return Purchase(
        id: map['id'],
        basketId: map['basketId'],
        day: map['day'].toString(),
        userId: map['userId'],
        month: map['month'].toString(),
        isDeleted: map['isDeleted']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['basketId'] = basketId;
    data['userId'] = userId;
    data['day'] = day;
    data['month'] = month;
    data['isDeleted'] = isDeleted;
    return data;
  }

  setValues({@required Purchase inputPurchase}) {
    id = inputPurchase.id;
    basketId = inputPurchase.basketId;
    userId = inputPurchase.userId;
    day = inputPurchase.day;
    month = inputPurchase.month;
    isDeleted = inputPurchase.isDeleted;
  }
}
