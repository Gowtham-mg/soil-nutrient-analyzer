import 'dart:convert';

class User {
  final String email;
  final String password;
  final String id;
  User.named({
    this.email,
    this.password,
    this.id,
  });
  User(this.email, this.password, this.id);

  User copyWith({
    String email,
    String password,
    String id,
  }) {
    return User.named(
      email: email ?? this.email,
      password: password ?? this.password,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
      'id': id,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User.named(
      email: map['email'],
      password: map['password'],
      id: map['id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() => 'User(email: $email, password: $password, id: $id)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.email == email &&
        other.password == password &&
        other.id == id;
  }

  @override
  int get hashCode => email.hashCode ^ password.hashCode ^ id.hashCode;
}
