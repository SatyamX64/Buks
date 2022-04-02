import 'package:biblio/src/models/book.dart';
import 'package:biblio/src/models/collection.dart';
import 'package:flutter/material.dart';

import 'collection_service.dart';

/// A class that many Widgets can interact with to read collection, update
/// collection, or listen to collection changes.
///
/// Controllers glue Data Services to Flutter Widgets. The CollectionController
/// uses the CollectionService to store and retrieve collection.
class CollectionController with ChangeNotifier {
  CollectionController(this._collectionService);

  // Make CollectionService a private variable so it is not used directly.
  final CollectionService _collectionService;

  // Make Collection a private variable so it is not updated directly without
  // also persisting the changes with the CollectionService.
  late Collection _collection;

  // Contains the list of all the Child Collections
  late List<Collection> _collections;

  // Allow Widgets to read the collection.
  Collection get collection => _collection;

  // Allow Widgets to read the child collections.
  List<Collection> get collections => _collections;

  /// Load the collection from the CollectionService. It may load from a
  /// local database or the internet. The controller only knows it can load the
  /// collection from the service.
  Future<void> loadCollection() async {
    _collection = await _collectionService.collection();
    _collections =
        await _collectionService.getCollections(_collection.collectionIDs);
    // Important! Inform listeners a change has occurred.
    notifyListeners();
  }

  /// Adds a new book to the Collection
  Future<void> addBook(Book book) async {
    // Do not perform any work if a book already exists
    if (_collection.books.contains(book)) return;

    // Otherwise, store the new Book in memory
    final books = [..._collection.books, book];
    _collection = _collection.copyWith(books: books);

    // Important! Inform listeners a change has occurred.
    notifyListeners();

    // Persist the changes to a local database or the internet using the
    // CollectionService.
    var id = await _collectionService.addBook(book);

    // Update the ID of new Book in memory
    final index = _collection.books.indexOf(book);
    final updatedBooks = [..._collection.books]
      ..removeAt(index)
      ..insert(index, book.copyWith(id: id));
    _collection = _collection.copyWith(books: updatedBooks);

    // Important! Inform listeners a change has occurred.
    notifyListeners();
  }

  Future<void> removeBook(Book book) async {
    // Do not perform any work if the book doesn't exists
    if (!_collection.books.contains(book)) return;

    // Otherwise, delete the Book from memory
    final books = [..._collection.books]..remove(book);
    _collection = _collection.copyWith(books: books);

    // Important! Inform listeners a change has occurred.
    notifyListeners();

    // Persist the changes to a local database or the internet using the
    // CollectionService.
    await _collectionService.removeBook(book.id);
  }

  Future<void> modifyBook(Book book) async {
    // Find if book exists, and store its index
    final index = _collection.books.indexOf(book);

    // Do not perform any work if the book doesn't exists
    if (index == -1) return;

    var books = [..._collection.books]..removeAt(index);
    books = books..insert(index, book);
    _collection = _collection.copyWith(books: books);

    // Important! Inform listeners a change has occurred.
    notifyListeners();

    // Persist the changes to a local database or the internet using the
    // CollectionService.
    await _collectionService.modifyBook(book);
  }

  /// Adds a new child collection to the Collection
  Future<void> addCollection(Collection collection) async {
    // Do not perform any work if child collection already exists
    if (_collection.collectionIDs.contains(collection.id)) return;

    // Otherwise, store the new collection in Memory
    _collections.add(collection);
    final collectionIDs = [..._collection.collectionIDs, collection.id];
    _collection = _collection.copyWith(collectionIDs: collectionIDs);

    // Important! Inform listeners a change has occurred.
    notifyListeners();

    // Persist the changes to a local database or the internet using the
    // CollectionService.
    var id = await _collectionService.addCollection(collection);

    // Update the ID of new Collections in memory
    final index = _collection.collectionIDs.indexOf(collection.id);
    final updatedCollectionIDs = [..._collection.collectionIDs]
      ..removeAt(index)
      ..insert(index, id);
    _collection = _collection.copyWith(collectionIDs: updatedCollectionIDs);
    _collections.removeAt(index);
    _collections.insert(index, collection.copyWith(id: id));

    // Important! Inform listeners a change has occurred.
    notifyListeners();
  }

  Future<void> removeCollection(String id) async {
    // Do not perform any work if the child collection doesn't exists
    if (!_collection.collectionIDs.contains(id)) {
      return;
    }

    // Otherwise, delete the Collection from memory
    final collectionIDs = [..._collection.collectionIDs]..remove(id);
    _collection = _collection.copyWith(collectionIDs: collectionIDs);
    _collections.removeWhere((c) => c.id == id);
    // Important! Inform listeners a change has occurred.
    notifyListeners();

    // Persist the changes to a local database or the internet using the
    // CollectionService.
    await _collectionService.removeCollection(id);
  }

  Future<void> updateName(String name) async {
    // Do not perform any work if the name is same as current one
    if (_collection.name == name) {
      return;
    }

    // Otherwise change the name
    _collection = _collection.copyWith(name: name);

    // Important! Inform listeners a change has occurred.
    notifyListeners();

    // Persist the changes to a local database or the internet using the
    // CollectionService.
    await _collectionService.updateName(name);
  }

  // Future<void> updateColor(String color) async {
  //   // Do not perform any work if the color is same as current one
  //   if (_collection.color == color) {
  //     return;
  //   }

  //   // Otherwise change the color
  //   _collection = _collection.copyWith(color: color);

  //   // Important! Inform listeners a change has occurred.
  //   notifyListeners();

  //   // Persist the changes to a local database or the internet using the
  //   // CollectionService.
  //   await _collectionService.updateColor(color);
  // }
}
