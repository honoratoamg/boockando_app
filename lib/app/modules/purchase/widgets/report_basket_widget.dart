import 'package:boockando_app/app/controllers/app_book_controller.dart';
import 'package:boockando_app/app/models/basket_books.dart';
import 'package:boockando_app/app/models/book.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../purchase_controller.dart';

class ReportBaskedWidget extends StatefulWidget {
  const ReportBaskedWidget({Key key, this.basketBooks}) : super(key: key);
  final BasketBooks basketBooks;

  @override
  _ReportBaskedWidgetState createState() => _ReportBaskedWidgetState();
}

class _ReportBaskedWidgetState extends State<ReportBaskedWidget> {
  final bookController = Modular.get<AppBookController>();
  final purchaseController = Modular.get<PurchaseController>();
  BasketBooks tempBasket;

  @override
  void initState() {
    super.initState();
    tempBasket = widget.basketBooks;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).cardColor.withAlpha(150),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          children: [
            Icon(Icons.book, size: 40),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    FutureBuilder(
                      future: bookController.getBookById(tempBasket.bookId),
                      builder:
                          (BuildContext context, AsyncSnapshot<Book> snapshot) {
                        if (snapshot.hasData) {
                          return Text(snapshot.data.title);
                        } else {
                          return Text('Book not found');
                        }
                      },
                    ),
                  ]),
                  Row(
                    children: [
                      Icon(Icons.attach_money, size: 30, color: Colors.green),
                      Text(widget.basketBooks.bookPrice.toString()),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              children: [Text('Qty: ${tempBasket.bookQtd.toString()}')],
            ),
          ],
        ),
      ]),
    );
  }
}
