import 'package:flutter/cupertino.dart';

class Book {
  Book(
      {this.id,
      this.title,
      this.price,
      this.author,
      this.about,
      this.isbn,
      this.category,
      this.bookImage});

  int id;
  String title;
  double price;
  String about;
  String author;
  String isbn;
  String category;
  String bookImage;

  factory Book.fromJson({Map<String, dynamic> map}) {
    return Book(
        id: map['id'],
        title: map['title'].toString(),
        price: map['price'],
        author: map['author'].toString(),
        about: map['about'].toString(),
        isbn: map['isbn'].toString(),
        category: map['category'].toString(),
        bookImage: map['bookImage'].toString());
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['price'] = price;
    data['author'] = author;
    data['about'] = about;
    data['isbn'] = isbn;
    data['category'] = category;
    data['bookImage'] = bookImage;

    return data;
  }

  setValues({@required Book inputBook}) {
    id = inputBook.id;
    title = inputBook.title;
    price = inputBook.price;
    author = inputBook.author;
    about = inputBook.about;
    isbn = inputBook.isbn;
    category = inputBook.category;
    bookImage = inputBook.bookImage;
  }
}
