import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:boockando_app/app/controllers/app_user_controller.dart';
import 'package:boockando_app/app/data/local/purchase_dao.dart';
import 'package:boockando_app/app/data/online/purchase_online_dao.dart';
import 'package:boockando_app/app/models/basket.dart';
import 'package:boockando_app/app/models/purchase.dart';
import 'package:boockando_app/app/repositories/shared/utils/alerts.dart';
import 'package:boockando_app/app/repositories/shared/utils/internet_connection_checker.dart';

class PurchaseController extends ChangeNotifier {
  final purchaseOnlineDao = Modular.get<PurchaseOnlineDao>();
  final purchaseDao = Modular.get<PurchaseDao>();
  final appUserController = Modular.get<AppUserController>();

  removePurchase(Purchase purchase, BuildContext context) async {
    try {
      // Actualize the isDeleted att
      purchase.isDeleted = 1;

      //Put on Json-server
      await purchaseOnlineDao.putPurchase(purchase);

      //Put on LocalDb
      await purchaseDao.updatePurchase(purchase);

      notifyListeners();
    } catch (ex) {
      debugPrint("${ex}");
      AlertsUtils.unexpectedError(context);
    }
  }

  //Create a purchase based on basket
  createPurchase(Basket basket, String amount, String totalValue) async {
    final userId = appUserController.loggedUser.id;
    String day;
    String month;

    //Get day and month
    day = DateTime.now().day.toString();
    month = DateTime.now().month.toString();

    //Create a purchase
    Purchase purchase;
    purchase = Purchase(
      basketId: basket.id,
      userId: userId,
      amountItems: amount,
      totalValue: totalValue,
      day: day,
      month: month,
      isDeleted: 0,
    );

    //Create a purchase on json-server then put the id
    await purchaseOnlineDao
        .postPurchase(purchase)
        .then((value) => purchase.id = value);

    //Insert purchase on local DB
    await purchaseDao.insertPurchase(purchase);

    //Insert purchase on memory
    //userPurchases.add(purchase);

    notifyListeners();
  }

  showDeletePurchaseConfirmation(BuildContext context, Purchase purchase) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirmation"),
          content: Text("You wanna remove it?"),
          actions: [
            FlatButton(
                child: Text("Sure!"),
                onPressed: () async {
                  removePurchase(purchase, context);
                  Modular.to.pop();
                }),
            FlatButton(
              child: Text("Not now"),
              onPressed: () async => Modular.to.pop(),
            ),
          ],
        );
      },
    );
  }

  Future<List<Purchase>> getPurchases(int userId) async {
    List<Purchase> purchase;

    bool isConnectedUser;
    await InternetConnectionChecker.checkConnection()
        .then((value) => isConnectedUser = value);

    //Books - Initialize Books by category
    if (isConnectedUser) {
      await purchaseOnlineDao
          .getAllUserPurchases(userId)
          .then((value) => purchase = value);
    } else {
      await purchaseDao
          .getAllUserPurchases(userId)
          .then((value) => purchase = value);
    }

    return purchase;
  }
}
