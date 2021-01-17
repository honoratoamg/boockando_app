import 'package:boockando_app/app/controllers/app_basket_controller.dart';
import 'package:boockando_app/app/controllers/app_user_controller.dart';
import 'package:boockando_app/app/data/online/user_online_dao.dart';
import 'package:boockando_app/app/models/user.dart';
import 'package:boockando_app/app/modules/home/home_module.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'Pages/signup_page.dart';
import 'login_controller.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final loginController = Modular.get<LoginController>();
  final userController = Modular.get<AppUserController>();
  final userOnlineDao = Modular.get<UserOnlineDao>();
  final basketController = Modular.get<AppBasketController>();

  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  String userName;
  String password;

  @override
  void dispose() {
    super.dispose();
    passwordController.dispose();
    nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Boockando')),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.all(10),
                  child: Center(
                    child: Text(
                      'Login',
                    ),
                  )),
              Container(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  controller: nameController,
                  onChanged: (valor) =>
                      setState(() => userName = valor.trim().toLowerCase()),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'User',
                  ),
                  validator: (String submittedValue) {
                    if (submittedValue.isEmpty) {
                      return "This field can't be empty!";
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 5),
              Container(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  onChanged: (valor) => setState(() => password = valor),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                  validator: (String submittedValue) {
                    if (submittedValue.isEmpty) {
                      return "'This field can't be empty!";
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 5),
              Container(
                height: 50,
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: RaisedButton(
                  textColor: Colors.black,
                  child: Text('Enter'),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      User user;
                      await userOnlineDao
                          .getUserIdByName(userName, password)
                          .then((value) => user = value);

                      //If user is not found, display a Alert
                      if (user == null) {
                        showAlert(
                            context, "Alert!", "User or Password not found!");
                        return;
                      }

                      //Initialize the memory list value
                      await userController.initializeUser(user);

                      //Initialize user basket loggedUser on memory
                      basketController.initializeUserBasket();

                      //Save loggedUser on Shared
                      userController.spSaveLoggedUser(user);

                      basketController.initializeUserBasket();

                      await Modular.to
                          .pushReplacementNamed(HomeModule.routeName);
                    }
                  },
                ),
              ),
              SizedBox(height: 7),
              FlatButton(
                  onPressed: () {
                    Modular.link.pushNamed(SignUpPage.routeName);
                  },
                  child: Text("Not registered? Sign up here!")),
            ],
          ),
        ),
      ),
    );
  }
}

showAlert(BuildContext context, String title, String message) {
  // Button
  final Widget confirm = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Modular.to.pop();
    },
  );

  // Alert
  final alert = AlertDialog(
    title: Center(child: Text(title)),
    content: Text(
      message,
      style: TextStyle(fontWeight: FontWeight.normal),
    ),
    actions: [
      confirm,
    ],
  );

  // Show
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
