import 'dart:convert';

import 'package:boockando_app/app/controllers/app_basket_controller.dart';
import 'package:boockando_app/app/controllers/app_book_controller.dart';
import 'package:boockando_app/app/models/book.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class BookBasketWidget extends StatefulWidget {
  const BookBasketWidget({Key key, this.index}) : super(key: key);

  final int index;

  @override
  _BookBasketWidgetState createState() => _BookBasketWidgetState();
}

class _BookBasketWidgetState extends State<BookBasketWidget>
    implements Disposable {
  final basketController = Modular.get<AppBasketController>();
  final appBookController = Modular.get<AppBookController>();
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  Book tempBook;
  var base64;

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    numberController.dispose();
  }

  @override
  void initState() {
    super.initState();
    tempBook = appBookController
        .getBookById(basketController.userBasketBooks[widget.index].bookId);
    nameController.text = tempBook.title;
    numberController.text = tempBook.price.toString();

    if (!appBookController.hasInternet) {
      base64 = base64Decode(tempBook.bookImage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).cardColor.withAlpha(150),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          children: [
            imageOfBook(tempBook, base64),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.menu_book_outlined,
                          size: 30, color: Colors.teal),
                      Flexible(
                        child: TextFormField(
                          controller: nameController,
                          readOnly: true,
                          decoration: InputDecoration(
                              isDense: true,
                              border: InputBorder.none,
                              hintText: "Book's Title"),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.attach_money, size: 30, color: Colors.green),
                      Flexible(
                          child: TextFormField(
                        controller: numberController,
                        readOnly: true,
                        decoration: InputDecoration(
                            isDense: true,
                            border: InputBorder.none,
                            hintText: "Book's Price"),
                      ))
                    ],
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Text(
                    "qty: ${basketController.userBasketBooks[widget.index].bookQtd}"),
                Row(
                  children: [
                    IconButton(
                        icon: Icon(Icons.add_circle),
                        onPressed: () => setState(() {
                              basketController.basketAddBook(tempBook);
                            })),
                    IconButton(
                        icon: Icon(Icons.remove_circle),
                        onPressed: () {
                          basketController.basketRemoveBook(tempBook);
                        }),
                  ],
                ),
              ],
            ),
          ],
        ),
      ]),
    );
  }
}

Widget imageOfBook(Book book, var memoryImage) {
  final appBookOnlineController = Modular.get<AppBookController>();

  return (appBookOnlineController.hasInternet)
      ? Image.network(
          book.bookImage,
          height: 60,
          width: 60,
        )
      : Image.memory(memoryImage);
}
