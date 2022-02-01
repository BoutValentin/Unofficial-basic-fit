import 'dart:convert';

class Friend {
  final String people_id_g;
  final String id_g;
  final String first_name_g;
  final String last_name_g;
  final String name_g;
  final String email;
  Friend({
    required this.people_id_g,
    required this.id_g,
    required this.first_name_g,
    required this.last_name_g,
    required this.name_g,
    required this.email,
  });

  Friend copyWith({
    String? people_id_g,
    String? id_g,
    String? first_name_g,
    String? last_name_g,
    String? name_g,
    String? email,
  }) {
    return Friend(
      people_id_g: people_id_g ?? this.people_id_g,
      id_g: id_g ?? this.id_g,
      first_name_g: first_name_g ?? this.first_name_g,
      last_name_g: last_name_g ?? this.last_name_g,
      name_g: name_g ?? this.name_g,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'people_id_g': people_id_g,
      'id_g': id_g,
      'first_name_g': first_name_g,
      'last_name_g': last_name_g,
      'name_g': name_g,
      'email': email,
    };
  }

  factory Friend.fromMap(Map<String, dynamic> map) {
    return Friend(
      people_id_g: map['people_id_g'] ?? '',
      id_g: map['id_g'] ?? '',
      first_name_g: map['first_name_g'] ?? '',
      last_name_g: map['last_name_g'] ?? '',
      name_g: map['name_g'] ?? '',
      email: map['email'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Friend.fromJson(String source) => Friend.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Friend(people_id_g: $people_id_g, id_g: $id_g, first_name_g: $first_name_g, last_name_g: $last_name_g, name_g: $name_g, email: $email)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Friend &&
        other.people_id_g == people_id_g &&
        other.id_g == id_g &&
        other.first_name_g == first_name_g &&
        other.last_name_g == last_name_g &&
        other.name_g == name_g &&
        other.email == email;
  }

  @override
  int get hashCode {
    return people_id_g.hashCode ^
        id_g.hashCode ^
        first_name_g.hashCode ^
        last_name_g.hashCode ^
        name_g.hashCode ^
        email.hashCode;
  }
}
