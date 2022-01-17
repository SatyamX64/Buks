import 'dart:convert';

import 'dart:math';

class Book {
  const Book(
      {required this.id,
      required this.color,
      required this.file,
      required this.name,
      required this.story});

  final String name;
  final String? story;
  final String color;
  final String file;
  final String id;

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'story': story,
      'color': color,
      'file': file,
      'id': id,
    };
  }

  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      name: map['name'],
      story: map['story'],
      color: map['color'],
      file: map['file'],
      id: map['id'],
    );
  }

  factory Book.dummy() {
    return Book(
        id: 'temp_${DateTime.now().millisecondsSinceEpoch}',
        name: 'Dummy Book ${Random().nextInt(100)}',
        story: 'A dummy book',
        file:
            "https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf",
        color: "ddf1ff");
  }

  String toJson() => json.encode(toMap());

  factory Book.fromJson(String source) => Book.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Book(name: $name, story: $story, color: $color, file: $file, id: $id)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Book &&
        other.name == name &&
        other.story == story &&
        other.color == color &&
        other.file == file &&
        other.id == id;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        story.hashCode ^
        color.hashCode ^
        file.hashCode ^
        id.hashCode;
  }

  Book copyWith({
    String? name,
    String? story,
    String? color,
    String? file,
    String? id,
  }) {
    return Book(
      name: name ?? this.name,
      story: story ?? this.story,
      color: color ?? this.color,
      file: file ?? this.file,
      id: id ?? this.id,
    );
  }
}
