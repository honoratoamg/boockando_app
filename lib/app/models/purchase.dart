import 'package:flutter/cupertino.dart';

class Purchase {
  Purchase({this.basketId, this.userId, this.day, this.month, this.isDeleted});

  int basketId;
  int userId;
  String day;
  String month;
  int isDeleted;

  Purchase.fromMap({Map<String, dynamic> map}) {
    basketId = map['basketId'];
    day = map['day'];
    userId = map['userId'];
    month = map['month'];
    isDeleted = map['isDeleted'];
  }

  Map<String, dynamic> toMap() {
    final data = <String, dynamic>{};
    data['basketId'] = basketId;
    data['userId'] = userId;
    data['day'] = day;
    data['month'] = month;
    data['isDeleted'] = isDeleted;

    return data;
  }

  setValues({@required Purchase inputPurchase}) {
    basketId = inputPurchase.basketId;
    userId = inputPurchase.userId;
    day = inputPurchase.day;
    month = inputPurchase.month;
    isDeleted = inputPurchase.isDeleted;
  }
}
