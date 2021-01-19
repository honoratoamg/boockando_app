import 'package:boockando_app/app/models/purchase.dart';
import 'package:boockando_app/app/modules/purchase/page/report_basket_page.dart';
import 'package:boockando_app/app/repositories/shared/utils/alerts.dart';
import 'package:boockando_app/app/repositories/shared/utils/internet_connection_checker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../purchase_controller.dart';

class PurchaseWidget extends StatefulWidget {
  const PurchaseWidget({Key key, this.purchase}) : super(key: key);
  final purchase;

  @override
  _PurchaseWidgetState createState() => _PurchaseWidgetState();
}

class _PurchaseWidgetState extends State<PurchaseWidget> {
  final controller = Modular.get<PurchaseController>();
  Purchase purchaseTemp;

  @override
  void initState() {
    super.initState();
    purchaseTemp = widget.purchase;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Theme.of(context).cardColor.withAlpha(150),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              children: [
                Icon(Icons.shopping_basket_outlined, size: 40),
                SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.bar_chart, size: 20),
                          Flexible(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Text("Purchase Code: ${purchaseTemp.id}"
                                  "${purchaseTemp.day}"
                                  "${purchaseTemp.month}"),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.calendar_today, size: 20),
                          Text("Date: ${purchaseTemp.day}/"
                              "${purchaseTemp.month}"),
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                        icon: Icon(Icons.remove_red_eye_rounded),
                        onPressed: () => setState(() {
                              Navigator.pushNamed(
                                context,
                                ReportBasketPage.routeName,
                                arguments: ReportBasketPageArguments(
                                  purchase: purchaseTemp,
                                  key: UniqueKey(),
                                ),
                              );
                            })),
                    IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () async {
                          bool isConnectedUser;
                          await InternetConnectionChecker.checkConnection()
                              .then((value) => isConnectedUser = value);
                          if (isConnectedUser) {
                            controller.showDeletePurchaseConfirmation(
                                context, purchaseTemp);
                          } else {
                            AlertsUtils.connectionFailed(context);
                          }
                        }),
                  ],
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
