import 'package:boockando_app/app/data/online/basket_online_dao.dart';
import 'package:boockando_app/app/models/basket.dart';
import 'package:boockando_app/app/models/book.dart';
import 'package:boockando_app/app/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppBasketController extends ChangeNotifier {
  final basketOnlineDao = Modular.get<BasketOnlineDao>();
  Basket userBasket;
  List<Book> userBasketBooks;

  initializeUserBasket(User user) async {
    final basketController = Modular.get<AppBasketController>();
    await basketOnlineDao
        .getUserBasket(user.id)
        .then((value) => basketController.setUserBasket(value));
  }

  setUserBasket(Basket basket) {
    userBasket = basket;

    notifyListeners();
  }

  //Initialize a new user Basket
  createUserBasket(User user) async {
    Basket basket;

    basket = Basket(
      totalValue: 0.0,
    );

    //Initialize the basket user on Json
    await basketOnlineDao
        .postBasketUser(user, basket)
        .then((value) => basket.basketId = value);

    //Att the basket user on memory
    userBasket = basket;

    //TODO: ADD ON LOCAL DATABASE
    notifyListeners();
  }

  // Add a book to basket
  basketUserAddBook(Book book, Basket userBasket) {
    //Add on memory
    userBasketBooks.add(book);
    userBasket.totalValue = userBasket.totalValue + book.price;

    //TODO: Adicionar no Shared Prefs
  }

  // Add a book to basket
  basketUserRemoveBook(Book book, Basket userBasket) {
    //Add on memory
    userBasketBooks.add(book);
    userBasket.totalValue = userBasket.totalValue - book.price;

    //TODO: Remover no Shared Prefs
  }
}
