import 'package:boockando_app/app/controllers/app_basket_controller.dart';
import 'package:boockando_app/app/controllers/app_user_controller.dart';
import 'package:boockando_app/app/repositories/shared/utils/local_notification_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class StoreController {
  final basketController = Modular.get<AppBasketController>();
  final userController = Modular.get<AppUserController>();
  final isActionSuccess = ValueNotifier<bool>(false);

  showAlertConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirmation"),
          content: Text("Let's complete the purchase?"),
          actions: [
            FlatButton(
                child: Text("Sure!"),
                onPressed: () async {
                  await basketController.finishPurchase();
                  // Animation
                  isActionSuccess.value = true;
                  Modular.to.pop();
                  await Future.delayed(Duration(seconds: 2), () async {
                    await LocalNotificationUtils.showNotification(
                      title:
                          "Wow! We received your purchase, ${userController.loggedUser.name}! :)",
                      body: "You have purchased a Boockando quality book!",
                    );
                    isActionSuccess.value = false;
                  });
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
}
