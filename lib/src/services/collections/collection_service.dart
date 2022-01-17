import 'package:biblio/src/models/collection.dart';
import 'package:biblio/src/models/book.dart';

/// A service that stores and retrieves a collection.
///
/// By default, this class does not persist collection data. If you'd like to
/// persist the data locally, use the shared_preferences package. If
/// you'd like to store settings on a web server, use the http package.
class CollectionService {
  final String id;
  const CollectionService(this.id);
  Future<Collection> collection() async {
    await Future.delayed(const Duration(seconds: 1));
    return Collection(id, 'A1DDE5', 'Charlie and the Chocolate Factory',
        'Story about a boy in a chocolate factory', [], []);
  }

  /// Adds a book to the Collection
  Future<String> addBook(Book book) async {
    await Future.delayed(const Duration(seconds: 5));
    // TODO :
    // You will get a book with Temp ID
    // Store this book in local/ remote storage
    // and get back the server generated ID
    // var id = await storage(book);
    // return id;
    return DateTime.now().microsecondsSinceEpoch.toString();
  }

  /// Removes book with specified id from Collection
  Future<void> removeBook(String id) async {
    await Future.delayed(const Duration(seconds: 1));
  }

  /// Modifies a book with matching id from Collection
  Future<void> modifyBook(Book book) async {
    await Future.delayed(const Duration(seconds: 1));
  }

  /// Adds a fresh collection at the end
  Future<String> addCollection(Collection collection) async {
    await Future.delayed(const Duration(seconds: 5));
    // TODO :
    // You will get a collection with Temp ID
    // Store this collection in local/ remote storage
    // and get back the server generated ID
    // var id = await storage(collection);
    // return id;
    return DateTime.now().microsecondsSinceEpoch.toString();
  }

  /// Removes the collection along with all its children
  Future<void> removeCollection(String id) async {
    await Future.delayed(const Duration(seconds: 1));
  }

  /// Returns the List of Collections with specified ID
  /// If minimal, returns empty book and collection data
  Future<List<Collection>> getCollections(List<String> ids,
      {bool minimal = true}) async {
    await Future.delayed(const Duration(seconds: 1));
    return List.generate(
      ids.length,
      (index) => Collection(id, 'A1DDE5', 'Charlie and the Chocolate Factory',
          'Story about a boy in a chocolate factory', [], []),
    );
  }

  /// Returns the Collection with specified ID
  Future<Collection> getCollection(String id,
      {bool skipBookData = true}) async {
    await Future.delayed(const Duration(seconds: 1));
    return Collection(id, 'A1DDE5', 'Charlie and the Chocolate Factory',
        'Story about a boy in a chocolate factory', [], []);
  }

  /// Persists the user's preferred Collection Name to local or remote storage.
  Future<void> updateName(String name) async {
    await Future.delayed(const Duration(seconds: 1));
  }

  /// Persists the user's preferred Color to local or remote storage.
  Future<void> updateColor(String color) async {
    await Future.delayed(const Duration(seconds: 1));
  }
}

// Use the shared_preferences package to persist settings locally or the
// http package to persist settings over the network.
