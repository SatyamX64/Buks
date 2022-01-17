import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';

import 'book.dart';

class Collection {
  final String id;
  final String color;
  final String name;
  final String story;

  final List<String> collectionIDs;

  /// Contains the reference ID for all the Collections
  final List<Book> books;

  const Collection(this.id, this.color, this.name, this.story,
      this.collectionIDs, this.books);

  factory Collection.dummy() {
    return Collection(
        'temp_${DateTime.now().millisecondsSinceEpoch}',
        'f3abf4',
        'Dummy Collection ${Random().nextInt(100)}',
        'Description of the Collection', [], []);
  }
  Collection copyWith({
    String? id,
    String? color,
    String? name,
    String? story,
    List<String>? collectionIDs,
    List<Book>? books,
  }) {
    return Collection(
      id ?? this.id,
      color ?? this.color,
      name ?? this.name,
      story ?? this.story,
      collectionIDs ?? this.collectionIDs,
      books ?? this.books,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'color': color,
      'name': name,
      'story': story,
      'collectionsIDs': collectionIDs,
      'books': books.map((x) => x.toMap()).toList(),
    };
  }

  factory Collection.fromMap(Map<String, dynamic> map) {
    return Collection(
      map['id'] ?? '',
      map['color'] ?? '',
      map['name'] ?? '',
      map['story'] ?? '',
      List<String>.from(map['collectionsIDs']),
      List<Book>.from(map['books']?.map((x) => Book.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Collection.fromJson(String source) =>
      Collection.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Collection &&
        other.id == id &&
        other.color == color &&
        other.name == name &&
        other.story == story &&
        listEquals(other.collectionIDs, collectionIDs) &&
        listEquals(other.books, books);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        color.hashCode ^
        name.hashCode ^
        story.hashCode ^
        collectionIDs.hashCode ^
        books.hashCode;
  }

  @override
  String toString() {
    return 'Collection(id: $id, color: $color, name: $name, story: $story, collectionIDs: $collectionIDs, books: $books)';
  }
}
