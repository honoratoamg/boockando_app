import 'package:flutter/cupertino.dart';

class BasketBooks {
  BasketBooks(
      {this.userId, this.bookId, this.basketId, this.bookPrice, this.bookQtd});
  int userId;
  int bookId;
  int basketId;
  double bookPrice;
  int bookQtd;

  BasketBooks.fromMap({Map<String, dynamic> map}) {
    userId = map['userId'];
    bookId = map['bookId'];
    basketId = map['basketId'];
    bookPrice = map['bookPrice'];
    bookQtd = map['bookQtd'];
  }

  Map<String, dynamic> toMap() {
    final data = <String, dynamic>{};
    data['userId'] = userId;
    data['bookId'] = bookId;
    data['basketId'] = basketId;
    data['bookPrice'] = bookPrice;
    data['bookQtd'] = bookQtd;
    return data;
  }

  setValues({@required BasketBooks inputBasketBooks}) {
    userId = inputBasketBooks.userId;
    bookId = inputBasketBooks.bookId;
    basketId = inputBasketBooks.basketId;
    bookPrice = inputBasketBooks.bookPrice;
    bookQtd = inputBasketBooks.bookQtd;
  }
}
