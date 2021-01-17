import 'dart:async';
import 'package:boockando_app/app/controllers/app_basket_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:boockando_app/app/controllers/app_book_controller.dart';
import 'package:boockando_app/app/controllers/app_user_controller.dart';
import 'package:boockando_app/app/models/user.dart';
import 'package:boockando_app/app/modules/home/home_module.dart';
import 'package:boockando_app/app/modules/login/login_module.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      runInitTasks(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Container(
        alignment: Alignment.center,
        child: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),
                Icon(Icons.menu_book_sharp, size: 80),
                Text('Boockando'),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future runInitTasks(BuildContext context) async {
    final bookController = Modular.get<AppBookController>();
    final userController = Modular.get<AppUserController>();
    final basketController = Modular.get<AppBasketController>();

    //Books - Initialize Books

    // If user has connection
    await bookController.initializeBooksfromJson();
    // If user hasn't connection
    //await bookController.initializeBooksfromLocal();
    //bookController.hasInternet = false;

    //User - Get logged user from cache
    User user;
    await userController.spGetLoggedUser().then((value) => user = value);

    if (user != null) {
      //Set loggedUser on memory
      userController.setUser(user);

      //Initialize user basket loggedUser on memory
      basketController.initializeUserBasket();

      //Todo get preferences  from Shared
      //Todo get purchases from json or DB

      await Modular.to.pushReplacementNamed(HomeModule.routeName);
    } else {
      await Modular.to.pushReplacementNamed(LoginModule.routeName);
    }
  }
}
