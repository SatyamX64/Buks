import 'package:biblio/src/presentation/shared/utils/color.dart';
import 'package:biblio/src/presentation/shared/utils/font.dart';
import 'package:biblio/src/presentation/shared/views/loading_view.dart';
import 'package:biblio/src/presentation/views/collection/components/item_type_selector.dart';
import 'package:biblio/src/services/collections/collection_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/book.dart';
import '../../../models/collection.dart';
import 'components/components.dart';

/// Displays the content of a Collection
class CollectionView extends StatelessWidget {
  const CollectionView(
    this.collectionController, {
    Key? key,
  }) : super(key: key);

  static const routeName = '/collection';

  final CollectionController collectionController;

  // Glue the CollectionController to the ControllerView.
  //
  // The ChangeNotifierProvider Widget listens to the CollectionController for changes.
  // Whenever the user updates their collection, the CollectionView is rebuilt.

  @override
  Widget build(BuildContext context) {
    // Show a Loading indicator until the Initial Collection Data is Fetched
    return FutureBuilder(
      future: collectionController.loadCollection(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ChangeNotifierProvider.value(
            value: collectionController,
            child: Consumer<CollectionController>(
              builder: (context, collectionController, _) {
                final collection = collectionController.collection;
                final books = collectionController.collection.books;
                final collections = collectionController.collections;

                return Scaffold(
                  appBar: AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    centerTitle: true,
                    title: Text(
                      collection.name,
                      style: FontUtils.heading,
                    ),
                    actions: [
                      // TextButton(
                      //     onPressed: () {
                      //       print(collection);
                      //     },
                      //     child: const Text('Print')),
                      // TextButton(
                      //   onPressed: () {
                      //     collectionController.addBook(Book.fromMap(map));
                      //   },
                      //   child: const Text('Add Book'),
                      // ),
                      // TextButton(
                      //   onPressed: () {
                      //     collectionController
                      //         .addCollection(Collection.dummy());
                      //   },
                      //   child: const Text('Add Collection'),
                      // ),
                      // TextButton(
                      //   onPressed: () {
                      //     collectionController.updateName(
                      //         'Random Name ${Random().nextInt(100)}');
                      //   },
                      //   child: const Text('Change Name'),
                      // ),
                      IconButton(
                        onPressed: () {},
                        icon: Image.asset(
                          'assets/images/setting.png',
                        ),
                      ),
                    ],
                  ),
                  body: CustomScrollView(
                    slivers: [
                      CollectionList(collections),
                      BookList(books),
                    ],
                  ),
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.centerFloat,
                  floatingActionButton: FloatingActionButton.extended(
                    onPressed: () async {
                      final Map<String, String>? res =
                          await _dialogBuilder(context);
                      if (res != null) {
                        assert(res.containsKey('type'));
                        assert(res.containsKey('id'));
                        assert(res['id']!.startsWith('temp'));
                        if (res['type'] == ItemType.book.name) {
                          collectionController.addBook(
                            Book.fromMap(res),
                          );
                        } else if (res['type'] == ItemType.collection.name) {
                          collectionController.addCollection(
                            Collection.fromMap(res),
                          );
                        }
                      }
                    },
                    backgroundColor: ColorUtils.primary,
                    label: Text(
                      "+ Add Item",
                      style: FontUtils.textStyle,
                    ),
                  ),
                );
              },
            ),
          );
        } else {
          return const LoadingView();
        }
      },
    );
  }

  static _dialogBuilder(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => Center(
        child: Material(
          type: MaterialType.transparency,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.08,
                vertical: MediaQuery.of(context).size.height * 0.1),
            child: AspectRatio(
              aspectRatio:
                  MediaQuery.of(context).size.aspectRatio > 0.8 ? 1.44 : 0.60,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)),
                child: AddItemForm(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
