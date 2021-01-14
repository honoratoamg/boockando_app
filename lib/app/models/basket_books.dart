import 'package:flutter/cupertino.dart';

class BasketBooks {
  BasketBooks(
      {this.userId, this.bookId, this.id, this.bookPrice, this.bookQtd});
  int userId;
  int bookId;
  int id;
  double bookPrice;
  int bookQtd;

  BasketBooks.fromMap({Map<String, dynamic> map}) {
    userId = map['userId'];
    bookId = map['bookId'];
    id = map['id'];
    bookPrice = map['bookPrice'];
    bookQtd = map['bookQtd'];
  }

  Map<String, dynamic> toMap() {
    final data = <String, dynamic>{};
    data['userId'] = userId;
    data['bookId'] = bookId;
    data['id'] = id;
    data['bookPrice'] = bookPrice;
    data['bookQtd'] = bookQtd;
    return data;
  }

  setValues({@required BasketBooks inputBasketBooks}) {
    userId = inputBasketBooks.userId;
    bookId = inputBasketBooks.bookId;
    id = inputBasketBooks.id;
    bookPrice = inputBasketBooks.bookPrice;
    bookQtd = inputBasketBooks.bookQtd;
  }
}
