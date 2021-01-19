import 'package:flutter/cupertino.dart';

class Basket {
  Basket({this.id});
  int id;

  factory Basket.fromJson({Map<String, dynamic> map}) {
    return Basket(id: map['id']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    return data;
  }

  setValues({@required Basket inputBasket}) {
    id = inputBasket.id;
  }
}
