import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AlertsUtils {
  static showAlert(BuildContext context, String title, String message) {
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

  static connectionFailed(BuildContext context) {
    showAlert(context, "Connection Error!",
        "Please verify your connection or try again later.");
  }

  static
      unexpectedError(BuildContext context) {
    showAlert(context, "Unexpected Erro!",
        "Try again later.");
  }
}
