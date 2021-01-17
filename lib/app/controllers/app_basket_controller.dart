import 'dart:convert';

import 'package:boockando_app/app/data/online/basket_online_dao.dart';
import 'package:boockando_app/app/models/basket_books.dart';
import 'package:boockando_app/app/models/book.dart';
import 'package:boockando_app/app/repositories/local/shared_prefs/shared_prefs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app_user_controller.dart';

class AppBasketController extends ChangeNotifier {
  final basketOnlineDao = Modular.get<BasketOnlineDao>();
  final appUserController = Modular.get<AppUserController>();
  final totalValue = ValueNotifier<double>(0.0);
  final amountBooks = ValueNotifier<int>(0);

  List<BasketBooks> userBasketBooks;

  /// Initialize user Basket from Shared Prefs
  initializeUserBasketFromShared() {
    //final userId = appUserController.loggedUser.id;
    userBasketBooks = <BasketBooks>[];
    totalValue.value = 0.0;
    amountBooks.value = 0;

    /// TODO: att userBasket and userBasketBooks based on Shared
  }

  /// Create user Basket on Shared Prefs
  createUserBasketOnShared() async {
    final userId = appUserController.loggedUser.id;

    await SharedPrefs.contains("Basket-User[${userId}]").then((value) async {
      if (value) {
        return;
      } else {
        await SharedPrefs.save("Basket-User[${userId}]", "");
      }
    });
  }

  // Add a book to basket
  basketAddBook(Book book) async {
    final userId = appUserController.loggedUser.id;

    final basketBook = BasketBooks(
        userId: userId, bookId: book.id, bookPrice: book.price, bookQtd: 1);

    //Verify if already exists on list
    for (var i = 0; i < userBasketBooks.length; i++) {
      if (userBasketBooks[i].bookId == book.id) {
        userBasketBooks[i].bookQtd++;
        totalValue.value = totalValue.value + book.price;
        basketBook.setValues(inputBasketBooks: userBasketBooks[i]);
        amountBooks.value++;
        await SharedPrefs.save(
            "Basket:User[${userId}]", jsonEncode(userBasketBooks));
        notifyListeners();
        return;
      }
    }

    //Add on memory
    userBasketBooks.add(basketBook);
    totalValue.value = totalValue.value + book.price;
    amountBooks.value++;

    await SharedPrefs.save(
        "Basket:User[${userId}]", jsonEncode(userBasketBooks));

    notifyListeners();
  }

  // Remove a book to basket
  basketRemoveBook(Book book) async {
    final userId = appUserController.loggedUser.id;

    //Remove from memory and Shared
    for (var i = 0; i < userBasketBooks.length; i++) {
      if (userBasketBooks[i].bookId == book.id) {
        if (userBasketBooks[i].bookQtd > 1) {
          userBasketBooks[i].bookQtd--;
          totalValue.value = totalValue.value - book.price;
          amountBooks.value--;
          await SharedPrefs.save(
              "Basket:User[${userId}]", jsonEncode(userBasketBooks));
        } else {
          userBasketBooks.removeAt(i);
          totalValue.value = totalValue.value - book.price;
          amountBooks.value--;
          await SharedPrefs.save(
              "Basket:User[${userId}]", jsonEncode(userBasketBooks));
        }
      }
    }
    notifyListeners();
  }

  //Initialize a new user Basket
  // createUserBasketOnJson() async {
  //   final user = appUserController.loggedUser;
  //   Basket basket;
  //
  //   basket = Basket(
  //     totalValue: 0.0,
  //   );
  //
  //   //Initialize the basket user on Json
  //   await basketOnlineDao
  //       .postBasketUser(user, basket)
  //       .then((value) => basket.basketId = value);
  //
  //   //Att the basket user on memory
  //   userBasket = basket;
  //
  //   //TODO: ADD ON LOCAL DATABASE
  //   notifyListeners();
  // }
}
