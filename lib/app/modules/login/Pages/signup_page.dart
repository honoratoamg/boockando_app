import 'package:boockando_app/app/controllers/app_user_controller.dart';
import 'package:boockando_app/app/models/user.dart';
import 'package:boockando_app/app/repositories/shared/utils/validator_fields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SignUpPage extends StatefulWidget {
  static const routeName = "/signin";
  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<SignUpPage> {
  final userController = Modular.get<AppUserController>();
  final _formKey = GlobalKey<FormState>();
  String userName, password, email;

  AutovalidateMode isValidating = AutovalidateMode.disabled;
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

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
          autovalidateMode: isValidating,
          child: ListView(
            children: <Widget>[
              Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.all(10),
                  child: Center(
                    child: Text(
                      'Sign in user',
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
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  controller: emailController,
                  onChanged: (valor) => setState(() => email = valor),
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
                  child: Text('Sign in'),
                  onPressed: () {
                    isValidating = AutovalidateMode.always;
                    if (_formKey.currentState.validate()) {
                      final user = User(
                        name: userName,
                        password: password,
                        email: email,
                      );

                      userController.addUser(user);
                      Modular.to.pop();
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
