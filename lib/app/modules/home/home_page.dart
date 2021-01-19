import 'package:boockando_app/app/controllers/app_book_controller.dart';
import 'package:boockando_app/app/modules/purchase/purchase_module.dart';
import 'package:boockando_app/app/modules/store/store_module.dart';
import 'package:boockando_app/app/modules/user_configs/user_configs_module.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'home_controller.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final appBookOnlineController = Modular.get<AppBookController>();
  final homeController = Modular.get<HomeController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: homeController.pageViewController,
        children: [
          RouterOutlet(module: StoreModule()),
          RouterOutlet(module: PurchaseModule()),
          RouterOutlet(module: UserConfigsModule()),
        ],
      ),
      bottomNavigationBar: BottomNavigator(),
    );
  }

  Widget BottomNavigator() {
    return AnimatedBuilder(
        animation: homeController.pageViewController,
        builder: (context, snapshot) {
          return BottomNavigationBar(
            currentIndex: homeController.pageViewController?.page?.round() ?? 0,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.yellow[900],
            selectedFontSize: 18,
            onTap: (index) {
              homeController.pageViewController.jumpToPage(index);
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.store),
                label: 'Store',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.web),
                label: 'Purchases',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.miscellaneous_services),
                label: 'Configurations',
              ),
            ],
          );
        });
  }
}
