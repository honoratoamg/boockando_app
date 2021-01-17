import 'dart:convert';

import 'package:boockando_app/app/controllers/app_basket_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:boockando_app/app/controllers/app_book_controller.dart';
import 'package:boockando_app/app/models/book.dart';
import 'package:boockando_app/app/modules/store/page/book_page.dart';

class BookWidget extends StatefulWidget {
  BookWidget({this.index});
  final int index;

  @override
  _BookWidgetState createState() => _BookWidgetState();
}

class _BookWidgetState extends State<BookWidget> implements Disposable {
  final appBookOnlineController = Modular.get<AppBookController>();
  final appBasketOnlineController = Modular.get<AppBasketController>();
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  var base64;

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
  }

  @override
  void initState() {
    super.initState();
    nameController.text = appBookOnlineController.books[widget.index].title;
    if (!appBookOnlineController.hasInternet) {
      base64 =
          base64Decode(appBookOnlineController.books[widget.index].bookImage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, BookPage.routeName,
            arguments: BookPageArguments(index: widget.index));
      },
      child: Container(
        margin: const EdgeInsets.all(10.0),
        padding: const EdgeInsets.all(10.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: imageOfBook(
                    appBookOnlineController.books[widget.index], base64),
              ),
              TextFormField(
                decoration: InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    hintText: "Book's Title"),
                minLines: 1,
                controller: nameController,
                readOnly: true,
              ),
              Text(
                  'R\$: ${appBookOnlineController.books[widget.index].price.toString()}'),
              FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    side: BorderSide(color: Colors.red)),
                padding: EdgeInsets.all(5.0),
                onPressed: () {
                  appBasketOnlineController.basketAddBook(
                      appBookOnlineController.books[widget.index]);
                },
                child: Text(
                  "Add to Basket".toUpperCase(),
                ),
              ),
              //IconButton(icon: Icon(Icons.add_circle_outline), onPressed: null)
            ],
          ),
        ),
      ),
    );
  }
}

Widget imageOfBook(Book book, var memoryImage) {
  final appBookOnlineController = Modular.get<AppBookController>();

  return (appBookOnlineController.hasInternet)
      ? Image.network(book.bookImage)
      : Image.memory(memoryImage);
}
