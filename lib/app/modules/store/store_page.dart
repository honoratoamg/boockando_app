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
          title: Text("Loja de livros"),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SizedBox(
                  height: 200,
                  child: Consumer<AppBookController>(
                      builder: (context, value) {
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
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {},
        ),
      ),
    );

  }
}
