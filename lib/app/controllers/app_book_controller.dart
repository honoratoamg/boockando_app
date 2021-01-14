import 'package:boockando_app/app/data/online/book_online_dao.dart';
import 'package:boockando_app/app/models/book.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppBookController extends ChangeNotifier {
  final bookOnlineDao = Modular.get<BookOnlineDao>();
  List<Book> books;

  initializeBooks() async {
    final appController = Modular.get<AppBookController>();
    await bookOnlineDao.getBooks().then((value) => appController.setBooks(value));
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

  addBook(Book book) async {
    await bookOnlineDao
        .postBook(book: book)
        .then((value) => book.id = value);
    books.add(book);

    notifyListeners();
  }

  deleteBook(Book book) async {
    await bookOnlineDao.RemoveBook(idBook: book.id);
    books.remove(book);

    notifyListeners();
  }
}
