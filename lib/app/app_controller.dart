import 'package:flutter_modular/flutter_modular.dart';

import 'controllers/app_basket_controller.dart';
import 'controllers/app_book_controller.dart';
import 'controllers/app_user_configs_controller.dart';
import 'controllers/app_user_controller.dart';
import 'models/user.dart';
import 'modules/purchase/purchase_controller.dart';

class AppController {
  final bookController = Modular.get<AppBookController>();
  final userController = Modular.get<AppUserController>();
  final basketController = Modular.get<AppBasketController>();
  final purchaseController = Modular.get<PurchaseController>();
  final userPrefsController = Modular.get<UserConfigsController>();

  initializeAll(User user) async {
    //Set loggedUser on memory
    userController.setUser(user);

    //Initialize themes from Shared
    userPrefsController.initializeConfigs(user.id);

    //Initialize user basket loggedUser on memory
    basketController.initializeUserBasket();
  }

  clearAllLists() {
    basketController.userBasketBooks.clear();
    basketController.amountBooks.value = 0;
    basketController.totalValue.value = 0.0;
  }
}
