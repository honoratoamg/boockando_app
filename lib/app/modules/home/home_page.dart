import 'package:boockando_app/app/controllers/app_book_controller.dart';
import 'package:boockando_app/app/modules/store/store_page.dart';
import 'package:boockando_app/app/modules/user_configs/user_configs_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'home_controller.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  final appBookOnlineController = Modular.get<AppBookController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller.pageViewController,
        children: [
          StorePage(),
          Center(child: Text('Minhas compras')),
          UserConfigsPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigator(),
    );
  }

  Widget BottomNavigator() {
    return AnimatedBuilder(
        animation: controller.pageViewController,
        builder: (context, snapshot) {
          return BottomNavigationBar(
            currentIndex: controller.pageViewController?.page?.round() ?? 0,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.pink[800],
            selectedFontSize: 18,
            onTap: (index) {
              controller.pageViewController.jumpToPage(index);
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.store),
                label: 'Loja',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.web),
                label: 'Minhas Compras',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.miscellaneous_services),
                label: 'Configurações',
              ),
            ],
          );
        });
  }
}
