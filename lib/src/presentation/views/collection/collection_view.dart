import 'dart:math';

import 'package:biblio/src/models/book.dart';
import 'package:biblio/src/models/collection.dart';
import 'package:biblio/src/presentation/shared/views/loading_view.dart';
import 'package:biblio/src/services/collections/collection_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
                      title: Text(collection.name),
                      actions: [
                        TextButton(
                            onPressed: () {
                              print(collection);
                            },
                            child: const Text('Print')),
                        TextButton(
                          onPressed: () {
                            collectionController.addBook(Book.dummy());
                          },
                          child: const Text('Add Book'),
                        ),
                        TextButton(
                          onPressed: () {
                            collectionController
                                .addCollection(Collection.dummy());
                          },
                          child: const Text('Add Collection'),
                        ),
                        TextButton(
                          onPressed: () {
                            collectionController.updateName(
                                'Random Name ${Random().nextInt(100)}');
                          },
                          child: const Text('Change Name'),
                        ),
                      ],
                    ),
                    body: CustomScrollView(
                      slivers: [
                        BookList(books),
                        CollectionList(collections)
                      ],
                    ),
                  );
                },
              ),
            );
          } else {
            return const LoadingView();
          }
        });
  }
}



