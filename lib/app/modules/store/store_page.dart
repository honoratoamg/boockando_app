import 'package:badges/badges.dart';
import 'package:boockando_app/app/controllers/app_book_controller.dart';
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
  final appBookOnlineController = Modular.get<AppBookController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Boockando Store"),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SizedBox(
                  height: 200,
                  child: Consumer<AppBookController>(builder: (context, value) {
                    return appBookOnlineController.books != null
                        ? StaggeredGridView.countBuilder(
                            crossAxisCount: 4,
                            itemCount: appBookOnlineController.books.length,
                            itemBuilder: (BuildContext context, int index) =>
                                BookWidget(
                              index: index,
                            ),
                            staggeredTileBuilder: (int index) =>
                                StaggeredTile.count(2, 3),
                            //StaggeredTile.count(2, 2),
                            //StaggeredTile.count(4, 2),
                          )
                        : CircularProgressIndicator();
                  })),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          icon: Icon(Icons.shopping_basket),
          label: basketBadge(context, 2),
          onPressed: () {},
        ),
      ),
    );
  }
}

Widget basketBadge(BuildContext context, int value) {
  return Badge(
    animationDuration: Duration(milliseconds: 300),
    animationType: BadgeAnimationType.scale,
    badgeContent: Text(
      value.toString(),
    ),
    badgeColor: Theme.of(context).cardColor,
  );
}
