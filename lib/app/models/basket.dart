import 'package:flutter/cupertino.dart';

class Basket {
  Basket({this.basketId, this.totalValue});
  int basketId;
  double totalValue;

  Basket.fromMap({Map<String, dynamic> map}) {
    basketId = map['basketId'];
    totalValue = map['totalValue'];
  }

  Map<String, dynamic> toMap() {
    final data = <String, dynamic>{};
    data['basketId'] = basketId;
    data['totalValue'] = totalValue;
    return data;
  }

  setValues({@required Basket inputBasket}) {
    basketId = inputBasket.basketId;
    totalValue = inputBasket.totalValue;
  }
}
