import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:boockando_app/app/controllers/app_basket_controller.dart';
import 'package:boockando_app/app/controllers/app_book_controller.dart';
import 'package:boockando_app/app/models/book.dart';

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

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    numberController.dispose();
  }

  @override
  void initState() {
    super.initState();
    tempBook = appBookController.getBookOnMemoryById(
        basketController.userBasketBooks[widget.index].bookId);
    nameController.text = tempBook.title;
    numberController.text = tempBook.price.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).cardColor.withAlpha(150),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          children: [
            Icon(Icons.book, size: 60),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: TextFormField(
                          controller: nameController,
                          readOnly: true,
                          decoration: InputDecoration(
                              isDense: true, border: InputBorder.none),
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
                            isDense: true, border: InputBorder.none),
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
                        color: Theme.of(context).buttonColor,
                        onPressed: () => setState(() {
                              basketController.basketAddBook(tempBook);
                            })),
                    IconButton(
                        icon: Icon(Icons.remove_circle),
                        color: Theme.of(context).buttonColor,
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
