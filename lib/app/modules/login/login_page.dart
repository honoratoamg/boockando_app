import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:boockando_app/app/modules/login/login_controller.dart';
import 'Pages/signup_page.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<LoginPage> {
  final controller = Modular.get<LoginController>();
  final _formKey = GlobalKey<FormState>();
  String userName;
  String password;

  @override
  void initState() {
    super.initState();

    //Initialize without container of animation
    controller.isActionSuccess.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: controller.isActionSuccess,
        builder: (context, value, child) {
          return Scaffold(
            appBar: AppBar(
              title: Center(child: Text('Boockando')),
            ),
            body: Stack(
                alignment: AlignmentDirectional.center,
                children: <Widget>[
                  Positioned(
                    bottom: MediaQuery.of(context).size.height / 2,
                    child: AnimatedOpacity(
                      curve: Curves.linear,
                      opacity: !controller.isActionSuccess.value ? 0.0 : 1.0,
                      duration: Duration(milliseconds: 1000),
                      child: animatedFeedbackWidget(),
                    ),
                  ),
                  AnimatedOpacity(
                    curve: Curves.bounceIn,
                    opacity: controller.isActionSuccess.value ? 0 : 1.0,
                    duration: Duration(milliseconds: 0),
                    child: loginWidget(),
                  ),
                ]),
          );
        });
  }

  // Login Widget
  loginWidget() {
    return Padding(
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
                controller: controller.nameController,
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
                controller: controller.passwordController,
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
                    controller.loginUser(context, userName, password);
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
    );
  }

  // Animation feedback Widget
  animatedFeedbackWidget() {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: <Widget>[
          Icon(
            Icons.menu_book,
            size: 80,
          ),
          Text("Welcome to Boockando, ${userName}!")
        ],
      ),
    );
  }
}
