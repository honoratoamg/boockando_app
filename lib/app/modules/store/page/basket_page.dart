import 'package:boockando_app/app/controllers/app_basket_controller.dart';
import 'package:boockando_app/app/modules/store/widget/bookBasket_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class BasketPage extends StatefulWidget {
  static const routeName = '/basket';

  @override
  _BasketPageState createState() => _BasketPageState();
}

class _BasketPageState extends State<BasketPage> {
  final basketController = Modular.get<AppBasketController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: ValueListenableBuilder(
        valueListenable: basketController.totalValue,
        builder: (context, value, child) {
          return Text(
              "My Basket's Total: R\$ ${basketController.totalValue.value}");
        },
      )),
      body: Padding(
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
                              itemBuilder: (BuildContext context, int index) =>
                                  BookBasketWidget(key: UniqueKey(),index: index),
                            ),
                          ),
                        )
                      : CircularProgressIndicator();
                }),
                RaisedButton(child: Text('Buy now'),
                    onPressed: (){}),
              ]),
        ),
      ),
    );
  }
}
