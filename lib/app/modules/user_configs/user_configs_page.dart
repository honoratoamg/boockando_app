import 'package:boockando_app/app/controllers/app_user_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'components/change_theme_widget.dart';
import 'components/text_size_widget.dart';

class UserConfigsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configurações'),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: ListView(
          children: [
            ChangeThemeWidget(),
            TextSizeWidget(),
            UserLogout(context),
          ],
        ),
      ),
    );
  }
}

Widget UserLogout(BuildContext context) {
  final userController = Modular.get<AppUserController>();

  return Card(
    child: Padding(
      padding: const EdgeInsets.all(5.0),
      child: InkWell(
        onTap: () {
          userController.userLogout(userController.loggedUser);
        },
        child: Container(
          child: Row(
            children: [
              Spacer(),
              Text("Logout", style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(width: 5),
              Icon(Icons.logout),
            ],
          ),
        ),
      ),
    ),
  );
}
