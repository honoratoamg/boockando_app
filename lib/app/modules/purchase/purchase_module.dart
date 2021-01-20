import 'package:flutter_modular/flutter_modular.dart';

import 'package:boockando_app/app/modules/purchase/page/report_basket_page.dart';
import 'package:boockando_app/app/modules/purchase/purchase_controller.dart';
import 'package:boockando_app/app/modules/purchase/purchase_page.dart';

class PurchaseModule extends ChildModule {
  @override
  List<Bind> get binds => [Bind((i) => PurchaseController())];

  @override
  List<ModularRouter> get routers => [
        ModularRouter<String>(
          Modular.initialRoute,
          child: (_, args) => PurchasePage(),
          transition: TransitionType.leftToRight,
        ),
        ModularRouter(
          ReportBasketPage.routeName,
          child: (_, args) => ReportBasketPage(
            key: args.data.key,
            purchase: args.data.purchase,
          ),
          transition: TransitionType.fadeIn,
        ),
      ];

  static const routeName = "/purchase";
}
