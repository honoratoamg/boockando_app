import 'package:boockando_app/app/controllers/app_user_controller.dart';
import 'package:boockando_app/app/models/purchase.dart';
import 'package:boockando_app/app/modules/purchase/purchase_controller.dart';
import 'package:boockando_app/app/modules/purchase/widgets/purchase_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_modular/flutter_modular.dart';

class PurchasePage extends StatefulWidget {
  @override
  _PurchasePageState createState() => _PurchasePageState();
}

class _PurchasePageState extends State<PurchasePage> {
  final controller = Modular.get<PurchaseController>();
  final userController = Modular.get<AppUserController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Purchases:")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          alignment: Alignment.topCenter,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child:
                      Consumer<PurchaseController>(builder: (context, value) {
                    return FutureBuilder(
                        future: controller
                            .getPurchases(userController.loggedUser.id),
                        builder:
                            (context, AsyncSnapshot<List<Purchase>> snapshot) {
                          if (snapshot.hasData) {
                            return SizedBox(
                              height: MediaQuery.of(context).size.height,
                              child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: snapshot.data.length,
                                itemBuilder:
                                    (BuildContext context, int index) =>
                                        PurchaseWidget(
                                            key: UniqueKey(),
                                            purchase: snapshot.data[index]),
                              ),
                            );
                          } else {
                            return SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Text(
                                    "Ops! You doesn't have any purchase yet"));
                          }
                        });
                  }),
                ),
              ]),
        ),
      ),
    );
  }
}
