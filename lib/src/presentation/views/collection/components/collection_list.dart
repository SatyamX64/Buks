import 'package:biblio/src/models/collection.dart';
import 'package:biblio/src/presentation/views/collection/collection_view.dart';
import 'package:biblio/src/services/collections/collection_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CollectionList extends StatelessWidget {
  const CollectionList(this.collections, {Key? key}) : super(key: key);

  final List<Collection> collections;
  @override
  Widget build(BuildContext context) {
    final collectionController = context.read<CollectionController>();
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        final item = collections[index];

        return ListTile(
          title: Text(item.name),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(
                  onPressed: () {
                    collectionController.removeCollection(item.id);
                  },
                  child: const Text('Delete')),
              TextButton(
                  onPressed: () {
                    print(item);
                  },
                  child: const Text('Print')),
            ],
          ),
          onTap: item.id.startsWith('temp')
              ? () {
                  // TODO:
                  // The Collection is yet to be uploaded on backend and only exists temporarily in memory.
                }
              : () async {
                  // Navigate to the collections view with the specified collection as parent. If the user leaves and returns to
                  // the app after it has been killed while running in the
                  // background, the navigation stack is restored.
                  Navigator.restorablePushNamed(
                    context,
                    CollectionView.routeName,
                    arguments: item.id,
                  );
                },
        );
      }, childCount: collections.length),
    );
  }
}
