import 'package:flutter/cupertino.dart';

class Purchase {
  Purchase(
      {this.id,
      this.basketId,
      this.userId,
      this.day,
      this.month,
      this.amountItems,
      this.totalValue,
      this.isDeleted});

  int id;
  int basketId;
  int userId;
  String day;
  String month;
  String amountItems;
  String totalValue;
  int isDeleted;

  factory Purchase.fromJson({Map<String, dynamic> map}) {
    return Purchase(
        id: map['id'],
        userId: map['userId'],
        basketId: map['basketId'],
        day: map['day'].toString(),
        month: map['month'].toString(),
        amountItems: map['amountItems'].toString(),
        totalValue: map['totalValue'].toString(),
        isDeleted: map['isDeleted']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['basketId'] = basketId;
    data['userId'] = userId;
    data['day'] = day;
    data['month'] = month;
    data['amountItems'] = amountItems;
    data['totalValue'] = totalValue;
    data['isDeleted'] = isDeleted;
    return data;
  }

  setValues({@required Purchase inputPurchase}) {
    id = inputPurchase.id;
    basketId = inputPurchase.basketId;
    userId = inputPurchase.userId;
    day = inputPurchase.day;
    month = inputPurchase.month;
    amountItems = inputPurchase.amountItems;
    totalValue = inputPurchase.totalValue;
    isDeleted = inputPurchase.isDeleted;
  }
}
