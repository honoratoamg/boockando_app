import 'dart:convert';
import 'package:boockando_app/app/repositories/shared/utils/internet_connection_checker.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart' as http;

import 'package:boockando_app/app/data/local/book_dao.dart';
import 'package:boockando_app/app/data/online/book_online_dao.dart';
import 'package:boockando_app/app/models/book.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppBookController extends ChangeNotifier {
  final bookOnlineDao = Modular.get<BookOnlineDao>();
  final bookDao = Modular.get<BookDao>();

  var layoutDesign = StaggeredTile.count(2, 4);
  String selectedCategory;
  bool hasInternet = true;
  List<Book> books;

  /// Initialize books from Json-server and add cache to local database
  initializeBooksfromJson() async {
    final appController = Modular.get<AppBookController>();
    await bookOnlineDao
        .getBooks()
        .then((value) => appController.setBooks(value));
    await bookDao.dropAndCreateBooks();
    addBooksOnDb();
  }

  /// Initialize books from local
  initializeBooksfromLocal() async {
    final appController = Modular.get<AppBookController>();
    await bookDao.getBooks().then((value) => appController.setBooks(value));
  }

  setBooks(List<Book> books) {
    this.books = books;

    notifyListeners();
  }

  updateBook(Book book) async {
    await bookOnlineDao.putBook(book: book);
    books[getBookIndexById(bookId: book.id)].setValues(inputBook: book);

    notifyListeners();
  }

  getBookIndexById({int bookId}) {
    for (var i = 0; i < books.length; i++) {
      if (books[i].id == bookId) {
        return i;
      }
    }
    return -1;
  }

  Book getBookOnMemoryById(int bookId) {
    for (var i = 0; i < books.length; i++) {
      if (books[i].id == bookId) {
          return books[i];
        }
      }
    return null;
  }

  addBook(Book book) async {
    await bookOnlineDao.postBook(book: book).then((value) => book.id = value);
    books.add(book);

    notifyListeners();
  }

  addBooksOnDb() async {
    for (var i = 0; i < books.length; i++) {
      //Convert ImageUrl to Image64 to add on local DB
      final response = await http.get(
        books[i].bookImage,
      );
      final base64 = base64Encode(response.bodyBytes);
      final book = Book();
      book.setValues(inputBook: books[i]);
      book.bookImage = base64;
      await bookDao.insertBook(book);
    }
  }

  setDesign(var value) {
    layoutDesign = value;
    notifyListeners();
  }

  Future<List<Book>> getBooksByCategory(String category) async {
    List<Book> books;

    bool isConnectedUser;
    await InternetConnectionChecker.checkConnection()
        .then((value) => isConnectedUser = value);

    //Books - Initialize Books by category
    if (isConnectedUser) {
      await bookOnlineDao
          .getBookByCategory(category)
          .then((value) => books = value);
      hasInternet = true;
    } else {
      await bookDao.getBooksByCategory(category).then((value) => books = value);
      hasInternet = false;
    }

    return books;
  }

  Future<Book> getBookById(int bookId) async {
    Book book;
    bool isConnectedUser;
    await InternetConnectionChecker.checkConnection()
        .then((value) => isConnectedUser = value);

    if (isConnectedUser) {
      await bookOnlineDao
          .getBook(bookId: bookId)
          .then((value) => book = value);
    } else {
      await bookDao.getBook(bookId).then((value) => book = value);
    }
    return book;
  }

  checkConnection() async {
    bool isConnectedUser;
    await InternetConnectionChecker.checkConnection()
        .then((value) => isConnectedUser = value);

    if (isConnectedUser) {
      hasInternet = true;
    } else {
      hasInternet = false;
    }
  }
}
