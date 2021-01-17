import 'package:flutter/cupertino.dart';

class Basket {
  Basket({this.id, this.totalValue});
  int id;
  double totalValue;

  factory Basket.fromJson({Map<String, dynamic> map}) {
    return Basket(id: map['id'], totalValue: map['totalValue']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['totalValue'] = totalValue;
    return data;
  }

  setValues({@required Basket inputBasket}) {
    id = inputBasket.id;
    totalValue = inputBasket.totalValue;
  }
}
