import 'package:badges/badges.dart';
import 'package:boockando_app/app/controllers/app_basket_controller.dart';
import 'package:boockando_app/app/controllers/app_book_controller.dart';
import 'package:boockando_app/app/models/book.dart';
import 'package:boockando_app/app/modules/store/page/basket_page.dart';
import 'package:boockando_app/app/modules/store/widget/book_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class StorePage extends StatefulWidget {
  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  final appBookController = Modular.get<AppBookController>();
  final appBasketController = Modular.get<AppBasketController>();

  @override
  void initState() {
    super.initState();
    appBookController.selectedCategory = 'All books';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            title: ValueListenableBuilder(
          valueListenable: appBasketController.totalValue,
          builder: (context, value, child) {
            return Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text(
                    "Bookando Store R\$ ${appBasketController.totalValue.value}"),
              ),
            );
          },
        )),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              DropdownButton(
                icon: Icon(Icons.category),
                iconSize: 20,
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                value: appBookController.selectedCategory,
                onChanged: (newValue) {
                  setState(() {
                    appBookController.selectedCategory = newValue;
                  });
                },
                items: <String>[
                  'All books',
                  'Classics',
                  'Fantasy',
                  'Horror',
                  'Literary Fiction'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(width: 15),
              IconButton(
                  icon: Icon(Icons.grid_view),
                  onPressed: () {
                    appBookController.setDesign(StaggeredTile.count(2, 4));
                  }),
              IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: () {
                    appBookController.setDesign(StaggeredTile.count(4, 4));
                  }),
            ]),
            Flexible(
              child: Consumer<AppBookController>(builder: (context, value) {
                return (appBookController.books != null)
                    ? FutureBuilder(
                        future: appBookController.getBooksByCategory(
                            appBookController.selectedCategory),
                        builder: (context, AsyncSnapshot<List<Book>> snapshot) {
                          if (snapshot.hasData) {
                            return StaggeredGridView.countBuilder(
                              crossAxisCount: 4,
                              itemCount: snapshot.data.length,
                              itemBuilder: (BuildContext context, int index) =>
                                  BookWidget(
                                      key: UniqueKey(),
                                      index: index,
                                      book: snapshot.data[index]),
                              staggeredTileBuilder: (int index) =>
                                  appBookController.layoutDesign,
                            );
                          } else {
                            return CircularProgressIndicator();
                          }
                        })
                    : CircularProgressIndicator();
              }),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          icon: Icon(Icons.shopping_basket),
          label: Consumer<AppBasketController>(builder: (context, value) {
            return basketBadge(context, appBasketController.amountBooks.value);
          }),
          onPressed: () {
            Navigator.pushNamed(context, BasketPage.routeName);
          },
        ),
      ),
    );
  }
}

Widget basketBadge(BuildContext context, int value) {
  return Badge(
    animationDuration: Duration(milliseconds: 1),
    animationType: BadgeAnimationType.scale,
    badgeContent: Text(
      value.toString(),
      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
    ),
    badgeColor: Theme.of(context).buttonColor,
  );
}
