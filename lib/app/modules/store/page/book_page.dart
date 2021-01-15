import 'package:boockando_app/app/controllers/app_book_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class BookPageArguments {
  BookPageArguments({this.index});
  int index;
}

class BookPage extends StatefulWidget {
  static const routeName = '/bookPage';
  BookPage({this.index});
  final int index;

  @override
  _BookPageState createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> implements Disposable {
  final appBookOnlineController = Modular.get<AppBookController>();
  TextEditingController nameController = TextEditingController();
  TextEditingController aboutController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    aboutController.dispose();
  }

  @override
  void initState() {
    super.initState();
    nameController.text = appBookOnlineController.books[widget.index].title;
    aboutController.text = appBookOnlineController.books[widget.index].about;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          decoration: InputDecoration(isDense: true,
              border: InputBorder.none,
              hintText: "Book's title"),
          minLines: 1,
          textAlign: TextAlign.center,
          controller: nameController,
          readOnly: true,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Center(
                child: Image.network(
                    appBookOnlineController.books[widget.index].bookImage),
              ),
            ),
            Center(
              child: Text(
                  'R\$: ${appBookOnlineController.books[widget.index].price.toString()}',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            Text('About the book:',
                style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(3.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                ),
              ),
              child: TextFormField(
                decoration: InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    hintText: 'About book'),
                maxLines: 10,
                textAlign: TextAlign.justify,
                controller: aboutController,
                style: TextStyle(fontWeight: FontWeight.normal),
                readOnly: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
