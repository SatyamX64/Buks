import 'package:biblio/src/models/book.dart';
import 'package:biblio/src/services/collections/collection_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:developer' as dev;

class BookList extends StatelessWidget {
  const BookList(this.books, {Key? key}) : super(key: key);

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  final List<Book> books;
  @override
  Widget build(BuildContext context) {
    final collectionController = context.read<CollectionController>();
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        final item = books[index];

        return ListTile(
            title: Text(item.name),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(
                    onPressed: () {
                      collectionController.removeBook(item.id);
                    },
                    child: const Text('Delete')),
                TextButton(onPressed: () {}, child: const Text('Modify')),
                TextButton(
                    onPressed: () {
                      print(item);
                    },
                    child: const Text('Print')),
              ],
            ),
            onTap: () async {
              // Open the PDF from the given URL / Path
              // If it is URL use url_launcher
              // If it is file path use some other package
              
              try {
                await _launchURL(item.file);
              } catch (e) {
                dev.log(e.toString());
              }
            });
      }, childCount: books.length),
    );
  }
}
