import 'package:boockando_app/app/controllers/app_book_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class BookWidget extends StatefulWidget {
  BookWidget({this.index});
  final int index;

  @override
  _BookWidgetState createState() => _BookWidgetState();
}

class _BookWidgetState extends State<BookWidget> implements Disposable {
  final appBookOnlineController = Modular.get<AppBookController>();
  TextEditingController nameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
  }

  @override
  void initState() {
    super.initState();
    nameController.text = appBookOnlineController.books[widget.index].title;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.all(10.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Image.network(
                  appBookOnlineController.books[widget.index].bookImage),
            ),
            TextFormField(
              controller: nameController,
              readOnly: true,
            ),
            IconButton(icon: Icon(Icons.add_circle_outline), onPressed: null)
          ],
        ),
      ),
    );
  }
}
