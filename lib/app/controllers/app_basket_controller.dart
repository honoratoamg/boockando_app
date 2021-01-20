import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:boockando_app/app/data/local/basket_books_dao.dart';
import 'package:boockando_app/app/data/local/basket_dao.dart';
import 'package:boockando_app/app/data/online/basket_online_dao.dart';
import 'package:boockando_app/app/models/basket.dart';
import 'package:boockando_app/app/models/basket_books.dart';
import 'package:boockando_app/app/models/book.dart';
import 'package:boockando_app/app/modules/purchase/purchase_controller.dart';
import 'package:boockando_app/app/repositories/local/shared_prefs/shared_prefs.dart';
import 'package:boockando_app/app/repositories/shared/utils/internet_connection_checker.dart';
import 'app_user_controller.dart';

class AppBasketController extends ChangeNotifier {
  final basketOnlineDao = Modular.get<BasketOnlineDao>();
  final basketDao = Modular.get<BasketDao>();
  final basketBooksDao = Modular.get<BasketBooksDao>();
  final appUserController = Modular.get<AppUserController>();
  final purchaseController = Modular.get<PurchaseController>();

  final totalValue = ValueNotifier<double>(0.0);
  final amountBooks = ValueNotifier<int>(0);
  List<BasketBooks> userBasketBooks;

  /// Initialize user Basket
  initializeUserBasket() async {
    final userId = appUserController.loggedUser.id;
    userBasketBooks = <BasketBooks>[];
    totalValue.value = 0.0;
    amountBooks.value = 0;

    // If the user already had a basket
    await SharedPrefs.contains("Basket:User[${userId}]").then((value) async {
      if (value) {
        await SharedPrefs.read("Basket:User[${userId}]").then((value) {
          if (value != "") {
            final list = (jsonDecode(value) as List)
                .map((data) => BasketBooks.fromJson(map: data))
                .toList();

            //Resetting values
            userBasketBooks.clear();
            totalValue.value = 0.0;
            amountBooks.value = 0;

            //For each value on list, add in the memory list
            for (var i = 0; i < list.length; i++) {
              userBasketBooks.add(list[i]);
              amountBooks.value = amountBooks.value + list[i].bookQtd;
              totalValue.value =
                  totalValue.value + (list[i].bookPrice * list[i].bookQtd);
            }
          }
        });
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

    //Verify if already exists on list
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

  // Finish a purchase
  finishPurchase() async {
    //Creates a Json Basket
    Basket basket;
    basket = Basket();

    //Initialize the basket ID on Json
    await basketOnlineDao.postBasket(basket).then((value) => basket.id = value);

    //Give the basket id to the basket items list
    for (var i = 0; i < userBasketBooks.length; i++) {
      userBasketBooks[i].basketId = basket.id;
    }

    //Give a update on posted Basket
    await basketOnlineDao.putBasket(basket, userBasketBooks);

    //Add basket to Local Database
    await basketDao.insertBasket(basket);

    //Add basketBooks to Local Database
    for (var i = 0; i < userBasketBooks.length; i++) {
      await basketBooksDao.insertBasketBooks(userBasketBooks[i]);
    }

    //Create a purchase and insert in local database and server-json
    purchaseController.createPurchase(
        basket, amountBooks.value.toString(), totalValue.value.toString());

    //Clear memory basket
    await clearBasket();
    notifyListeners();
  }

  //Clear basket values
  clearBasket() async {
    final userId = appUserController.loggedUser.id;
    await SharedPrefs.save("Basket:User[${userId}]", "");
    userBasketBooks.clear();
    totalValue.value = 0.0;
    amountBooks.value = 0;
    notifyListeners();
  }

  BasketBooks getBasketById(int id) {
    for (var i = 0; i < userBasketBooks.length; i++) {
      if (userBasketBooks[i].basketId == id) {
        return userBasketBooks[i];
      }
    }
    return null;
  }

  /// Get a basket's items
  Future<List<BasketBooks>> getBasketItems(int basketId) async {
    List<BasketBooks> basketBooks;

    bool isConnectedUser;
    await InternetConnectionChecker.checkConnection()
        .then((value) => isConnectedUser = value);

    //Books - Initialize Books by category
    if (isConnectedUser) {
      await basketOnlineDao
          .getBasketItemsByBasketId(basketId)
          .then((value) => basketBooks = value);
    } else {
      await basketDao
          .getBasketItemsByBasketId(basketId)
          .then((value) => basketBooks = value);
    }

    return basketBooks;
  }
}
