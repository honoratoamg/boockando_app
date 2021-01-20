import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:boockando_app/app/controllers/app_basket_controller.dart';
import 'package:boockando_app/app/models/basket_books.dart';
import 'package:boockando_app/app/models/purchase.dart';
import 'package:boockando_app/app/modules/purchase/purchase_controller.dart';
import 'package:boockando_app/app/modules/purchase/widgets/report_basket_widget.dart';

class ReportBasketPageArguments {
  ReportBasketPageArguments({this.key, this.purchase});
  Key key;
  final purchase;
}

class ReportBasketPage extends StatefulWidget {
  const ReportBasketPage({Key key, this.purchase}) : super(key: key);
  static const routeName = "/reportBasket";
  final purchase;

  @override
  _ReportBasketPageState createState() => _ReportBasketPageState();
}

class _ReportBasketPageState extends State<ReportBasketPage> {
  final basketController = Modular.get<AppBasketController>();
  final purchaseController = Modular.get<PurchaseController>();
  Purchase purchaseTemp;

  @override
  void initState() {
    super.initState();
    purchaseTemp = widget.purchase;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Text("My Purchase ${purchaseTemp.id}"
            "${purchaseTemp.day}"
            "${purchaseTemp.month}"),
      )),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          alignment: Alignment.topCenter,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Books's Amount: ${purchaseTemp.amountItems}"),
                Text('Total Value: ${purchaseTemp.totalValue}'),
                FutureBuilder(
                  future:
                      basketController.getBasketItems(purchaseTemp.basketId),
                  builder:
                      (context, AsyncSnapshot<List<BasketBooks>> snapshot) {
                    if (snapshot.hasData) {
                      return Expanded(
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height,
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) =>
                                ReportBaskedWidget(
                                    key: UniqueKey(),
                                    basketBooks: snapshot.data[index]),
                          ),
                        ),
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
              ]),
        ),
      ),
    );
  }
}
