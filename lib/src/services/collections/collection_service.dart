import 'package:biblio/src/models/collection.dart';
import 'package:biblio/src/models/book.dart';

/// A service that stores and retrieves a collection.
///
/// By default, this class does not persist collection data. If you'd like to
/// persist the data locally, use the shared_preferences package. If
/// you'd like to store settings on a web server, use the http package.

// Use the shared_preferences package to persist settings locally or the
// http package to persist settings over the network.

abstract class CollectionService {
  final String id;
  const CollectionService(this.id);

  /// Returns Collection for the ID specified to Service
  Future<Collection> collection();

  /// Adds a book to the Collection
  Future<String> addBook(Book book);
  // You will get a book with Temp ID
  // Store this book in local/ remote storage
  // and get back the server generated ID
  // var id = await storage(book);
  // return id;

  /// Removes book with specified id from Collection
  Future<void> removeBook(String id);

  /// Modifies a book with matching id from Collection
  Future<void> modifyBook(Book book);

  /// Adds a fresh collection at the end
  Future<String> addCollection(Collection collection);
  // You will get a collection with Temp ID
  // Store this collection in local/ remote storage
  // and get back the server generated ID
  // var id = await storage(collection);
  // return id;

  /// Removes the collection along with all its children
  Future<void> removeCollection(String id);

  /// Returns the List of Collections with specified ID
  /// If minimal, returns collection with empty list for books
  Future<List<Collection>> getCollections(List<String> ids,
      {bool minimal = true});

  /// Returns the Collection with specified ID
  /// If minimal, returns collection with empty list for books
  Future<Collection> getCollection(String id, {bool minimal = true});

  /// Persists the user's preferred Collection Name to local or remote storage.
  Future<void> updateName(String name);
}

class MockCollectionService implements CollectionService {
  @override
  final String id;
  const MockCollectionService(this.id);

  @override
  Future<Collection> collection() async {
    await Future.delayed(const Duration(milliseconds: 2000));
    return Collection(
        id, 'Library', 'I store all my books here', <String>[], <Book>[]);
  }

  @override

  /// Adds a book to the Collection
  Future<String> addBook(Book book) async {
    await Future.delayed(const Duration(milliseconds: 2000));
    return DateTime.now().microsecondsSinceEpoch.toString();
  }

  @override

  /// Removes book with specified id from Collection
  Future<void> removeBook(String id) async {
    await Future.delayed(const Duration(milliseconds: 2000));
  }

  @override

  /// Modifies a book with matching id from Collection
  Future<void> modifyBook(Book book) async {
    await Future.delayed(const Duration(milliseconds: 2000));
  }

  @override

  /// Adds a fresh collection at the end
  Future<String> addCollection(Collection collection) async {
    await Future.delayed(const Duration(milliseconds: 2000));
    return DateTime.now().microsecondsSinceEpoch.toString();
  }

  @override

  /// Removes the collection along with all its children
  Future<void> removeCollection(String id) async {
    await Future.delayed(const Duration(milliseconds: 2000));
  }

  @override

  /// Returns the List of Collections with specified ID
  /// If minimal, returns empty book and collection data
  Future<List<Collection>> getCollections(List<String> ids,
      {bool minimal = true}) async {
    await Future.delayed(const Duration(milliseconds: 2000));
    return List.generate(
      ids.length,
      (index) => Collection(id, 'Library', 'I store all my books here', [], []),
    );
  }

  @override

  /// Returns the Collection with specified ID
  Future<Collection> getCollection(String id, {bool minimal = true}) async {
    await Future.delayed(const Duration(milliseconds: 2000));
    return Collection(id, 'Library', 'I store all my books here', [], []);
  }

  @override

  /// Persists the user's preferred Collection Name to local or remote storage.
  Future<void> updateName(String name) async {
    await Future.delayed(const Duration(milliseconds: 2000));
  }
}
