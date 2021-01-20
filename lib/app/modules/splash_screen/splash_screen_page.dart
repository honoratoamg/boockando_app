import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:boockando_app/app/modules/splash_screen/splash_screen_controller.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final splashController = Modular.get<SplashController>();

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      splashController.runInitTasks(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
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
}
