import 'package:boockando_app/app/controllers/app_user_controller.dart';
import 'package:boockando_app/app/repositories/shared/utils/validator_fields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../login_controller.dart';

class SignUpPage extends StatefulWidget {
  static const routeName = "/signin";
  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<SignUpPage> {
  AutovalidateMode isValidating = AutovalidateMode.disabled;
  final controller = Modular.get<LoginController>();
  final userController = Modular.get<AppUserController>();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    controller.initializeFieldsOfLoggedUser();
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
          autovalidateMode: isValidating,
          child: ListView(
            children: <Widget>[
              Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.all(10),
                  child: Center(
                    child: (userController.loggedUser == null)
                        ? Text('Sign in user')
                        : Text('Edit your account'),
                  )),
              Container(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  controller: controller.nameSgnController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Username',
                  ),
                  validator: (String submittedValue) {
                    if (submittedValue.isEmpty) {
                      return "Username can't be empty!";
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 5),
              Container(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  controller: controller.passwordSgnController,
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
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
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  controller: controller.emailSgnController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                  validator: (String submittedValue) {
                    final emailValidator =
                        Validator.validateEmail(submittedValue);
                    if (!emailValidator) {
                      return 'Invalid E-mail!';
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
                  child: (userController.loggedUser == null)
                      ? Text('Sign in')
                      : Text('Confirm'),
                  onPressed: () async {
                    isValidating = AutovalidateMode.always;
                    if (_formKey.currentState.validate()) {
                      controller.userSignOrUpdate(context);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
