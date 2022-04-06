import 'dart:convert';

class UserModel {
  final String email;
  final String id;
  UserModel({
    required this.email,
    required this.id,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel && other.email == email && other.id == id;
  }

  @override
  int get hashCode => email.hashCode ^ id.hashCode;

  @override
  String toString() => 'UserModel(email: $email, id: $id)';

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'id': id,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] ?? '',
      id: map['id'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  UserModel copyWith({
    String? email,
    String? id,
  }) {
    return UserModel(
      email: email ?? this.email,
      id: id ?? this.id,
    );
  }
}
