import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:boockando_app/app/app_module.dart';
import 'package:boockando_app/app/controllers/app_basket_controller.dart';
import 'package:boockando_app/app/controllers/app_user_controller.dart';
import 'package:boockando_app/app/controllers/app_user_controller.dart';
import 'package:boockando_app/app/models/basket_books.dart';
import 'package:boockando_app/app/models/book.dart';
import 'package:boockando_app/app/models/user.dart';

void main() {
  /// Initialize Modular's main Module
  initModule(AppModule());

  ///Tests on Basket Controller
  test("Test 1: Add one item to List", () {
    final basketController = Modular.get<AppBasketController>();
    final userController = Modular.get<AppUserController>();

    //Add a logged User
    User userTest = User(id: 1);
    userController.loggedUser = userTest;

    //Initialize a basket list
    basketController.userBasketBooks = <BasketBooks>[];

    //Create a Book
    var book = Book(price: 1.1);

    //Add the book to the basket
    basketController.basketAddBook(book);
    expect(basketController.userBasketBooks.length, 1);
  });

  test("Test 2: Check Value of basket", () {
    final basketController = Modular.get<AppBasketController>();
    final userController = Modular.get<AppUserController>();

    //Add a logged User
    User userTest = User(id: 1);
    userController.loggedUser = userTest;

    //Initialize a basket list
    basketController.userBasketBooks = <BasketBooks>[];

    //Create some Books
    var book1 = Book(price: 10.5);
    var book2 = Book(price: 20.5);
    var book3 = Book(price: 30.5);

    //Add some books to the basket
    basketController.basketAddBook(book1);
    basketController.basketAddBook(book2);
    basketController.basketAddBook(book3);

    //Check the value of Basket
    expect(basketController.totalValue.value, 61.5);
  });

  test("Test 3: Check remove one book of the basket", () {
    final basketController = Modular.get<AppBasketController>();
    final userController = Modular.get<AppUserController>();

    //Add a logged User
    User userTest = User(id: 1);
    userController.loggedUser = userTest;

    //Initialize a basket list
    basketController.userBasketBooks = <BasketBooks>[];

    //Create some Books
    var book1 = Book(price: 10.5);
    var book2 = Book(price: 20.5);

    //Add some books to the basket
    basketController.basketAddBook(book1);
    basketController.basketAddBook(book2);
    basketController.basketRemoveBook(book1);

    //Check the value of Basket
    expect(basketController.userBasketBooks.length, 1);
  });

  test("Test 4: Check Amount of basket", () {
    final basketController = Modular.get<AppBasketController>();
    final userController = Modular.get<AppUserController>();

    //Add a logged User
    User userTest = User(id: 1);
    userController.loggedUser = userTest;

    //Initialize a basket list
    basketController.userBasketBooks = <BasketBooks>[];

    //Create some Books
    var book1 = Book(price: 10.5);
    var book2 = Book(price: 20.5);
    var book3 = Book(price: 30.5);

    //Add some books to the basket
    basketController.basketAddBook(book1);
    basketController.basketAddBook(book2);
    basketController.basketAddBook(book3);

    //Check the value of Basket
    expect(basketController.amountBooks.value, 3);
  });
}
