import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:boockando_app/app/controllers/app_basket_controller.dart';
import 'package:boockando_app/app/modules/store/store_controller.dart';
import 'package:boockando_app/app/modules/store/widget/bookBasket_widget.dart';
import 'package:boockando_app/app/repositories/shared/utils/alerts.dart';
import 'package:boockando_app/app/repositories/shared/utils/internet_connection_checker.dart';

class BasketPage extends StatefulWidget {
  static const routeName = '/basket';

  @override
  _BasketPageState createState() => _BasketPageState();
}

class _BasketPageState extends State<BasketPage> {
  final basketController = Modular.get<AppBasketController>();
  final controller = Modular.get<StoreController>();

  @override
  void initState() {
    super.initState();
    controller.isActionSuccess.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: controller.isActionSuccess,
        builder: (context, value, child) {
          return Scaffold(
            appBar: AppBar(
              title: ValueListenableBuilder(
                valueListenable: basketController.totalValue,
                builder: (context, value, child) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(
                        "Basket's Total: R\$ ${basketController.totalValue.value.toStringAsFixed(2)}"),
                  );
                },
              ),
              centerTitle: true,
            ),
            body: Stack(
                alignment: AlignmentDirectional.center,
                children: <Widget>[
                  Positioned(
                    bottom: MediaQuery.of(context).size.height / 2,
                    child: AnimatedOpacity(
                      curve: Curves.fastOutSlowIn,
                      opacity: controller.isActionSuccess.value ? 1.0 : 0.0,
                      duration: Duration(milliseconds: 1000),
                      child: Container(
                        alignment: Alignment.center,
                        child: feedbackWidget(),
                      ),
                    ),
                  ),
                  AnimatedOpacity(
                    curve: Curves.bounceIn,
                    opacity: controller.isActionSuccess.value ? 0 : 1.0,
                    duration: Duration(milliseconds: 0),
                    child: purchaseWidget(),
                  ),
                ]),
          );
        });
  }

  // Purchase Widget
  purchaseWidget() {
    return Consumer<AppBasketController>(builder: (context, value) {
      return (basketController.userBasketBooks.isNotEmpty)
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                alignment: Alignment.topCenter,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Consumer<AppBasketController>(builder: (context, value) {
                        return basketController.userBasketBooks != null
                            ? Expanded(
                                child: SizedBox(
                                  height: MediaQuery.of(context).size.height,
                                  child: ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount:
                                        basketController.userBasketBooks.length,
                                    itemBuilder:
                                        (BuildContext context, int index) =>
                                            BookBasketWidget(
                                                key: UniqueKey(), index: index),
                                  ),
                                ),
                              )
                            : CircularProgressIndicator();
                      }),
                      RaisedButton(
                          child: Text('Buy now'),
                          onPressed: () async {
                            bool isConnectedUser;
                            await InternetConnectionChecker.checkConnection()
                                .then((value) => isConnectedUser = value);
                            if (isConnectedUser) {
                              controller.showAlertConfirmation(context);
                            } else {
                              AlertsUtils.connectionFailed(context);
                            }
                          }),
                    ]),
              ),
            )
          : Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.work_off_outlined, size: 60),
                Flexible(
                    child: SingleChildScrollView(
                        child: Text('Oops..Your basket is empty!'))),
              ],
            ));
    });
  }

  // Purchase feedback animation
  feedbackWidget() {
    return Column(
      children: <Widget>[
        Icon(
          Icons.done_outline,
          color: Colors.green,
          size: 80,
        ),
        Text("Purchase completed!")
      ],
    );
  }
}
