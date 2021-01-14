import 'package:flutter/cupertino.dart';

class Basket {
  Basket({this.basketId, this.totalValue});
  int basketId;
  double totalValue;

  factory Basket.fromJson({Map<String, dynamic> map}) {
    return Basket(basketId: map['basketId'], totalValue: map['totalValue']);
  }

  Map<String, dynamic> toJson() {
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
