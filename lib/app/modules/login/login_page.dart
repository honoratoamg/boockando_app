import 'package:boockando_app/app/modules/login/login_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

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
      ),
    );
  }
}
