import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:basicfitsmartbooking/Models/friend.dart';

class User {
  final int id;
  final String people_id_g;
  final String id_s;
  final String email;
  final String pwd;
  final List<Friend> friends;
  User(
      {required this.email,
      required this.pwd,
      required this.friends,
      required this.id,
      required this.people_id_g,
      required this.id_s});

  User copyWith(
      {String? email,
      String? pwd,
      List<Friend>? friends,
      int? id,
      String? people_id_g,
      String? id_s}) {
    return User(
        email: email ?? this.email,
        pwd: pwd ?? this.pwd,
        friends: friends ?? this.friends,
        id: id ?? this.id,
        people_id_g: people_id_g ?? this.people_id_g,
        id_s: id_s ?? this.id_s);
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'pwd': pwd,
      'friends': friends.map((x) => x.toMap()).toList(),
      'id': id,
      'people_id_g': people_id_g,
      'id_s': id_s
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      email: map['email'] ?? '',
      pwd: map['pwd'] ?? '',
      friends: List<Friend>.from(
          map['friends']?.map((x) => Friend.fromMap(x)) ?? []),
      id_s: map['id_s'] ?? '',
      id: map['id'] ?? -1,
      people_id_g: map['people_id_g'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() =>
      'User(email: $email, pwd: $pwd, id: $id, people_id_g: $people_id_g, id_s: $id_s friends: $friends)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.email == email &&
        other.pwd == pwd &&
        other.id == id &&
        other.people_id_g == people_id_g &&
        other.id_s == id_s &&
        listEquals(other.friends, friends);
  }

  @override
  int get hashCode =>
      email.hashCode ^
      pwd.hashCode ^
      friends.hashCode ^
      id.hashCode ^
      people_id_g.hashCode ^
      id_s.hashCode;
}
