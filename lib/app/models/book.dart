import 'package:flutter/cupertino.dart';

class Book {
  Book(
      {this.bookId,
      this.title,
      this.price,
      this.author,
      this.isbn,
      this.category,
      this.bookImage});

  int bookId;
  String title;
  double price;
  String author;
  String isbn;
  String category;
  String bookImage;

  Book.fromMap({Map<String, dynamic> map}) {
    bookId = map['bookId'];
    title = map['title'];
    price = map['price'];
    author = map['author'];
    isbn = map['isbn'];
    category = map['category'];
    bookImage = map['bookImage'];
  }

  Map<String, dynamic> toMap() {
    final data = <String, dynamic>{};
    data['bookId'] = bookId;
    data['title'] = title;
    data['price'] = price;
    data['author'] = author;
    data['isbn'] = isbn;
    data['category'] = category;
    data['bookImage'] = bookImage;

    return data;
  }

  setValues({@required Book inputBook}) {
    bookId = inputBook.bookId;
    title = inputBook.title;
    price = inputBook.price;
    author = inputBook.author;
    isbn = inputBook.isbn;
    category = inputBook.category;
    bookImage = inputBook.bookImage;
  }
}
